CREATE PROCEDURE sp_GetEffortSummary
    @StudentID INT
AS
BEGIN
    SELECT 
        s.FullName,
        COUNT(DISTINCT ja.ApplicationID) AS TotalApplications,
        COUNT(DISTINCT f.FollowUpID) AS TotalFollowUps,
        COUNT(DISTINCT i.InterviewID) AS InterviewsAttended
    FROM Students s
    LEFT JOIN JobApplications ja ON s.StudentID = ja.StudentID
    LEFT JOIN FollowUps f ON ja.ApplicationID = f.ApplicationID
    LEFT JOIN Interviews i ON ja.ApplicationID = i.ApplicationID
    WHERE s.StudentID = @StudentID
    GROUP BY s.FullName;
END;
GO

CREATE PROCEDURE sp_GenerateStudentReport
AS
BEGIN
    SELECT * FROM vw_StudentEffortSummary;
END;
GO

CREATE PROCEDURE dbo.LogQueryPerformance
AS
BEGIN
    INSERT INTO dbo.QueryPerformanceLog (QueryText, TotalCPU_ms, AvgCPU_ms, ExecutionCount)
    SELECT TOP 10 
        SUBSTRING(qt.text, (qs.statement_start_offset/2)+1,
          ((CASE qs.statement_end_offset
            WHEN -1 THEN DATALENGTH(qt.text)
            ELSE qs.statement_end_offset END
            - qs.statement_start_offset)/2) + 1),
        qs.total_worker_time/1000.0,
        qs.total_worker_time / qs.execution_count / 1000.0,
        qs.execution_count
    FROM sys.dm_exec_query_stats qs
    CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) as qt
    ORDER BY qs.total_worker_time DESC;
END;
GO
