--1. Full Backup Job
USE msdb;
GO

EXEC sp_add_job  
    @job_name = N'Daily_full_jobapptracking';

EXEC sp_add_jobstep  
    @job_name = N'Daily_full_jobapptracking',
    @step_name = N'S1',
    @subsystem = N'TSQL',
    @command = N'
       Backup database JobAppTrackingDB
       to disk = 'C:\jobapptracking\backups\jobapptracking_full.bak' 
	   WITH INIT, STATS = 10;
    @database_name = N'master';

EXEC sp_add_schedule  
    @schedule_name = N'full_jobapptracking',  
    @freq_type = 4,    
    @freq_interval = 1,  
    @active_start_time = 000000; -- 12:00 AM

EXEC sp_attach_schedule  
   @job_name = N'Daily_full_jobapptracking',  
   @schedule_name = N'full_jobapptracking';

EXEC sp_add_jobserver  
    @job_name = N'Daily_full_jobapptracking';


 