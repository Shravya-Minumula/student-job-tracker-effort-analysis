CREATE TRIGGER trg_UpdateEffortMetrics
ON JobApplications
AFTER INSERT, DELETE
AS
BEGIN
    PRINT 'EffortMetrics needs update - consider executing sp to refresh monthly data.';
END;
GO
