IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Demographics')
BEGIN
	DROP TABLE dbo.Demographics;
END
GO

CREATE TABLE dbo.Demographics
(
	Dummy nvarchar(MAX),
	PatientID nvarchar(MAX),
	FirstName nvarchar(MAX),	
	MiddleName nvarchar(MAX),	
	LastName nvarchar(MAX),	
	DOB nvarchar(MAX),	
	Sex	nvarchar(MAX),
	FavoriteColor nvarchar(MAX),
	AttributedQ1 nvarchar(MAX),	
	AttributedQ2 nvarchar(MAX),
	RiskQ1 nvarchar(MAX),	
	RiskQ2 nvarchar(MAX),
	RiskIncreasedFlag nvarchar(MAX)
)	

