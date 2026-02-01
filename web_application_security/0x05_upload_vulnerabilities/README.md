🛡️ File Upload Security Guide

Bu sənəd veb tətbiqlərdə fayl yükləmə (File Upload) funksiyalarını zərərli hücumlardan qorumaq üçün lazımi yoxlama prosedurlarını əhatə edir.
📝 Sual və Düzgün Cavablar

Sual: Fayl yükləmə boşluqlarının (vulnerabilities) qarşısını almaq üçün nə yoxlanılmalıdır?
Seçilməli olan düzgün variantlar:

    MIME types and file content ✅

    Upload location permissions ✅

🔍 Texniki İzah

Təhlükəsiz fayl yükləmə sistemi qurmaq üçün aşağıdakı tədbirlər mütləqdir:
1. MIME Types və Fayl Məzmunu (Magic Numbers)

Yalnız faylın sonluğuna (.jpg, .pdf) güvənmək olmaz. Təcavüzkar zərərli PHP skriptinin adını foto.jpg qoyaraq sistemi aldada bilər.

    MIME Type: Server tərəfində faylın tipi (məs: image/png) yoxlanılmalıdır.

    Magic Numbers: Faylın ilk baytları (File Signatures) analiz edilməlidir. Məsələn, bir JPEG faylı həmişə FF D8 FF baytları ilə başlayır.

2. Yükləmə Qovluğu İcazələri (Upload Location Permissions)

Faylların saxlandığı qovluq düzgün konfiqurasiya edilməlidir:

    Execution Prevention: Yüklənən faylların olduğu qovluqda "İcra etmə" (Execute) icazəsi söndürülməlidir. Bu, təcavüzkarın serverə skript yükləsə belə, onu işə sala bilməməsini təmin edir.

    Web Root: Mümkünsə, faylları veb-kök qovluğundan (public_html və ya www) kənarda saxlayın.

🚫 Niyə Digər Variantlar Yanlışdır?

    File extension only: Ən zəif üsuldur. Təcavüzkarın sonluğu dəyişməsi saniyələr alır.

    User’s reputation: Reputasiyası yaxşı olan bir istifadəçinin hesabı ələ keçirilmiş (hijacked) ola bilər.

    Secure transport protocols (HTTPS): HTTPS yalnız məlumatın ötürülməsi zamanı şifrələməni təmin edir. Zərərli faylın daxilindəki kodu skan etmir.

🚀 Təhlükəsizlik üçün Check-list

    [ ] Faylı yükləyərkən adını təsadüfi bir silsilə ilə (UUID) dəyişdirin.

    [ ] Maksimum fayl ölçüsünü (Size Limit) təyin edin.

    [ ] Faylları imkan daxilində antivirus skanerindən keçirin.

    [ ] Yükləmə qovluğunda .htaccess vasitəsilə skript icrasını qadağan edin.
