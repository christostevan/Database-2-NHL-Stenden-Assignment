-- Backup: Full on Disk, append all existing data
BACKUP DATABASE [Netflix] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\Netflix.bak' WITH NOFORMAT, NOINIT, 
NAME = N'Netflix-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

-- Differential Backup, verify backup when finished, compressed the backup
BACKUP DATABASE [Test1] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\Defferential.bak' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  
NAME = N'Test1-Differential Database Backup', SKIP, NOREWIND, NOUNLOAD, COMPRESSION,  STATS = 10
GO
declare @backupSetId as int
select @backupSetId = position from msdb..backupset where database_name=N'Test1' and backup_set_id=(select max(backup_set_id) from msdb..backupset
 where database_name=N'Netflix' )
if @backupSetId is null begin raiserror(N'Verify failed. Backup information for database ''Netflix'' not found.', 16, 1) end
RESTORE VERIFYONLY FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\Netflix.bak' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
GO


-- Transactional Log Backup
BACKUP LOG [Netflix]
TO DISK
= 
'C:\Program Files\Microsoft SQL Sever\MSSQL15.SQLEXPRESS\MSSQL\Backup\Netflix.trn'
WITH
NOFORMAT, NOINIT, MEDIANAME = 'Native_SQLSeverLogBackup', NAME = 'Log-Netflix backup',
SKIP, NOREWIND, NOUNLOAD, STATS = 10
GO