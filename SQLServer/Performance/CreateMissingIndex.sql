SELECT 'CREATE INDEX [SmartIndex_' + OBJECT_NAME(T3.object_id) + '_'
	+ REPLACE(REPLACE(REPLACE(REPLACE(
	ISNULL(T3.equality_columns, T3.inequality_columns), ', ', '_'), '[', ''), ']', ''), ' ', '')
	+ '] ON [' + SCHEMA_NAME(T4.schema_id) + '].[' + OBJECT_NAME(T3.object_id) + '] ('
	+ ISNULL(T3.equality_columns, '')
	+ CASE WHEN T3.equality_columns IS NOT NULL
	AND T3.inequality_columns IS NOT NULL THEN ', ' ELSE '' END
	+ ISNULL(T3.inequality_columns, '') + ')'
	+ CASE WHEN T3.included_columns IS NOT NULL THEN ' INCLUDE (' + T3.included_columns + ')' ELSE '' END
	+ ' WITH (FILLFACTOR=70);' AS [DDL]
FROM sys.dm_db_missing_index_group_stats T1
INNER JOIN sys.dm_db_missing_index_groups T2 ON T2.index_group_handle = T1.group_handle
INNER JOIN sys.dm_db_missing_index_details T3 ON T3.index_handle = T2.index_handle
INNER JOIN sys.objects T4 ON T4.object_id = T3.object_id
WHERE T3.database_id = db_id()
ORDER BY T1.avg_user_impact DESC