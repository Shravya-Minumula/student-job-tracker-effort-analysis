Project Title:
 SQL Server–Based Student Job Application and Effort Tracking System

Technologies Used:
• Database: Microsoft SQL Server 2019
• Language: T-SQL (Transact-SQL)
• Management Tool: SQL Server Management Studio (SSMS)
• Backup & Recovery: SQL Server Agent, SQL Server Jobs
• Monitoring: Dynamic Management Views (DMVs)
• Security: SQL Server Authentication and Role-Based Access Control

Project Overview:
 This project implements a robust and scalable database system called JobAppTrackingDB, built using
 Microsoft SQL Server. It is designed to help students, career counselors, and faculty track and manage
 student job applications, resume versions, follow-ups, interviews, and overall job-seeking effort. It features
 comprehensive role-based access control, backup and recovery strategies, query performance monitoring,
 and data views for efficient reporting and analysis.

Objective:
• Enable centralized tracking of student job applications and interactions.
•  Help placement officers and faculty monitor student progress and support them.
• Measure and report effort metrics for monthly or term-wise evaluations.
•  Implement SQL Server best practices including indexing, security, performance monitoring, and backup/recovery.

Key Features:
• Data Modeling: 7 core tables: Interviews , Students , ResumeVersions , JobApplications , FollowUps , EffortMetrics , QueryPerformanceLog .
• Data Relationships: One-to-many relationships between Students and their resume versions, job applications, follow-ups, and interviews.
• Stored Procedures: For generating effort summaries and student-level reports.
• Triggers: Basic triggers like trg_UpdateEffortMetrics to alert on job application changes.
• Views:vw_ApplicationSummary , vw_StudentEffortSummary for easier reporting.
• Security: Role-based access with logins and database users for both students and faculty roles.
• Monitoring: Logs top 10 CPU-intensive queries using dynamic management views.
• Index Tuning: Implements missing index suggestions and creates custom indexes for faster querying.
• Backups: Full, differential, and log backups scheduled using SQL Server Agent jobs.
• Restores: Restores implemented through a structured process using NORECOVERY and RECOVERY clauses to maintain transactional consistency.

Tables Overview:
• Students : Stores student profile information.
• ResumeVersions : Tracks multiple resume versions per student.
• JobApplications : Logs each application along with company, title, and status.
• FollowUps : Stores communication records like email, phone calls, or LinkedIn messages.
• Interviews : Records interview stages and results.
• EffortMetrics : Summarizes job-seeking activity per month.
• QueryPerformanceLog : Captures top resource-consuming queries.

Sample Functional Queries:
• EXEC sp_GetEffortSummary @StudentID = 1 – Shows a student’s job-seeking effort.
•  SELECT * FROM vw_StudentEffortSummary – Reports all students' application and interview
 metrics.
•  SELECT * FROM Students – Retrieves basic student data.

 Security and Roles:
 • StudentUser1 to 
StudentUser30 ➔ Assigned to StudentsRole with SELECT access only.
• PlacementHead , HOD , Dean , etc. ➔ Assigned to FacultyRole with CRUD access.

Backup & Recovery:
• Full Backup: A complete snapshot of the entire database. Performed daily and stored in a .bak file (e.g., jobapptracking_full.bak).
• Differential Backup: Captures only the changes made since the last full backup. Stored in .bak format (e.g., jobapptracking_diff.bak) and scheduled every 6 hours.
• Transaction Log Backup: Records all database transactions since the last log backup, allowing point-in-time recovery. Stored as .trn files (e.g., jobapptracking_L1.trn) and scheduled every 30 minutes.
• Restore Process: Restores follow the correct sequence: Full → Differential → Logs using WITH NORECOVERY and WITH RECOVERY options to maintain consistency and avoid data loss.
• Jobs for all backups are scheduled via SQL Server Agent.

Query Performance Monitoring:
• Logs top 10 resource-heavy queries using LogQueryPerformance stored procedure.
• Uses system views: sys.dm_exec_query_stats , sys.dm_exec_sql_text .

Index Tuning:
• Missing indexes analyzed using system views. 
• Example: IX_JobApplications_Status index improves query efficiency on status filtering.

Future Scope:
• Integrate Log Shipping and Mirroring for High Availability.
• Use SQL Replication for reporting server setup.
•  Build a frontend application using .NET or Power BI for visualization.

 Conclusion:
 • This project demonstrates core SQL Server DBA skills including database design, stored procedures, views,
 triggers, security, performance tuning, and backup strategies. It can be expanded for real-world use in
 university career services or student success tracking systems
