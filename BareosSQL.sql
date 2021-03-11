 #SELECT DO CONSUMO TOTAL DE BYTES
SELECT SUM(VolBytes) AS BytesTotal FROM Media;

#SELECT DO ULTIMO JOB
SELECT * FROM Job WHERE (JobStatus ="T" or JobStatus ="f") ORDER BY JobId Desc LIMIT 7;

#DATE FORMAT
SELECT DATE_FORMAT(CURDATE(),'%Y%m');

#SELECT DE VOLUMES DEFINIDO PELA DATA
SELECT 
Mediaid AS Id,
CONVERT(Pool.Name USING utf8) AS 'Pool',
CONVERT(VolumeName USING utf8) AS 'Nome do Volume',
VolBytes AS 'Tamanho',
VolStatus 'Status',
LastWritten,
CONVERT(MediaType USING utf8) AS 'Tipo',
PERIOD_DIFF(DATE_FORMAT(NOW(),'%Y%m'),DATE_FORMAT(LastWritten,'%Y%m')) AS 'Periodo'
FROM Media
INNER JOIN Pool ON Pool.PoolId=Media.PoolId
INNER JOIN Storage ON Media.StorageId = Storage.StorageId
WHERE  Storage.Name="File-srvarq" AND lastwritten  = '2021-01-30 21:15:12' GROUP BY lastwritten;

##SELECT DE TOTAL DE VOLUMES EM USO
SELECT 
Mediaid AS Id,
CONVERT(Pool.Name USING utf8) AS 'Pool',
CONVERT(VolumeName USING utf8) AS 'Nome do Volume',
VolBytes AS 'Tamanho',
VolStatus 'Status',
LastWritten,
CONVERT(MediaType USING utf8) AS 'Tipo',
PERIOD_DIFF(DATE_FORMAT(NOW(),'%Y%m'),DATE_FORMAT(LastWritten,'%Y%m')) AS 'Periodo'
FROM Media
INNER JOIN Pool ON Pool.PoolId=Media.PoolId
INNER JOIN Storage ON Media.StorageId = Storage.StorageId
WHERE  Storage.Name="File-srvarq"  and Pool.Name ='Differential' GROUP BY lastwritten ;

#SELECT DOS STORAGES DISPONIVEIS
SELECT CONVERT(Name USING utf8), StorageId FROM Storage;
SELECT CONVERT(VolumeName USING utf8) FROM Media WHERE StorageId=3 AND LastWritten < '2021-02-06' GROUP BY LastWritten;
SELECT COUNT(VolumeName) FROM Media WHERE StorageId=3 AND LastWritten < '2021-02-06;'