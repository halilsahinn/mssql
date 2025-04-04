/*
<Author>      : Halil Şahin
<Created Date>: 04.04.2025
<Description> : Bu kod parçası, belirli bir sütun adını içeren tabloları ve şemaları bulmak ve bu tablolar için genel SELECT sorguları oluşturmak amacıyla yazılmıştır.
Belirtilen sütun adını içeren tüm tabloları ve o sütunların bulunduğu şemaları listeler.
Aynı zamanda, her tablo için basit bir 'SELECT *' sorgusu oluşturur. Kullanıcı, sorgulamak istediği sütun adını @ColumnName parametresi aracılığıyla belirtebilir.
*/

DECLARE @ColumnName NVARCHAR='dosya'  -- Aranacak sütun adı, burada 'dosya' olarak belirlenmiştir.

-- Aşağıdaki sorgu, veritabanındaki tüm tablo, sütun ve şemaları sıralayarak işlem yapar.
SELECT 
    s.name AS [SchemeName],      -- Şema adı
    t.name AS [TableName],       -- Tablo adı
    c.name AS [ColumnName],      -- Sütun adı
    'SELECT * FROM ' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name) + ';' AS SelectSorgusu  -- Tablo için hazırlanan SELECT sorgusu
FROM 
    sys.tables AS t              -- Veritabanındaki tüm tablolar
INNER JOIN 
    sys.columns AS c ON t.object_id = c.object_id  -- Her tablonun sütunları
INNER JOIN 
    sys.schemas AS s ON t.schema_id = s.schema_id  -- Tabloların bağlı olduğu şemalar
WHERE 
    c.name LIKE '%'+@ColumnName+'%'  -- Sütun adı, belirtilen metni içeren sütunları filtreler
ORDER BY 
    [SchemeName], [TableName]   -- Sonuçlar şema adına ve tablo adına göre sıralanır.
