-- 1. Set the database to SINGLE_USER to force disconnect users (if needed)
ALTER DATABASE JobAppTrackingDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- 2. Restore Full Backup
RESTORE DATABASE JobAppTrackingDB
FROM DISK = 'C:\jobapptracking\backups\jobapptracking_full.bak'
WITH 
    NORECOVERY,   
    REPLACE,      
    STATS = 10;

-- 3. Restore Differential Backup
RESTORE DATABASE JobAppTrackingDB
FROM DISK = 'C:\jobapptracking\backups\jobapptracking_diff.bak'
WITH 
    NORECOVERY,   
    STATS = 10;

-- 4. Restore Log Backup(s)
RESTORE LOG JobAppTrackingDB
FROM DISK = 'C:\jobapptracking\backups\jobapptracking_L1.trn'
WITH 
    RECOVERY,     
    STATS = 10;

-- 5. Set database back to MULTI_USER
ALTER DATABASE JobAppTrackingDB SET MULTI_USER;
