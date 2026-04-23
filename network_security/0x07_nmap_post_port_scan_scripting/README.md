NMAP VƏ NSE

Nmap Scripting Engine — Tam Bələdçi

Skriptlər, Texnikalar və Praktiki Nümunələr

 Bu sənəd Nmap-ın bütün əsas skriptlərini, skan texnikalarını və NSE kateqoriyalarını Azərbaycan dilində ətraflı izah edir.


1. Nmap Haqqında Ümumi Məlumat


Nmap (Network Mapper) — 1997-ci ildə Gordon Lyon (Fyodor) tərəfindən yaradılmış, şəbəkə kəşfiyyatı və təhlükəsizlik auditləri üçün nəzərdə tutulmuş açıq mənbəli bir alətdir. Nmap şəbəkədəki cihazları aşkar etmək, açıq portları müəyyən etmək, işləyən xidmətləri və əməliyyat sistemlərini tanımaq üçün istifadə olunur.





1.1 Nmap-ın Əsas İmkanları


	Port skan etmək — TCP/UDP portların açıq, bağlı və ya filtrlənmiş olduğunu müəyyən edir


	Host kəşfi — şəbəkədə aktiv cihazları tapır (ping sweep)


	Servis versiyası aşkarı — açıq portda hansı xidmətin hansı versiyasının işlədiyini öyrənir


	Əməliyyat sistemi aşkarı — hədəf cihazın OS-ni (Windows, Linux, Cisco IOS, və s.) müəyyən edir


	NSE skriptləri ilə genişlənmə — zəiflik tapmaq, brute-force, malware aşkarı kimi əməliyyatlar




⚠️ Qanuni xəbərdarlıq: Nmap yalnız icazəniz olan sistemlərə qarşı istifadə edilməlidir. İcazəsiz skan qanunsuz hesab olunur və ciddi hüquqi nəticələrə yol aça bilər.




1.2 Nmap Qurma


Əməliyyat sistemindən asılı olaraq Nmap aşağıdakı üsullarla qurulur:





Debian/Ubuntu:


sudo apt update && sudo apt install nmap -y


RHEL/CentOS/Fedora:


sudo yum install nmap   # CentOS 7


sudo dnf install nmap   # Fedora / CentOS 8+


macOS (Homebrew):


brew install nmap


Windows:


Rəsmi saytdan (https://nmap.org/download.html) installer yükləyin. Npcap drayverini də quraşdırın.





Versiyasını yoxlamaq üçün:


nmap --version



2. Əsas Skan Texnikaları


Nmap müxtəlif skan metodlarını dəstəkləyir. Hər metodun şəbəkə trafikinə fərqli təsiri var — bəziləri gizli (stealth), bəziləri isə daha çox izlər buraxır.





2.1 Sadə Ping Skan (-sn)


Host kəşfi üçün istifadə olunur. Portları skan etmədən yalnız canlı hostları tapır. Bu metod ICMP echo, TCP SYN/ACK, UDP və ARP paketlərini göndərir.


nmap -sn 192.168.1.0/24


nmap -sn 192.168.1.1-100


Çıxışda aktiv olan hostların IP ünvanları göstərilir. Firewall ICMP-ni bloklayırsa, hoslar görünməyə bilər.





2.2 SYN Skanı (-sS) — "Gizli Skan"


Ən populyar skan növüdür. TCP 3-yollu əl sıxışmasını tamamlamır — yalnız SYN göndərir, SYN-ACK aldıqda port açıq hesab edilir, RST göndərilir. Bu metodu işlətmək üçün root/administrator hüquqları lazımdır.


sudo nmap -sS 192.168.1.1


sudo nmap -sS -p 1-1000 192.168.1.1

Nə üçün gizli? 3-yollu əl sıxışma başa çatmadığından bir çox köhnə log sistemi bu skanı qeydə almırdı. Müasir IDS/IPS sistemləri isə onu aşkarlayır.




2.3 TCP Connect Skanı (-sT)


Tam TCP bağlantısı qurur. Root hüquqları olmadan işlədilə bilər, lakin daha çox iz buraxır çünki tam 3-yollu əl sıxışması tamamlanır.


nmap -sT 192.168.1.1


Bu skan OS-in socket API-dən istifadə edir. Hər açıq port sistemin log fayllarına düşür.





2.4 UDP Skanı (-sU)


UDP portlarını skan edir. UDP cavabsız ola bildiyi üçün bu skan daha yavaşdır. DNS (53), SNMP (161/162), DHCP (67/68), NTP (123) kimi xidmətlər UDP istifadə edir.


sudo nmap -sU 192.168.1.1


sudo nmap -sU -p 53,67,68,69,123,161,500 192.168.1.1


ICMP port unreachable cavabı — port bağlıdır. Cavab yoxdur — port açıq|filtrlənmiş.





2.5 Versiya Aşkarı (-sV)


Açıq portlarda işləyən xidmətlərin adını və versiyasını müəyyən edir. Bu məlumat zəiflik qiymətləndirilməsində çox önəmlidir.


nmap -sV 192.168.1.1


nmap -sV --version-intensity 9 192.168.1.1


--version-intensity 0-9 arasında dəyər alır. Yüksək dəyər daha dəqiq, lakin daha yavaşdır.


Nümunə çıxış: 80/tcp open http Apache httpd 2.4.51 ((Ubuntu))





2.6 OS Aşkarı (-O)


TCP/IP stack barmaq izi ilə əməliyyat sistemini müəyyən edir. TTL dəyərləri, TCP pencərə ölçüsü, MSS və sair parametrlərə baxır.


sudo nmap -O 192.168.1.1


sudo nmap -O --osscan-guess 192.168.1.1


--osscan-guess: uyğun OS tapılmadıqda ən oxşar nəticəni göstərir.





2.7 Aqressiv Skan (-A)


OS aşkarı (-O), versiya aşkarı (-sV), skript skanı (-sC) və traceroute (--traceroute) birlikdə işlədir. Ən çox məlumat verən, lakin ən çox iz buraxan metod.


sudo nmap -A 192.168.1.1


sudo nmap -A -p- 192.168.1.1    # Bütün 65535 portları skan et





2.8 Port Seçimi


nmap -p 80 192.168.1.1              # Yalnız 80-ci port


nmap -p 80,443,8080 192.168.1.1     # Müəyyən portlar


nmap -p 1-1024 192.168.1.1          # 1-dən 1024-ə qədər


nmap -p- 192.168.1.1               # Bütün 65535 port


nmap --top-ports 100 192.168.1.1   # Ən çox istifadə olunan 100 port





2.9 Skan Sürəti (-T)


Nmap 6 sürət şablonu təklif edir (T0-T5). Aşağı dəyər daha yavaş, lakin daha gizli; yüksək dəyər daha sürətli, lakin daha aşkardır.

Skript adı
Təsvir
nmap -T0
Paranoid — çox yavaş, IDS-dən qaçmaq üçün
nmap -T1
Sneaky — yavaş, gizli skan
nmap -T2
Polite — yavaş, sistem yüklənməsin deyə
nmap -T3
Normal — standart (default)
nmap -T4
Aggressive — sürətli, etibarlı şəbəkələr üçün
nmap -T5
Insane — maksimal sürət, dəqiqlik azalır


3. NSE — Nmap Scripting Engine


NSE (Nmap Scripting Engine) Nmap-ın ən güclü xüsusiyyətidir. Lua proqramlaşdırma dilində yazılmış skriptlər vasitəsilə istifadəçilər şəbəkə skanını avtomatlaşdıra, zəiflikləri aşkar edə, xidmətlərlə əlaqə qura bilər. NSE skriptləri /usr/share/nmap/scripts/ qovluğunda yerləşir.





3.1 NSE-nin Əsas İstifadəsi


nmap --script <skript_adı> <hədəf>


nmap --script <kateqoriya> <hədəf>


nmap --script "http-*" <hədəf>         # Wildcard ilə


nmap --script default,safe <hədəf>     # Birdən çox kateqoriya


nmap -sC <hədəf>                       # -sC = --script=default





Skript parametrləri ötürmək üçün --script-args istifadə olunur:


nmap --script http-brute --script-args http-brute.path=/admin 192.168.1.1





Mövcud skriptləri siyahılamaq:


ls /usr/share/nmap/scripts/


nmap --script-help <skript_adı>         # Skript haqqında məlumat




💡 Məsləhət: Yeni skriptlər qurduqdan sonra verilənlər bazasını yeniləyin: sudo nmap --script-updatedb




3.2 NSE Skript Kateqoriyaları


NSE skriptləri funksionallığına görə aşağıdakı kateqoriyalara bölünür:




Skript adı
Təsvir
auth
Autentifikasiya sınaqları — standart/boş parolları yoxlayır
broadcast
Şəbəkəyə broadcast sorğu göndərərək cihazları tapır
brute
Güc sınağı (brute-force) ilə şifrə tapmağa çalışır
default
nmap -sC ilə işə düşən etibarlı standart skriptlər
discovery
Host, servis, şəbəkə haqqında əlavə məlumat toplayır
dos
DoS zəifliklərini sınaqdan keçirir (diqqətlə!)
exploit
Zəiflikləri exploit etməyə çalışır
external
Kənar verilənlər bazalarına (Shodan, DNS, WHOIS) sorğu edir
fuzzer
Proqrama gözlənilməz daxiletmə göndərir (fuzzing)
intrusive
Hədəf sistemə müdaxilə edə bilən, risk daşıyan skriptlər
malware
Sistmdə arxa qapı (backdoor) və zərərli proqram izlərini axtarır
safe
Hədəf sistemə zərər verməyən, risk daşımayan skriptlər
version
Xidmət versiyasını müəyyən etmək üçün əlavə sınaqlar
vuln
Məlum CVE zəifliklərini yoxlayır


4. AUTH Kateqoriyası — Autentifikasiya Skriptləri


Auth skriptləri servislərin autentifikasiya mexanizmlərini yoxlayır. Standart şifrələr, boş parollar, anonim girişlər və autentifikasiya bypass üsulları aşkar edilir.





4.1 ftp-anon — Anonim FTP


FTP serverinə anonim (adsız) girişin mümkün olub olmadığını yoxlayır. Bir çox köhnə FTP serveri yanlış konfigurasiya ilə anonim girişə icazə verir.


nmap --script ftp-anon -p 21 192.168.1.1


Nümunə müsbət cavab:


| ftp-anon: Anonymous FTP login allowed (FTP code 230)


|_-rw-r--r--   1 ftp  ftp    0 Jan 01 00:00 welcome.txt


Bu nəticə anonim istifadəçinin fayllara baxmaq icazəsinin olduğunu göstərir. Həssas fayllara anonim giriş ciddi təhlükəsizlik problemidir.





4.2 ftp-brute — FTP Şifrə Sınağı


FTP serverinə qarşı brute-force hücumu aparır. İstifadəçi adı və şifrə siyahıları (wordlist) ilə işləyir.


nmap --script ftp-brute -p 21 192.168.1.1


nmap --script ftp-brute --script-args userdb=/root/users.txt,passdb=/root/pass.txt -p 21 192.168.1.1





4.3 ssh-brute — SSH Şifrə Sınağı


SSH xidmətinə qarşı brute-force aparır. Populyar istifadəçi adı/şifrə kombinasiyalarını sınaqdan keçirir.


nmap --script ssh-brute -p 22 192.168.1.1


nmap --script ssh-brute --script-args brute.mode=user,brute.firstonly=true -p 22 192.168.1.1


brute.firstonly=true — ilk tapılan istifadəçidə dayanır.





4.4 http-auth-finder — HTTP Autentifikasiya Növü


Veb serverinin hansı HTTP autentifikasiya növündən istifadə etdiyini müəyyən edir: Basic, Digest, NTLM, Negotiate.


nmap --script http-auth-finder -p 80,443 192.168.1.1





4.5 smb-brute — SMB/Windows Şifrə Sınağı


Windows paylaşım protokoluna (SMB) qarşı brute-force. Domain mühitlərindəki Windows serverləri üçün çox önəmlidir.


nmap --script smb-brute -p 445 192.168.1.1





4.6 mysql-empty-password — MySQL Boş Parol


MySQL serverinin root hesabının şifresiz olub olmadığını yoxlayır. Yanlış konfiqurasiya edilmiş verilənlər bazası serverləri üçün kritik yoxlamadır.


nmap --script mysql-empty-password -p 3306 192.168.1.1





4.7 ms-sql-empty-password — MSSQL Boş Parol


Microsoft SQL Server-in SA (system administrator) hesabının şifresiz olub olmadığını yoxlayır.


nmap --script ms-sql-empty-password -p 1433 192.168.1.1





4.8 vnc-brute — VNC Şifrə Sınağı


VNC (Virtual Network Computing) uzaqdan idarə xidmətinə qarşı brute-force aparır.


nmap --script vnc-brute -p 5900 192.168.1.1





4.9 rdp-enum-encryption — RDP Şifrələmə


Windows Uzaqdan Masaüstü Protokolunun (RDP) hansı şifrələmə üsulunu istifadə etdiyini müəyyən edir.


nmap --script rdp-enum-encryption -p 3389 192.168.1.1



5. VULN Kateqoriyası — Zəiflik Skriptləri


VULN skriptləri məlum CVE (Common Vulnerabilities and Exposures) zəifliklərini aşkar etmək üçün nəzərdə tutulub. Bu skriptlər hədəf sistemdə kritik boşluqların mövcudluğunu yoxlayır.





5.1 vuln — Bütün Zəiflik Skriptlərini İşlət


Bütün vuln kateqoriyasındakı skriptləri eyni anda işlədir. Tam zəiflik qiymətləndirilməsi üçün istifadə olunur.


nmap --script vuln 192.168.1.1


nmap --script vuln -sV 192.168.1.1    # Versiya məlumatı ilə birlikdə

⚠️ Diqqət: vuln skriptləri hədəf sistemə stress verə bilər. Həssas sistemlərə qarşı diqqətlə istifadə edin.




5.2 smb-vuln-ms17-010 — EternalBlue (WannaCry)


CVE-2017-0144 — Microsoft SMBv1 protokolundakı kritik zəiflik. WannaCry, NotPetya kimi ransomware-lər bu zəiflikdən istifadə etdi. NSA-nın EternalBlue exploit-ini işlədər.


nmap --script smb-vuln-ms17-010 -p 445 192.168.1.1


Müsbət nəticə aşağıdakı kimi görünür:


| smb-vuln-ms17-010:


|   VULNERABLE:


|   Remote Code Execution vulnerability in Microsoft SMBv1


|     State: VULNERABLE


|_    Risk factor: HIGH





5.3 smb-vuln-ms08-067 — Conficker/Sasser


CVE-2008-4250 — Windows Server Xidmətindəki uzaqdan kod icra (RCE) zəifliyi. Conficker qurdunun yayılmasında istifadə edilib.


nmap --script smb-vuln-ms08-067 -p 445 192.168.1.1





5.4 smb-vuln-ms10-054 — SMB Memory Corruption


CVE-2010-2550 — SMB protokolundakı yaddaş korlanması zəifliyi. Uzaqdan DoS hücumuna imkan verir.


nmap --script smb-vuln-ms10-054 -p 445 192.168.1.1





5.5 http-shellshock — Shellshock (Bash Zəifliyi)


CVE-2014-6271 — Bash shell-dəki kritik zəiflik. CGI skriptlərini işlədən veb serverləri uzaqdan komanda icrasına qarşı həssas edirdi. 2014-cü ildə aşkarlandı.


nmap --script http-shellshock -p 80 192.168.1.1


nmap --script http-shellshock --script-args uri=/cgi-bin/test.sh -p 80 192.168.1.1





5.6 ssl-heartbleed — Heartbleed (OpenSSL)


CVE-2014-0160 — OpenSSL TLS/DTLS heartbeat genişlənməsindəki kritik yaddaş sızdırması zəifliyi. Serverin yaddaşından 64KB-a qədər məlumat oxumağa imkan verirdi. Şifrələr, açarlar, şəxsi məlumatlar sıza bilərdi.


nmap --script ssl-heartbleed -p 443 192.168.1.1


nmap --script ssl-heartbleed -p 443,8443 192.168.1.1





5.7 ssl-poodle — POODLE (SSL 3.0)


CVE-2014-3566 — SSL 3.0 protokolundakı padding oracle hücumu. MITM (Man-in-the-Middle) hücumçusu şifrəli məlumatı deşifrə edə bilir.


nmap --script ssl-poodle -p 443 192.168.1.1





5.8 ssl-drown — DROWN (SSLv2)


CVE-2016-0800 — SSLv2 aktiv olan serverlər TLS bağlantılarına MITM hücumuna qarşı həssasdır. RSA açarları bölüşdürüldüyündə problem daha da ciddiləşir.


nmap --script ssl-drown -p 443 192.168.1.1





5.9 http-csrf — CSRF Zəifliyi


Saytlarda Cross-Site Request Forgery (CSRF) token-lərinin mövcudluğunu yoxlayır. CSRF zəifliyi istifadəçi adından icazəsiz əməliyyatlar icra etməyə imkan verir.


nmap --script http-csrf -p 80,443 192.168.1.1





5.10 http-sql-injection — SQL İnjeksiya Sınağı


Veb tətbiqlərindəki URL parametrlərini SQL injeksiya hücumlarına qarşı sınaqdan keçirir. Verilənlər bazasına icazəsiz giriş üçün istifadə edilən ən geniş yayılmış veb zəifliyidir.


nmap --script http-sql-injection -p 80 192.168.1.1





5.11 ftp-vsftpd-backdoor — vsFTPd 2.3.4 Backdoor


CVE-2011-2523 — vsFTPd 2.3.4 versiyasında kasıb kod dəyişikliyi nəticəsindəki backdoor. İstifadəçi adında ":)" işarəsi istifadə edildikdə 6200-ci portda shell açılır. Metasploitable VM-də standart olaraq mövcuddur.


nmap --script ftp-vsftpd-backdoor -p 21 192.168.1.1





5.12 smb-vuln-cve-2017-7494 — SambaCry


CVE-2017-7494 — Samba NAS cihazları və Linux serverlərdəki kritik RCE zəifliyi. WannaCry ilə eyni vaxtda aşkarlandı, "SambaCry" adlandırıldı.


nmap --script smb-vuln-cve-2017-7494 -p 445 192.168.1.1



6. DISCOVERY Kateqoriyası — Kəşfiyyat Skriptləri


Discovery skriptləri hədəf sistem, şəbəkə və xidmətlər haqqında ətraflı məlumat toplayır. DNS məlumatları, SMB paylaşımları, SNMP sistemi məlumatları, HTTP başlıqları kimi məlumatlar toplanır.





6.1 dns-brute — DNS Subdomain Kəşfi


Mövcud wordlist istifadə edərək hədəf domenin subdomain-lərini tapır. Subdomain takeover hücumları üçün zəmin hazırlanmasında çox önəmlidir.


nmap --script dns-brute --script-args dns-brute.domain=example.com


nmap --script dns-brute --script-args dns-brute.threads=6,dns-brute.domain=target.com





6.2 http-headers — HTTP Başlıqları


Veb serverin HTTP cavab başlıqlarını toplayır. Server versiyası, X-Powered-By, Cookie atributları, güvenlik başlıqları (HSTS, CSP, X-Frame-Options) göstərilir.


nmap --script http-headers -p 80,443 192.168.1.1


Nümunə çıxış:


| http-headers:


|   Server: Apache/2.4.51 (Ubuntu)


|   X-Powered-By: PHP/8.0.12


|_  Set-Cookie: PHPSESSID=abc123; path=/





6.3 http-title — Veb Səhifə Başlığı


HTTP(S) xidmətinin ana səhifəsinin HTML başlığını (title) götürür. Veb tətbiqinin nə olduğunu sürətlə müəyyən etmək üçün istifadə olunur.


nmap --script http-title -p 80,443 192.168.1.0/24





6.4 http-robots.txt — Robots.txt Analizi


Veb serverin robots.txt faylını oxuyur. Axtarış motorlarından gizlədilmiş qovluqlar bəzən həssas məlumatlar (admin paneli, backup fayllar) ehtiva edir.


nmap --script http-robots.txt -p 80,443 192.168.1.1





6.5 smb-enum-shares — SMB Paylaşımlarını Siyahıla


Windows sistemlərindəki SMB paylaşımlarını (şəbəkə diskləri) siyahılayır. İcazə verilmiş paylaşımlar həssas faylları açıqlaya bilər.


nmap --script smb-enum-shares -p 445 192.168.1.1


nmap --script smb-enum-shares,smb-enum-users -p 445 192.168.1.1





6.6 smb-enum-users — SMB İstifadəçi Siyahısı


Windows sistemlərindəki yerli istifadəçi hesablarını siyahılayır. Brute-force hücumları üçün istifadəçi adlarını toplamaqda istifadə olunur.


nmap --script smb-enum-users -p 445 192.168.1.1





6.7 snmp-info — SNMP Sistem Məlumatı


SNMP (Simple Network Management Protocol) community string-ləri ilə əlaqə qurub sistem haqqında geniş məlumat toplayır: hostname, OS, interfeys siyahısı, proseslər.


nmap --script snmp-info -sU -p 161 192.168.1.1


nmap --script snmp-brute -sU -p 161 192.168.1.1   # Community string sınağı





6.8 whois-domain — WHOIS Məlumatı


Hədəf domenin WHOIS qeydini alır. Sahibi, qeydiyyat tarixi, nameserver-lər haqqında məlumat verir.


nmap --script whois-domain example.com





6.9 ssl-cert — SSL Sertifikat Məlumatı


HTTPS xidmətinin SSL/TLS sertifikatını analiz edir: sahibi, etibarlılıq müddəti, sertifikat orqanı, SANs (Subject Alternative Names).


nmap --script ssl-cert -p 443 192.168.1.1





6.10 ssl-enum-ciphers — SSL Şifrə Dəstləri


Serverin dəstəklədiyi TLS versiyalarını və şifrə dəstlərini (cipher suites) siyahılayır. Zəif şifrə dəstləri (RC4, DES, NULL) aşkar edilir.


nmap --script ssl-enum-ciphers -p 443 192.168.1.1





6.11 banner — Servis Banner


Açıq portlardan servis banner-ini oxuyur. Bir çox servis (FTP, SMTP, SSH) bağlandıqda versiya məlumatı ehtiva edən banner göndərir.


nmap --script banner -p 21,22,25,110 192.168.1.1





6.12 traceroute-geolocation — Coğrafi Məkan


Traceroute hop-larının coğrafi məkanını müəyyən edir. Şəbəkə yolunu xəritəyə işləmək üçün istifadə olunur.


nmap --script traceroute-geolocation --traceroute 192.168.1.1



7. BRUTE Kateqoriyası — Güc Sınağı Skriptləri


Brute skriptləri müxtəlif protokollara qarşı şifrə tapmaq (credential stuffing, dictionary attack) üçün nəzərdə tutulub. Bu skriptlər hesabın kilidlənməsinə (lockout) səbəb ola bilər — diqqətlə istifadə edin.





7.1 http-brute — HTTP Brute-Force


HTTP Basic, Digest autentifikasiyasına qarşı brute-force aparır. Login formlarında da istifadə oluna bilər.


nmap --script http-brute -p 80 192.168.1.1


nmap --script http-brute --script-args http-brute.path=/admin,brute.firstonly=true -p 80 192.168.1.1





7.2 ssh-brute — SSH Brute-Force


SSH xidmətinə qarşı istifadəçi adı/şifrə kombinasiyalarını sınaqdan keçirir. Öz istifadəçi/şifrə fayllarınızı göstərə bilərsiniz.


nmap --script ssh-brute --script-args userdb=users.txt,passdb=passwords.txt -p 22 192.168.1.1





7.3 smb-brute — SMB/CIFS Brute-Force


Windows SMB paylaşımına karşı şifrə sınağı aparır. Şəbəkə hesablarını tapmaqda istifadə olunur.


nmap --script smb-brute --script-args userdb=users.txt,passdb=pass.txt -p 445 192.168.1.1





7.4 mysql-brute — MySQL Brute-Force


MySQL verilənlər bazası serverinə qarşı şifrə sınağı aparır.


nmap --script mysql-brute --script-args userdb=users.txt,passdb=pass.txt -p 3306 192.168.1.1





7.5 ms-sql-brute — MSSQL Brute-Force


Microsoft SQL Server-ə qarşı brute-force aparır. SA hesabı da daxil olmaqla bütün hesabları sınaqdan keçirir.


nmap --script ms-sql-brute --script-args userdb=users.txt,passdb=pass.txt -p 1433 192.168.1.1





7.6 pgsql-brute — PostgreSQL Brute-Force


PostgreSQL verilənlər bazasına qarşı brute-force sınağı.


nmap --script pgsql-brute -p 5432 192.168.1.1





7.7 telnet-brute — Telnet Brute-Force


Köhnə Telnet protokoluna qarşı şifrə sınağı aparır. Telnet şifrəsiz protokol olduğundan müasir sistemlərdə istifadəsi tövsiyə edilmir.


nmap --script telnet-brute -p 23 192.168.1.1





7.8 vnc-brute — VNC Brute-Force


VNC uzaqdan idarə protokoluna qarşı şifrə sınağı. VNC şifrəsi adətən tək bir parola dayanır.


nmap --script vnc-brute --script-args passdb=passwords.txt -p 5900 192.168.1.1





7.9 smtp-brute — SMTP Brute-Force


E-poçt serverinin SMTP autentifikasiyasına qarşı şifrə sınağı.


nmap --script smtp-brute -p 25,587 192.168.1.1





7.10 rdp-brute — RDP Brute-Force


Windows Uzaqdan Masaüstü Protokoluna (RDP) qarşı brute-force.


nmap --script rdp-brute --script-args userdb=users.txt,passdb=pass.txt -p 3389 192.168.1.1



8. MALWARE Kateqoriyası — Zərərli Proqram Skriptləri


Malware skriptləri sistemdə aktiv olan backdoor-ları, troyanları, botnet agent-lərini aşkar etmək üçün nəzərdə tutulub. Port imzaları, protokol davranışı və banner-lər analiz edilir.





8.1 http-malware-host — Zərərli HTTP Host Aşkarı


Hostun Google Safe Browsing siyahısında (qara siyahı) olub olmadığını yoxlayır. DNS verilənlər bazası ilə müqayisə aparır.


nmap --script http-malware-host 192.168.1.1





8.2 smtp-strangeport — SMTP Qeyri-standart Port


Qeyri-standart portlarda işləyən SMTP xidmətlərini aşkar edir. Botnet-lər adətən spam göndərmək üçün qeyri-standart portlar istifadə edir.


nmap --script smtp-strangeport 192.168.1.1





8.3 ftp-vsftpd-backdoor — vsFTPd Backdoor Aşkarı


vsFTPd 2.3.4-ün backdoor-unu aşkar edir (CVE-2011-2523). Bu backdoor 2011-ci ildə mənbə koduna yerləşdirilmişdi.


nmap --script ftp-vsftpd-backdoor -p 21 192.168.1.1





8.4 irc-botnet-channels — IRC Botnet


IRC serverindəki botnet kanallarını aşkar etməyə çalışır. Köhnə botnet-lər C&C (Command and Control) kanalı üçün IRC istifadə edirdi.


nmap --script irc-botnet-channels -p 6667 192.168.1.1





8.5 malware-portlist — Bilinen Malware Portları


Bilinen zərərli proqramların istifadə etdiyi portları yoxlayır. Hər tapılan açıq port malware ilə əlaqəli ola bilər.


nmap --script malware-portlist 192.168.1.1



9. HTTP Skriptləri — Veb Xidmət Analizi


Nmap-ın ən geniş skript kolleksiyası HTTP xidmətlərini əhatə edir. Veb tətbiq texnologiyaları, admin panelləri, zəifliklər, məzmun kəşfi kimi məlumatlar toplanır.





9.1 http-enum — Veb Qovluq Kəşfi


Veb serverdəki gizli qovluqları, faylları, admin panellərini aşkar edir. Daxili wordlist-dən istifadə edir (2000+ yol).


nmap --script http-enum -p 80,443 192.168.1.1


nmap --script http-enum --script-args http-enum.displayall -p 80 192.168.1.1





9.2 http-methods — HTTP Metodları


Veb serverinin hansı HTTP metodlarını (GET, POST, PUT, DELETE, OPTIONS, TRACE) qəbul etdiyini yoxlayır. PUT metodu aktiv olarsa fayl yükləmə mümkün ola bilər.


nmap --script http-methods -p 80,443 192.168.1.1





9.3 http-wordpress-enum — WordPress Skanı


WordPress saytlarında qurulu eklentilər, mövzular (themes) və istifadəçi adlarını siyahılayır. Köhnə eklentilər çox zaman zəiflik mənbəyidir.


nmap --script http-wordpress-enum -p 80,443 192.168.1.1


nmap --script http-wordpress-enum --script-args limit=25 -p 80 192.168.1.1





9.4 http-wordpress-brute — WordPress Şifrə Sınağı


WordPress admin panelinin wp-login.php formasına qarşı brute-force aparır.


nmap --script http-wordpress-brute --script-args userdb=users.txt,passdb=pass.txt -p 80 192.168.1.1





9.5 http-userdir-enum — Apache UserDir Skanı


Apache-nin mod_userdir modulundan istifadə edən serverlarda istifadəçi hesablarını tapa bilir (/~username URL şablonu).


nmap --script http-userdir-enum -p 80 192.168.1.1





9.6 http-open-redirect — Açıq Yönləndirmə


Veb tətbiqinin açıq URL yönləndirilməsi (open redirect) zəifliyini yoxlayır. Fişinq hücumlarında istifadə oluna bilər.


nmap --script http-open-redirect -p 80,443 192.168.1.1





9.7 http-xssed — XSS Zəifliyi Yoxlaması


Veb tətbiqinin URL parametrlərini XSS (Cross-Site Scripting) hücumlarına qarşı sınaqdan keçirir.


nmap --script http-xssed -p 80 192.168.1.1





9.8 http-phpmyadmin-dir-traversal — phpMyAdmin


phpMyAdmin-də yol gezinmə (directory traversal) zəifliyini yoxlayır. CVE-2010-3055 ilə əlaqəlidir.


nmap --script http-phpmyadmin-dir-traversal -p 80 192.168.1.1





9.9 http-joomla-brute — Joomla Brute-Force


Joomla CMS-in administrator panelindəki giriş formasına qarşı brute-force aparır.


nmap --script http-joomla-brute -p 80 192.168.1.1



10. BROADCAST Kateqoriyası — Şəbəkə Kəşfiyyatı


Broadcast skriptləri hədəf göstərmədən şəbəkəyə broadcast paketlər göndərərək aktiv cihazları, xidmətləri və məlumatları kəşf edir.





10.1 broadcast-arp-ping — ARP Kəşfi


ARP (Address Resolution Protocol) broadcast göndərərək yerli şəbəkədəki cihazları tapır. Firewall ARP-ı bloklaya bilmədiyindən daha etibarlıdır.


nmap --script broadcast-arp-ping





10.2 broadcast-dhcp-discover — DHCP Serverini Tap


Şəbəkədəki DHCP serverlərini aşkar etmək üçün broadcast DHCP DISCOVER paketi göndərir.


nmap --script broadcast-dhcp-discover





10.3 broadcast-dns-service-discovery — DNS-SD


Bonjour/Avahi (mDNS) protokolu ilə yerli şəbəkədəki xidmətləri kəşf edir. Printerler, NAS cihazlar, Apple cihazlar bu protokolu istifadə edir.


nmap --script broadcast-dns-service-discovery





10.4 broadcast-netbios-master-browser — NetBIOS


NetBIOS name service ilə Windows iş qruplarını və domenlerini tapır. Köhnə Windows şəbəkə kəşfiyyatı üçün istifadə olunur.


nmap --script broadcast-netbios-master-browser





10.5 broadcast-upnp-info — UPnP Cihazlar


Universal Plug and Play (UPnP) broadcast göndərərək şəbəkədəki UPnP-aktiv cihazları (router, printer, smart TV) tapır.


nmap --script broadcast-upnp-info





10.6 broadcast-wpad-discover — WPAD Aşkarı


WPAD (Web Proxy Auto-Discovery) protokolu ilə proxy server konfigurasiyasını aşkar edir. Yanlış konfiqurasiya MITM hücumuna yol aça bilər.


nmap --script broadcast-wpad-discover



11. SAFE Kateqoriyası — Təhlükəsiz Skriptlər


Safe kateqoriyasındakı skriptlər hədəf sistemi pozmaz. Pentestdə ilk mərhələdə, icazəsiz skanın mümkün olmadığı hallarda əla seçimdir.





11.1 ssh-hostkey — SSH Host Açarı


SSH serverinin host açarını və onun barmaq izini (fingerprint) alır. Açarın növü (RSA, ECDSA, ED25519) və bit uzunluğu göstərilir.


nmap --script ssh-hostkey -p 22 192.168.1.1


Nümunə çıxış:


| ssh-hostkey:


|   2048 aa:bb:cc:dd:ee:ff:00:11:22:33:44:55:66:77:88:99 (RSA)


|_  256 11:22:33:44:55:66:77:88:99:00:aa:bb:cc:dd:ee:ff (ECDSA)





11.2 ssl-cert — SSL Sertifikat Detalları


Etibarlılıq tarixi bitmiş, özimzalı (self-signed) və ya zəif şifrəli sertifikatları aşkar edir.


nmap --script ssl-cert -p 443 192.168.1.1





11.3 http-server-header — Server Başlığı


Veb serverin "Server:" HTTP başlığını alır. Çox vaxt server adı və versiyasını açıqlayır.


nmap --script http-server-header -p 80,443 192.168.1.1





11.4 smtp-commands — SMTP Komandaları


SMTP serverinin dəstəklədiyi komandaları (EHLO, AUTH, STARTTLS, SIZE) siyahılayır.


nmap --script smtp-commands -p 25,587 192.168.1.1





11.5 imap-capabilities — IMAP Qabiliyyətləri


IMAP e-poçt serverinin dəstəklədiyi xüsusiyyətləri siyahılayır.


nmap --script imap-capabilities -p 143,993 192.168.1.1





11.6 pop3-capabilities — POP3 Qabiliyyətləri


POP3 e-poçt serverinin dəstəklədiyi xüsusiyyətləri siyahılayır.


nmap --script pop3-capabilities -p 110,995 192.168.1.1



12. Praktiki Kombinasiyalar və İş Ssenarilər


Gerçək pentestdə bir neçə skan tipi və skript birlikdə istifadə olunur. Aşağıda ən çox rastlanan ssenarilər üçün hazır komandalar verilmişdir.





12.1 Tam Şəbəkə Kəşfiyyatı


Bir alt şəbəkədəki bütün cihazları, açıq portları, servisləri və OS-ləri tapır:


sudo nmap -sn 192.168.1.0/24 -oG alive_hosts.txt


sudo nmap -sV -sC -O -T4 192.168.1.0/24 -oA network_scan





12.2 Veb Server Tam Analizi


HTTP/HTTPS xidmətini hər açıdan analiz edir:


nmap -sV -p 80,443,8080,8443 \


  --script http-enum,http-headers,http-methods,http-title,\


  http-robots.txt,ssl-cert,ssl-enum-ciphers \


  192.168.1.1





12.3 Tam Zəiflik Skanı


Ən kritik CVE-ləri tez yoxlamaq üçün:


sudo nmap -sV --script vuln -p- 192.168.1.1





Yalnız SMB zəifliklərini yoxlamaq üçün:


nmap --script smb-vuln-ms17-010,smb-vuln-ms08-067,smb-vuln-cve-2017-7494 -p 445 192.168.1.1





12.4 SSL/TLS Sertifikat Auditi


nmap --script ssl-cert,ssl-enum-ciphers,ssl-heartbleed,ssl-poodle,ssl-drown -p 443 192.168.1.1





12.5 Windows Active Directory Kəşfi


nmap -sV --script smb-enum-shares,smb-enum-users,smb-os-discovery,\


  ms-sql-info,ms-sql-empty-password -p 445,1433 192.168.1.1





12.6 Nəticələri Faylda Saxlamaq


Nmap skan nəticələrini müxtəlif formatlarda saxlamaq mümkündür:


nmap -sV 192.168.1.1 -oN normal.txt       # Oxunaqlı mətn


nmap -sV 192.168.1.1 -oX results.xml      # XML (Metasploit import)


nmap -sV 192.168.1.1 -oG grep.txt         # Grep-dostu format


nmap -sV 192.168.1.1 -oA full_scan        # Bütün formatlar eyni anda





12.7 IPv6 Skanı


nmap -6 2001:db8::1                   # Tək IPv6


nmap -6 --script ipv6-node-info ::1   # IPv6 məlumatı





12.8 Çıxışı Başqa Alətlərə Ötürmək


Nmap XML çıxışını Metasploit Framework-ə import etmək:


msf> db_import /path/to/results.xml


XML-dən IP siyahısı çıxarmaq (xmllint ilə):


xmllint --xpath '//address/@addr' results.xml | tr ' ' '\n' | sed "s/addr=//g;s/\"//g"



13. Öz NSE Skriptini Yazmaq


NSE skriptləri Lua dilində yazılır. Öz skriptinizi yazmaq üçün Nmap-ın Lua API-sini öyrənməlisiniz.





13.1 Skript Strukturu


Hər NSE skriptinin üç əsas hissəsi var: metadata, kural (rule) funksiyası, əsas (action) funksiyası.


-- Skript metadata


description = [[


  Bu skript hədəf serverin HTTP başlıqlarını analiz edir.


]]





-- Kateqoriyalar


categories = {"safe", "discovery"}





-- İstifadə olunan Nmap kitabxanaları


local http = require "http"


local nmap = require "nmap"


local shortport = require "shortport"





-- Hansı portlarda işləyəcək (80 və 443)


portrule = shortport.http





-- Əsas funksiya


action = function(host, port)


  local response = http.get(host, port, "/")


  if response and response.status == 200 then


    return "HTTP cavabı: " .. response.status


  end


end





13.2 Skripti Qurmaq


Hazır skripti Nmap-ın skript qovluğuna köçürün:


sudo cp myscript.nse /usr/share/nmap/scripts/


sudo nmap --script-updatedb


nmap --script myscript 192.168.1.1





13.3 Faydalı Nmap Lua Kitabxanaları

Skript adı
Təsvir
http
HTTP sorğuları göndərmək üçün
smtp
SMTP protokolu ilə əlaqə
ftp
FTP protokolu ilə əlaqə
ssh2
SSH protokolu ilə əlaqə
dns
DNS sorğuları etmək üçün
brute
Brute-force infrastrukturu
creds
Credential (istifadəçi/şifrə) idarəetmə
vulns
Zəiflik hesabatlama infrastrukturu
nmap
Nmap-ın daxili API-si
stdnse
Standart NSE köməkçi funksiyalar
shortport
Port qayda şablonları (http, ssl, ssh, ...)


14. Nmap və Digər Alətlər Müqayisəsi




Skript adı
Təsvir
Nmap
Güclü port skaneri, NSE ilə genişlənir, pulsuz
Masscan
İnternet miqyasında sürətli skan, lakin NSE yoxdur
Unicornscan
Çox sürətli UDP/TCP skan, async arxitektura
Nessus
Kommersial zəiflik skaneri, 60,000+ plugin
OpenVAS
Açıq mənbəli zəiflik skaneri, Nessus alternativ
Metasploit
Exploit framework, Nmap nəticələrini import edir
Nikto
Yalnız veb server skaneri, 7000+ test
ZAP
OWASP veb tətbiqi güvenlik skaneri
Shodan
Kənar şəbəkə kəşfiyyat axtarış motoru




15. Xülasə


Nmap kibertəhlükəsizlik sahəsinin ən fundamental alətlərindən biridir. NSE skriptləri ilə birlikdə aşağıdakı əməliyyatları avtomatlaşdıra bilərsiniz:


	Şəbəkə inventarı — hansı cihazlar var, hansı portlar açıq


	Servis kəşfi — veb serverlər, verilənlər bazaları, uzaqdan idarə xidmətlər


	Zəiflik qiymətləndirilməsi — CVE yoxlaması, şifrə sınağı


	Uyğunluq yoxlaması — SSL/TLS konfigurasyonu, açıq servisler


	Müdaxilə aşkarı testləri — şəbəkə nöqtə testləri (penetration testing)




✅ Qanuni istifadə: Həmişə yazılı icazə alın. Öz sistemlərinizi skan edin. Test mühitlərindən (Metasploitable, TryHackMe, HackTheBox) istifadə edin.




Daha ətraflı məlumat üçün rəsmi sənədləşmə: https://nmap.org/docs.html


NSE skriptlər siyahısı: https://nmap.org/nsedoc/
