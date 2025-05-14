# WHM/cPanel CPRapid Hostname Temizleyici 🧹

Bu script, WHM/cPanel sunucularında otomatik olarak atanan `*.cprapid.com` hostnamelerini tespit edip temizler ve kendi alan adınızı kullanarak hostname değişikliği yapmanıza yardımcı olur.

## 🔍 Nedir Bu `*.cprapid.com`?

cPanel, yeni kurulan sunuculara geçici olarak `subdomain.cprapid.com` biçiminde bir hostname atar. Bu, kullanıcıların ilk girişlerinde SSL uyarısı görmemeleri içindir. Ancak:

- Bu hostname size ait değildir.
- DNS ve marka yönetimi açısından tavsiye edilmez.
- Adres çubuğunda şüpheli görünebilir.

## 🎯 Ne Yapar Bu Araç?

- Geçici CPRapid hostnamesini tespit eder.
- Girdiğiniz kendi domaininize ait hostname ile değiştirir.
- `/etc/hosts` dosyasını günceller.
- Gerekirse WHM üzerinden AutoSSL tetikler.
- Gereksiz `cprapid.com` DNS kayıtlarını siler (isteğe bağlı).

---

## ⚙️ Gereksinimler

- WHM/cPanel kurulu bir sunucu
- root SSH erişimi
- Kendi domain adınıza ait tanımlı bir subdomain (örnek: `server.seninalanadiniz.com`)
- Subdomain için A kaydı, sunucunun IP’sine yönlenmiş olmalı

---

## 🚀 Kurulum & Kullanım

### 1. Script’i İndir

```bash
git clone https://github.com/OmerAti/whm-cprapid-cleaner.git
cd whm-cprapid-cleaner
chmod +x cprapid-cleaner.sh
