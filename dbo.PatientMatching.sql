IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'PatientMatching')
BEGIN
	DROP PROCEDURE dbo.PatientMatching;
END
GO


CREATE PROCEDURE dbo.PatientMatching
(
	@FirstName varchar(255),
	@LastName varchar(255),
	@DOB datetime,
	@Sex varchar(10)
)
AS	
	SET NOCOUNT ON;

	/*DDL first*/
	DECLARE @RiskLevel decimal(5, 2);

	/*DML second*/
	/*In case of volatility in dbo.Person*/
	EXECUTE dbo.CleanUpPerson;

	 ;WITH Risk	
	 AS 
	 (
		  SELECT pc.PersonID
				, pc.FirstName
				, pc.LastName
				, pc.DateofBirth
				, pc.Sex
				, RANK() OVER(PARTITION BY pc.PersonName ORDER BY r.RiskLevel DESC) AS RiskRank
		   FROM dbo.PersonCleansed pc
		   LEFT JOIN dbo.Risk r
			 ON pc.PersonID = r.PersonID
	), Matches
	AS
	(
		SELECT PersonID AS PatientID
			   , CASE
					 WHEN FirstName = @FirstName THEN 1
					 WHEN FirstName LIKE '%' + @FirstName + '%' THEN .5
				 END AS FirstNameMatch
			   , CASE
					 WHEN LastName = @LastName THEN .8
					 WHEN LastName LIKE '%' + @LastName + '%' THEN .4
				 END AS LastNameMatch
			   , CASE
					 WHEN DateofBirth = CAST(@DOB AS varchar(100)) THEN .75
					 WHEN DateofBirth LIKE '%' + CAST(@DOB AS varchar(100)) + '%' THEN .3
				 END AS DOBMatch
			   , CASE
					 WHEN Sex = @Sex THEN .6
					 WHEN Sex LIKE '%' + @Sex + '%' THEN .25
				 END AS SexMatch
		   FROM Risk 
		  WHERE RiskRank = 1
	)
	SELECT PatientID
		   , FirstNameMatch + LastNameMatch + DOBMatch + SexMatch AS MatchScore
	  FROM Matches
	 WHERE FirstNameMatch + LastNameMatch + DOBMatch + SexMatch IS NOT NULL;

RETURN;


