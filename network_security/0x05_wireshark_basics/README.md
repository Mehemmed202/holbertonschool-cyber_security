# WIRESHARK FILTERS

Bu sənəd Wireshark-da istifadə olunan **Capture Filters** və **Display Filters** anlayışlarını qısa, aydın və README formatına uyğun şəkildə izah edir.

---

## 1. Capture Filters (Yaxalama Filtrləri)

**Capture filter-lər** paketlər **yaxalanmazdan əvvəl** tətbiq olunur. Bu filtrlər Wireshark-a yalnız müəyyən şərtlərə uyğun gələn paketləri yaddaşa yazmağı, digərlərini isə tamamilə görməzdən gəlməyi tapşırır.

**Xüsusiyyətlər:**

* Paket tutulmazdan əvvəl işləyir
* Performansı artırır
* Sonradan dəyişdirilə bilməz
* `tcpdump / BPF` sintaksisi istifadə edir

### Nümunələr

```text
host 192.168.1.10
```

Yalnız bu IP ünvanına aid paketləri tutur.

```text
net 192.168.1.0/24
```

192.168.1.0/24 şəbəkəsindəki bütün trafiki tutur.

```text
port 80
```

Yalnız HTTP (port 80) trafiki tutulur.

```text
not icmp
```

ICMP (ping) paketləri tutulmur.

---

## 2. Display Filters (Görüntüləmə Filtrləri)

**Display filter-lər** paketlər artıq tutulduqdan sonra, **analiz mərhələsində** istifadə olunur. Bütün paketlər yaddaşda qalır, lakin ekranda yalnız seçilmiş paketlər göstərilir.

**Xüsusiyyətlər:**

* Tutulmuş paketlər üzərində işləyir
* İstənilən vaxt dəyişdirilə bilər
* Analiz üçün əsas vasitədir
* Wireshark-a məxsus sintaksis istifadə edir

### Ən çox istifadə olunan Display Filter-lər

| Filtr növü  | Nümunə                         | İzah                                    |
| ----------- | ------------------------------ | --------------------------------------- |
| Protokol    | `http` və ya `dns`             | Yalnız göstərilən protokolları göstərir |
| IP ünvanı   | `ip.addr == 192.168.1.1`       | Mənbə və ya hədəfi bu IP olan paketlər  |
| Mənbə       | `ip.src == 1.1.1.1`            | Yalnız göndərən IP bu olan paketlər     |
| Port        | `tcp.port == 443`              | HTTPS trafiki                           |
| HTTP Method | `http.request.method == "GET"` | Yalnız GET sorğuları                    |

---

## 3. Məntiqi Operatorlar

Display filter-lərdə şərtləri birləşdirmək üçün məntiqi operatorlardan istifadə olunur.

### AND (&&)

Hər iki şərt eyni anda ödənməlidir.

```text
ip.addr == 192.168.1.1 && tcp.port == 80
```

### OR (||)

Şərtlərdən hər hansı biri ödənsə kifayətdir.

```text
http || dns
```

### NOT (!)

Şərti inkar edir.

```text
!arp
```

ARP paketləri istisna olmaqla bütün paketləri göstərir.

---

## Qısa Xülasə

* **Capture Filters** → əvvəlcədən filtrasiya, performans üçün
* **Display Filters** → analiz zamanı filtrasiya
* Real trafik analizi əsasən **Display Filter**-lər üzərindən aparılır

Bu README Wireshark ilə işləyərkən sürətli istinad (cheat-sheet) kimi istifadə oluna bilər.

