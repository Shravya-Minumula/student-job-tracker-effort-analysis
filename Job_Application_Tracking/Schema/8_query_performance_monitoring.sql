-- Create Table to Log Query Performance
CREATE TABLE dbo.QueryPerformanceLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    LogDate DATETIME DEFAULT GETDATE(),
    QueryText NVARCHAR(MAX),
    TotalCPU_ms FLOAT,
    AvgCPU_ms FLOAT,
    ExecutionCount INT
);

-- Create Stored Procedure to Log Performance
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
