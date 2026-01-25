🛡️ SQL və NoSQL Injection Bələdçisi

Bu sənəd verilənlər bazası təhlükəsizliyi, inyeksiya zəiflikləri və müdafiə strategiyaları haqqında əsas məlumatları əhatə edir.
📊 1. SQL vs. NoSQL: Əsas Fərqlər

İnyeksiya növlərini anlamazdan əvvəl, bazaların struktur fərqlərini bilmək vacibdir.
Xüsusiyyət	SQL (Relational)	NoSQL (Non-relational)
Model	Cədvəllər, sətirlər və sütunlar	Sənədlər (JSON), Açar-Dəyər, Qraflar
Sema	Sabit və əvvəlcədən təyin olunmuş	Dinamik və elastik
Dil	Strukturlaşdırılmış Sorğu Dili (SQL)	Müxtəlif (məs: MongoDB Query Language)
Ölçəklənmə	Şaquli (Vertical)	Üfüqi (Horizontal)
💉 2. SQL Injection (CWE-89)

SQL Injection, tətbiqin istifadəçi tərəfindən daxil edilən xüsusi simvolları (məs: ', --, ;) SQL əmrinin bir hissəsi kimi səhvən qəbul etməsidir.

    Mahiyyəti: Hücumçu sorğu sintaksisinə müdaxilə edərək bazadan icazəsiz məlumat çəkir və ya məlumatları dəyişir.

Klassik Nümunə: ' OR '1'='1 payloadı ilə autentifikasiyadan yan keçmək.

Təsnifat: MITRE tərəfindən CWE-89 olaraq qeydiyyata alınmışdır.

🍃 3. NoSQL Injection (CWE-943)

NoSQL bazaları (məs: MongoDB) SQL istifadə etməsə də, sorğu sintaksisinə edilən müdahalələrə qarşı həssasdırlar.

    Mahiyyəti: Sorğu operatorlarının (məs: $gt, $ne) istifadəçi tərəfindən manipulyasiya edilməsidir.

    Nümunə: {"password": {"$ne": null}} sorğusu ilə parolu bilmədən giriş əldə etmək.

    Təsnifat: MITRE tərəfindən CWE-943 (NoSQL sorğu sintaksisinin düzgün təmizlənməməsi) olaraq qeyd edilir.

🛡️ 4. Qorunma Strategiyaları (Prevention)

Zəifliklərin qarşısını almaq üçün ən yaxşı təcrübələr:
SQL üçün:

    Prepared Statements (Variable Binding): Sorğu strukturunu məlumatdan ayırır və ən effektiv müdafiə üsuludur.

    Stored Procedures: Düzgün istifadə edildikdə (dinamik SQL-dən qaçaraq) inyeksiyanın qarşısını alır.

    Allow-list Input Validation: Yalnız gözlənilən formatda məlumatları qəbul etmək.

NoSQL üçün:

    Input Sanitization: Operator simvollarının ($, .) istifadəçi tərəfindən göndərilməsini məhdudlaşdırmaq.

    Schema Validation: Məlumatın strukturunu və tipini server tərəfindən yoxlamaq.

🔗 5. Faydalı İstinadlar

    OWASP: SQL Injection Prevention Cheat Sheet

    Hacker Tricks: SQLi Guide & NoSQLi Guide

    MITRE: CWE-89 & CWE-943
