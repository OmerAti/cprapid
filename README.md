# WHM/cPanel CPRapid Temizleyici

Bu script, WHM/cPanel sunucularında otomatik olarak atanan `*.cprapid.com` hostnamelerini tespit eder ve siler. 
Özellikle yeni kurulan sunucularda görülen bu geçici alan adları, marka tutarlılığı ve SSL uyumluluğu açısından önerilmez.

## Özellikler
- `cprapid.com` uzantılı alan adlarını tarar
- İsteğe bağlı `--dry-run` modu ile simülasyon yapar
- WHM API kullanarak temizleme işlemini gerçekleştirir
- İşlem loglarını `/var/log/clean_cprapid_domains.log` dosyasına yazar

## Gereksinimler
- WHM/cPanel erişimi
- `jq` paketi (`yum install -y jq` veya `apt install -y jq`)
- root kullanıcı veya sudo yetkisi

## 🚀 Kurulum & Kullanım

### 1. Script’i İndir

```bash
[git clone https://github.com/OmerAti/cprapid/whm-cprapid-cleaner.git](https://github.com/OmerAti/cprapid.git)
cd cprapid
chmod +x cprapid-cleaner.sh
bash cprapid-cleaner.sh
