USE msdb;
GO

EXEC sp_add_job  
    @job_name = N'Daily_diff_jobapptracking';

EXEC sp_add_jobstep  
    @job_name = N'Daily_diff_jobapptracking',
    @step_name = N'S2',
    @subsystem = N'TSQL',
    @command = N'
        BACKUP DATABASE JobAppTrackingDB
        TO DISK = ''C:\jobapptracking\backups\JobAppTrackingDB_diff.bak''
        WITH DIFFERENTIAL, STATS = 10;',
    @database_name = N'master';

EXEC sp_add_schedule  
    @schedule_name = N'diff_JobAppTracking',  
    @freq_type = 4,  -- Daily  
    @freq_interval = 2,  
    @active_start_time = 000000; -- 12:00 AM

EXEC sp_attach_schedule  
   @job_name = N'Daily_diff_jobapptracking',  
   @schedule_name = N'diff_JobAppTracking';

EXEC sp_add_jobserver  
    @job_name = N'Daily_diff_jobapptracking';
