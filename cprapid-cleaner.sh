#!/bin/bash

LOG_FILE="/var/log/clean_cprapid_domains.log"
DRY_RUN=false

log_message() {
    local message="$1"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $message" | tee -a "$LOG_FILE"
}

usage() {
    echo "Kullanim: $0 [-d|--dry-run]"
    echo "       -d, --dry-run       sumule modu."
    exit 1
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--dry-run) DRY_RUN=true ;;
        *) usage ;;
    esac
    shift
done

log_message "cprapid.com temizleme betigi baslatiliyor. calisma modu: $DRY_RUN"

log_message "cprapid.com iceren alan adlari taraniyor."
CPRAPID_DOMAINS=$(whmapi1 --output=jsonpretty get_domain_info | jq -r '.data.domains[].domain' | grep "cprapid.com")

if [ -z "$CPRAPID_DOMAINS" ]; then
    log_message "cprapid.com iceren alan adi bulunamadi."
    exit 0
fi

log_message "Islenecek asagidaki etki alanlari bulundu:"
echo "$CPRAPID_DOMAINS" | tee -a "$LOG_FILE"

for domain in $CPRAPID_DOMAINS; do
    log_message "Alanadi: $domain"

    if [ "$DRY_RUN" = false ]; then
        log_message "Etki alani siliniyor: $domain"
        DELETE_RESULT=$(whmapi1 --output=jsonpretty delete_domain domain="$domain")
        if [[ $(echo "$DELETE_RESULT" | jq -r '.metadata.result') -eq 1 ]]; then
            log_message "'$domain' alan adi basariyla silindi."
        else
            log_message "Etki alani silinemedi '$domain'. Sebeb: $(echo "$DELETE_RESULT" | jq -r '.metadata.reason')"
        fi
    else
        log_message "[DRY-RUN] Etki alanini silecektir: $domain"
    fi
done

log_message "cprapid.com temizleme komut dosyasi tamamlandi."
