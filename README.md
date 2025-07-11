# SQL SERVER–BASED STUDENT JOB APPLICATION AND EFFORT TRACKING SYSTEM

---

## Technologies Used :

- **Database:** Microsoft SQL Server 2019  
- **Language:** T-SQL (Transact-SQL)  
- **Management Tool:** SQL Server Management Studio (SSMS)  
- **Backup & Recovery:** SQL Server Agent, SQL Server Jobs  
- **Monitoring:** Dynamic Management Views (DMVs)  
- **Security:** SQL Server Authentication and Role-Based Access Control  

## Project Overview :

This project implements a robust and scalable SQL Server database system named **JobAppTrackingDB**, designed to support students, faculty, and placement officers in managing and tracking job application efforts.

It includes powerful features like role-based security, effort metrics calculation, query performance monitoring, and a structured backup/recovery strategy. The solution serves as an effective backend for academic institutions to track student progress throughout the placement journey.

## Objectives :

- Centralized tracking of student job applications and resume versions  
- Enable faculty and placement officers to monitor student progress  
- Measure and report student effort over time for evaluations  
- Apply best practices for indexing, security, performance, and recoverability in SQL Server  

## Key Features :

-*Data Modeling:* 7 well-structured core tables:
  - `Students`, `ResumeVersions`, `JobApplications`, `FollowUps`, `Interviews`, `EffortMetrics`, `QueryPerformanceLog`  
- *Data Relationships:* One-to-many relationships between students and their resumes, job applications, interviews, and follow-ups  
- *Stored Procedures:* Used to generate individual effort summaries and student reports  
- *Triggers:* Example: `trg_UpdateEffortMetrics` triggers effort metrics update on job application changes  
- *Views:*  
  - `vw_ApplicationSummary`: Summarizes job applications  
  - `vw_StudentEffortSummary`: Tracks student progress for reporting  
- *Security:* Role-based access for Students and Faculty using logins and user roles  
- *Monitoring:* Captures and logs top 10 CPU-intensive queries using DMVs  
- *Index Tuning:* Implements suggested and custom indexes for efficient performance  
- *Backup/Restore:* Complete backup and recovery system with job scheduling  

## Tables Overview :

| Table Name           | Description                                                                 |
|----------------------|-----------------------------------------------------------------------------|
| `Students`           | Stores student profile data                                                 |
| `ResumeVersions`     | Tracks resume revisions per student                                         |
| `JobApplications`    | Logs applications including company, job title, and status                  |
| `FollowUps`          | Tracks communication efforts (email, LinkedIn, phone, etc.)                |
| `Interviews`         | Records stages and outcomes of interviews                                   |
| `EffortMetrics`      | Summarizes monthly job-seeking activity                                     |
| `QueryPerformanceLog`| Logs queries consuming the most resources                                   |

## Sample Functional Queries :

-- Get a specific student's job-seeking effort summary
**EXEC sp_GetEffortSummary @StudentID = 1;**

-- Retrieve overall student effort summary
**SELECT * FROM vw_StudentEffortSummary;**

-- View all students' profiles
**SELECT * FROM Students;**

## Security and Roles :

- `StudentUser1` to `StudentUser30` ➝ Assigned to `StudentsRole` with **SELECT** (read-only) access.
- `PlacementHead`, `HOD`, `Dean`, etc. ➝ Assigned to `FacultyRole` with full **CRUD** (Create, Read, Update, Delete) privileges.
- Role-based access ensures controlled access to sensitive data.

## Backup and Recovery :

This project follows a structured backup and restore strategy to ensure data safety and recovery.

## Backup Types :

- **Full Backup**  
  - Captures a complete snapshot of the database.  
  - Stored in `.bak` format (e.g., `jobapptracking_full.bak`).  
  - Performed **daily**.

- **Differential Backup**  
  - Captures only the changes since the last full backup.  
  - Stored in `.bak` format (e.g., `jobapptracking_diff.bak`).  
  - Scheduled **every 6 hours**.

- **Transaction Log Backup**  
  - Records all transactions since the last log backup.  
  - Enables point-in-time recovery.  
  - Stored in `.trn` format (e.g., `jobapptracking_L1.trn`).  
  - Scheduled **every 30 minutes**.

### Restore Process :

- **Restore Sequence:**  
  `Full Backup ➝ Differential Backup ➝ Transaction Log Backups`

- **Important SQL Options:**  
  - Use `WITH NORECOVERY` for all intermediate restores.  
  - Use `WITH RECOVERY` only on the final step to bring the database online.

- All backup and restore jobs are automated using **SQL Server Agent**.

## Query Performance Monitoring :

This project logs and analyzes high-resource queries to optimize performance.

- Uses **Dynamic Management Views (DMVs)**:
  - `sys.dm_exec_query_stats`
  - `sys.dm_exec_sql_text`

- Custom stored procedure:
  - `LogQueryPerformance` logs the top 10 CPU-intensive queries to the `QueryPerformanceLog` table.

- Helps identify performance bottlenecks and tune inefficient queries.

## Index Tuning :

- Missing indexes are identified using DMV analysis.
- Custom indexes are created to improve query execution time.

### Example:

CREATE INDEX IX_JobApplications_Status 
ON JobApplications(Status);

## Future Scope :

- 🔁 **Integrate Log Shipping and Database Mirroring** to ensure high availability and disaster recovery.
- 🛰️ **Implement SQL Server Replication** to support a dedicated reporting server for analytics without affecting the live environment.
- 🖥️ **Develop a frontend application** using technologies like **.NET** or **Power BI** to provide visual dashboards, reports, and interactive tracking of student job application efforts.

## Conclusion :

This project showcases key **SQL Server DBA competencies**, including:

- Logical database design and normalization  
- Implementation of stored procedures, triggers, and views  
- Role-based access control for secure data usage  
- Query performance optimization using DMVs and indexing  
- Full backup and recovery strategies for data protection

By integrating real-world database practices, this system serves as a scalable solution for **student job application tracking**, offering immense value for **career services departments** or **academic institutions** aiming to monitor and support student career readiness.  
The project is fully extendable for enterprise-grade deployment and real-time reporting needs.

---
