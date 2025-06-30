-- Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- ResumeVersions table
CREATE TABLE ResumeVersions (
    ResumeID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    VersionName NVARCHAR(50),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- JobApplications table
CREATE TABLE JobApplications (
    ApplicationID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    CompanyName NVARCHAR(100),
    JobTitle NVARCHAR(100),
    Location NVARCHAR(100),
    ApplicationDate DATE,
    ResumeID INT FOREIGN KEY REFERENCES ResumeVersions(ResumeID),
    Status NVARCHAR(50) CHECK (Status IN ('Applied', 'Interviewed', 'Rejected', 'Offered', 'Accepted')),
    JobLink NVARCHAR(300),
    Notes NVARCHAR(500)
);
GO

-- Interviews table
CREATE TABLE Interviews (
    InterviewID INT PRIMARY KEY IDENTITY(1,1),
    ApplicationID INT FOREIGN KEY REFERENCES JobApplications(ApplicationID),
    InterviewDate DATE,
    InterviewType NVARCHAR(50),
    Outcome NVARCHAR(50),
    Notes NVARCHAR(300)
);
GO

-- FollowUps table
CREATE TABLE FollowUps (
    FollowUpID INT PRIMARY KEY IDENTITY(1,1),
    ApplicationID INT FOREIGN KEY REFERENCES JobApplications(ApplicationID),
    FollowUpDate DATE,
    Method NVARCHAR(50),
    Notes NVARCHAR(300)
);
GO

-- EffortMetrics table
CREATE TABLE EffortMetrics (
    EffortID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    MonthYear CHAR(7), -- YYYY-MM
    TotalApplications INT,
    TotalFollowUps INT,
    InterviewsAttended INT
);
GO
