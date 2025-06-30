CREATE VIEW vw_ApplicationSummary AS
SELECT 
    s.FullName,
    ja.CompanyName,
    ja.JobTitle,
    ja.Status,
    ja.ApplicationDate,
    rv.VersionName
FROM JobApplications ja
JOIN Students s ON ja.StudentID = s.StudentID
JOIN ResumeVersions rv ON ja.ResumeID = rv.ResumeID;
GO

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
GO
