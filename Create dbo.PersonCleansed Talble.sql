IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PersonCleansed')
BEGIN
	DROP TABLE dbo.PersonCleansed;
END
GO

CREATE TABLE dbo.PersonCleansed
(
	PersonID int NULL,
	PersonName varchar(255) NULL,
	Sex varchar(10) NULL,
	DateofBirth datetime NULL,
	CleansedName varchar(255),
	FirstName varchar(255) NULL,
	LastName varchar(255) NULL,
	Processed bit DEFAULT (0)
);