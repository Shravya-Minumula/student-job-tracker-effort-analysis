-- a. Create View: vw_StudentEffortSummary
CREATE VIEW vw_StudentEffortSummary AS
SELECT 
    s.StudentID,
    s.FullName,
    COUNT(DISTINCT ja.ApplicationID) AS TotalApplications,
    COUNT(DISTINCT f.FollowUpID) AS TotalFollowUps,
    COUNT(DISTINCT i.InterviewID) AS InterviewsAttended
FROM Students s
LEFT JOIN JobApplications ja ON s.StudentID = ja.StudentID
LEFT JOIN FollowUps f ON ja.ApplicationID = f.ApplicationID
LEFT JOIN Interviews i ON ja.ApplicationID = i.ApplicationID
GROUP BY s.StudentID, s.FullName;

-- b. Create Stored Procedure: sp_GenerateStudentReport
CREATE PROCEDURE sp_GenerateStudentReport
AS
BEGIN
    SELECT * FROM vw_StudentEffortSummary;
END;
