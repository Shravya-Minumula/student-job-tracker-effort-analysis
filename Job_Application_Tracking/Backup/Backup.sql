
--Full Backup

Backup database JobAppTrackingDB
to disk = 'C:\jobapptracking\backups\jobapptracking_full.bak' 
WITH INIT, STATS = 10;

--Differential Backup

Backup database JobAppTrackingDB
to disk = 'C:\jobapptracking\backups\jobapptracking_diff.bak' 
WITH differentail, STATS = 10;

--Log Backup

Backup log JobAppTrackingDB
to disk = 'C:\jobapptracking\backups\jobapptracking_L1.trn' 
WITH INIT, STATS = 10;