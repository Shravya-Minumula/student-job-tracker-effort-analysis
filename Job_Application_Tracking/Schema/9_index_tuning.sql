-- a. Identify Missing Indexes (Performance Diagnostic)
SELECT 
    migs.user_seeks + migs.user_scans AS TotalUsage,
    mid.statement AS TableName,
    mid.equality_columns,
    mid.inequality_columns,
    mid.included_columns,
    migs.avg_total_user_cost AS AvgCost,
    migs.avg_user_impact AS AvgImpact
FROM sys.dm_db_missing_index_group_stats AS migs
INNER JOIN sys.dm_db_missing_index_groups AS mig
    ON migs.group_handle = mig.index_group_handle
INNER JOIN sys.dm_db_missing_index_details AS mid
    ON mig.index_handle = mid.index_handle
WHERE database_id = DB_ID('JobAppTrackingDB')
ORDER BY TotalUsage DESC;

-- b. Implementing Suggested Index (based on query plan insight)
CREATE NONCLUSTERED INDEX IX_JobApplications_Status
ON JobApplications (Status)
INCLUDE (CompanyName, ApplicationDate);

