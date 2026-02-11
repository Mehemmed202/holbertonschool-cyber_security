# 🛡️ Linux Security: SELinux & AppArmor Guide

Bu sənəd Linux sistemlərində təhlükəsizliyin əsas sütunları olan **SELinux** və **AppArmor** mexanizmlərini, onların işləmə məntiqlərini və praktiki komandalarını əhatə edir.

---

## 🏗️ 1. Əsas Anlayışlar: DAC vs MAC

Linux-da iki növ giriş kontrolu mövcuddur:

* **DAC (Discretionary Access Control):** Standart `owner:group` və `rwx` icazələri. Fayl sahibi icazələri dəyişə bilər.
* **MAC (Mandatory Access Control):** SELinux və AppArmor-un istifadə etdiyi sistem. Admin tərəfindən mərkəzi qaydalar qoyulur; hətta `root` istifadəçisi belə bu qaydaları poza bilməz.



---

## 🔍 2. SELinux (Security-Enhanced Linux)

SELinux, sistemdəki hər bir obyektə (fayl, port) və subyektə (proses) bir **Label (Etiket)** yapışdırır.

### 🧩 SELinux Modları
1.  **Enforcing:** Qaydalar tətbiq olunur, icazəsiz girişlər bloklanır.
2.  **Permissive:** Bloklama yoxdur, yalnız qayda pozuntuları loqlanır.
3.  **Disabled:** SELinux tamamilə sönülüdür (Sistemin restartı tələb olunur).

### 🛠️ Faydalı Komandalar
| Komanda | Məqsədi |
| :--- | :--- |
| `sestatus` | SELinux vəziyyətini yoxla |
| `getenforce` | Cari modu gör |
| `setenforce 1/0` | Enforcing/Permissive keçidi et |
| `ls -Z` | Faylların etiketini gör |
| `ps -eZ` | Proseslərin etiketini gör |
| `restorecon -v <fayl>` | Standart etiketi bərpa et |
| `getsebool -a` | Bütün Boolean keçidləri siyahıla |

### 💡 Nümunə Ssenari (Type Enforcement)
Apache prosesi (`httpd_t`) yalnız veb kontent etiketi olan faylları (`httpd_sys_content_t`) oxuya bilər. Haker Apache-ni sındırsa belə, bazadakı kredit kartı məlumatlarına (`mysqld_data_t`) toxuna bilməz, çünki etiketlər uyğun gəlmir.



---

## 🛡️ 3. AppArmor (Application Armor)

AppArmor, SELinux-un daha sadə alternativdir. Etiketlər əvəzinə **fayl yollarına (path-based)** əsaslanır.

* **Profil Məntiqi:** Hər tətbiq üçün `/etc/apparmor.d/` daxilində konfiqurasiya faylı (profil) yaradılır.
* **Rejim:** `Enforce` (Bloklayır) və `Complain` (Yalnız xəbərdarlıq verir).

### 🛠️ AppArmor Komandaları
* `aa-status` : AppArmor-un vəziyyətini və yüklənmiş profilləri gör.
* `aa-enforce /yol/to/bin` : Profili bloklama rejiminə keçir.
* `aa-complain /yol/to/bin` : Profili öyrənmə (test) rejiminə keçir.

---

## ⚖️ SELinux vs AppArmor

| Xüsusiyyət | SELinux | AppArmor |
| :--- | :--- | :--- |
| **İdarəetmə** | Etiketlər (Labels) | Fayl Yolları (Path) |
| **Çətinlik** | Yüksək (Peşəkar) | Orta (İstifadəçi dostu) |
| **Default Sistem** | RHEL, Fedora, CentOS | Ubuntu, Debian |

---

## ⚠️ Diqqət!
Əgər sistemdə bir proqram "Permission Denied" xətası verirsə və DAC (`chmod/chown`) icazələri düzgündürsə, ilk növbədə SELinux loqlarını yoxlayın:
`tail -f /var/log/audit/audit.log`
