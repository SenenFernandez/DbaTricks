SELECT DISTINCT T2.volume_mount_point AS Drive
	, T2.total_bytes/1048576/1024 AS TotalSpace
	, T2.available_bytes/1048576/1024 AS FreeSpace
FROM sys.master_files T1
CROSS APPLY sys.dm_os_volume_stats(T1.database_id, T1.file_id) T2
ORDER BY FreeSpace