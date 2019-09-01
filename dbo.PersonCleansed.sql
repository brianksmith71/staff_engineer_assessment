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
	DateofBirth date NULL,
	CleansedName varchar(255),
	FirstName varchar(255) NULL,
	LastName varchar(255) NULL,
	Processed bit DEFAULT (0)
);


INSERT dbo.PersonCleansed
	   (PersonID, PersonName, Sex, DateofBirth)
SELECT PersonID, PersonName, Sex, DateofBirth
  FROM dbo.Person;

--SELECT PersonID, PersonName, Sex, DateofBirth, Processed
--  FROM dbo.PersonCleansed;



DECLARE @PersonID int,
		@PersonName varchar(255),
		@CleansedName varchar(255),
		@FirstName varchar(255),
		@LastName varchar(255);
		

WHILE EXISTS (SELECT 1 FROM dbo.PersonCleansed WHERE Processed = 0)
BEGIN
	SELECT @PersonID = PersonID,
		   @PersonName = PersonName
	  FROM dbo.PersonCleansed
	 WHERE Processed  = 0
	 ORDER BY PersonID ASC;

	EXECUTE @CleansedName = dbo.RemoveSpecialChars @String = @PersonName;

	UPDATE dbo.PersonCleansed
	   SET CleansedName = @CleansedName,
		   Processed = 1
	 WHERE PersonID = @PersonID;
END

UPDATE dbo.PersonCleansed
   SET FirstName = LEFT(CleansedName, CHARINDEX(' ', CleansedName)),
	   LastName = REVERSE(LEFT(REVERSE(CleansedName), CHARINDEX(' ', LTRIM(RTRIM(REVERSE(CleansedName))))));

--SELECT * FROM dbo.PersonCleansed;