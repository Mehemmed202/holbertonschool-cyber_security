# Nmap – Port Vəziyyətləri və Scan Növləri

Bu sənəd **Nmap** aləti ilə aparılan port skanları, host discovery metodları və port vəziyyətlərinin izahını ehtiva edir.

---

## 📌 Port Vəziyyətləri (Port States)

### 1. Open (Açıq)

Port açıqdır və həmin portda bir servis işləyir (məsələn: HTTP, SSH).

---

### 2. Closed (Qapalı)

Port əlçatandır (sorğu hədəfə çatır), lakin həmin portda işləyən hər hansı bir tətbiq yoxdur.

**Nümunə:**
Bir kompüter internetə bağlıdır, lakin heç bir web və ya fayl paylaşım xidməti aktiv deyilsə, əksər portlar *Closed* görünür.

---

### 3. Filtered (Filtrlənmiş)

Portun açıq və ya qapalı olduğu müəyyən edilə bilmir. Çünki arada **Firewall** və ya şəbəkə filtri paketləri bloklayır.

**Nümunə:**
Şirkət şəbəkələrində kənardan gələn sorğular firewall tərəfindən *drop* edilir və nəticə *Filtered* olur.

---

### Digər Vəziyyətlər

* **Unfiltered**
  Port əlçatandır, lakin açıq və ya qapalı olduğu dəqiq bilinmir (əsasən ACK scan-lərdə).

* **Open|Filtered**
  Port açıqdır, yoxsa filtr edilib – ayırd edilə bilmir (əsasən UDP scan-lərdə).

---

## 🔍 Nmap Scan Növləri

### 1. Sadə Port Scan

```bash
nmap target.com
```

Ən çox istifadə olunan portları yoxlayır.

---

### 2. Xüsusi Portların Scan-i

```bash
nmap -p 80,443 target.com
```

Yalnız göstərilən portları skan edir.

---

### 3. TCP Connect Scan

```bash
nmap -sT target.com
```

Tam TCP bağlantısı qurur.
Root tələb etmir, lakin loglarda görünməsi asandır.

---

### 4. SYN Scan (Stealth Scan)

```bash
nmap -sS target.com
```

TCP SYN paketləri ilə portları yoxlayır.
Daha az iz buraxır.

---

### 5. Service Version Detection

```bash
nmap -sV target.com
```

Açıq portlarda işləyən servisləri və versiyalarını göstərir.

---

### 6. OS Fingerprinting

```bash
nmap -O target.com
```

Hədəf sistemin əməliyyat sistemini təxmin edir.

---

### 7. Aggressive Scan

```bash
nmap -A target.com
```

OS detection, service version, script scan və traceroute birlikdə icra olunur.

---

### 8. Zəifliklərin Aşkarlanması

```bash
nmap --script vuln target.com
```

Məlum zəiflikləri yoxlayır.

---

### 9. Decoy Scan (IP Gizlətmə)

```bash
nmap -D 192.168.1.5,192.168.1.10 target.com
```

Saxta IP-lərlə scan edərək real IP-ni gizlədir.

---

### 10. Ping Bypass

```bash
nmap -Pn target.com
```

Ping yoxlamasını söndürür və birbaşa port scan edir.

---

### 11. Yalnız Host Discovery (No Port Scan)

```bash
nmap -sn target.com
```

Host-un aktiv olub-olmadığını yoxlayır, port scan etmir.

---

### 12. TCP SYN Ping

```bash
nmap -PS target.com
```

TCP SYN paketləri ilə host discovery edir.
Default: port 80.

---

### 13. TCP ACK Ping

```bash
nmap -PA target.com
```

TCP ACK paketləri ilə host discovery edir.
Firewall bypass üçün uyğundur.

---

### 14. ARP Scan (Yalnız LAN)

```bash
nmap -PR target
```

ARP Request göndərir.
Yalnız local network üçün işləyir.

---

## 📤 Output Formatları

| Parametr | Format        | İstifadə sahəsi |
| -------- | ------------- | --------------- |
| `-oN`    | Normal (text) | İnsan oxusun    |
| `-oG`    | Grepable      | Script / Bash   |
| `-oX`    | XML           | Avtomatlaşdırma |
| `-oA`    | All           | Bütün formatlar |

---

## ✅ Qeyd

Bu sənəd **tədris, lab və pentest öyrənmə məqsədləri** üçün hazırlanmışdır.

