 SELECT T1.name AS [Database]
	, ISNULL(T2.physical_device_name, 'DANGER!!!') AS [Backup]
	, T2.backup_size AS [Size]
	, T2.backup_start_date AS [StartDate]
	, T2.backup_finish_date AS [FinishDate]
FROM master.sys.sysdatabases T1
LEFT JOIN
(
	SELECT T2.database_name
		, T1.physical_device_name
		, T2.backup_size
		, T2.backup_start_date
		, T2.backup_finish_date
	FROM msdb.dbo.backupmediafamily T1
	INNER JOIN msdb.dbo.backupset T2 ON T1.media_set_id = T2.media_set_id
	INNER JOIN
	(
		SELECT database_name, MAX(backup_finish_date) AS backup_finish_date
		FROM msdb.dbo.backupset
		WHERE TYPE = 'D'
		GROUP BY database_name
	) T3 ON T3.database_name = T2.database_name AND T3.backup_finish_date = T2.backup_finish_date
) T2 ON  T2.database_name = T1.name
ORDER BY T2.backup_finish_date DESC, T1.name