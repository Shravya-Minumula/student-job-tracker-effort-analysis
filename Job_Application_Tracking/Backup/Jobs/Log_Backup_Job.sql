USE msdb;
GO

EXEC sp_add_job  
    @job_name = N'Daily_log_jobapptracking';

EXEC sp_add_jobstep  
    @job_name = N'Daily_log_jobapptracking',
    @step_name = N'S3',
    @subsystem = N'TSQL',
    @command = N'
        BACKUP LOG JobAppTrackingDB
        TO DISK = ''C:\jobapptracking\backups\JobAppTrackingDB_log.trn''
        WITH INIT, STATS = 10;',
    @database_name = N'master';

EXEC sp_add_schedule  
    @schedule_name = N'JobAppTracking_log',  
    @freq_type = 4,  -- Daily  
    @freq_interval = 1,  -- Every day
    @freq_subday_type = 4,  -- Minutes
    @freq_subday_interval = 30,  -- Every 30 minutes
    @active_start_time = 000000;  -- Start at 12:00 AM


EXEC sp_attach_schedule  
   @job_name = N'Daily_log_jobapptracking',  
   @schedule_name = N'JobAppTracking_log';

EXEC sp_add_jobserver  
    @job_name = N'Daily_log_jobapptracking';
