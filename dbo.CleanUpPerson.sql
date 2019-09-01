IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'CleanUpPerson')
BEGIN 
	DROP PROCEDURE dbo.CleanUpPerson;
END
GO

CREATE PROCEDURE dbo.CleanUpPerson
AS 
	SET NOCOUNT ON;

	/*DDL first*/
	DECLARE @PersonID int,
			@PersonName varchar(255),
			@CleansedName varchar(255),
			@FirstName varchar(255),
			@LastName varchar(255),
			@Sex varchar(10),
			@DateOfBirth datetime;
	
	/*DML second*/		
	DELETE dbo.PersonCleansed;

	INSERT dbo.PersonCleansed
		   (PersonID, PersonName, Sex, DateofBirth)
	SELECT PersonID, PersonName, Sex, DateofBirth
	  FROM dbo.Person;

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
	   SET FirstName = LTRIM(RTRIM(LEFT(CleansedName, CHARINDEX(' ', CleansedName)))),
		   LastName = LTRIM(RTRIM(REVERSE(LEFT(REVERSE(CleansedName), CHARINDEX(' ', LTRIM(RTRIM(REVERSE(CleansedName))))))));

	UPDATE dbo.PersonCleansed
	   SET Processed = 0;

RETURN;
