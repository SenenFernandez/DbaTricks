SELECT 'KILL ' AS [Action]
	, T1.session_id AS [SessionId]
	, db_name(T3.dbid) AS [Database]
	, T1.host_process_id AS [ClientPid]
	, T1.host_name AS [DeviceName]
	, T2.client_net_address AS [RemoteIp]
	, T1.login_name UserName
	, T1.program_name ApplicationName
	, T1.cpu_time AS [TotalCpu]
	, T1.memory_usage AS [TotalRam]
	, T4.Connections
	, T4.NetTransport
	, T2.net_packet_size AS [NetPacketSize]
	, T3.text AS [Query]
FROM sys.dm_exec_sessions T1
INNER JOIN sys.dm_exec_connections T2 ON T2.session_id = T1.session_id
CROSS APPLY sys.dm_exec_sql_text(T2.most_recent_sql_handle) T3
INNER JOIN
(
	SELECT T1.dbid, T1.spid, T2.net_transport AS [NetTransport], count(T1.dbid) AS [Connections]
	FROM sys.sysprocesses T1
	INNER JOIN sys.dm_exec_connections T2 ON T2.session_id = T1.spid
	GROUP BY T1.dbid, T1.spid, T2.net_transport
) T4 ON T4.spid = T1.session_id
ORDER BY TotalCpu DESC, TotalRam DESC