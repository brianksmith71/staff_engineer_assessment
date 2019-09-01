IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'RemoveSpecialChars')
BEGIN 
	DROP FUNCTION dbo.RemoveSpecialChars;
END
GO

CREATE FUNCTION dbo.RemoveSpecialChars
(
	@String varchar(255)
)
RETURNS varchar(255)
AS
BEGIN
	DECLARE @IncorrectCharLoc smallint;

	SET @IncorrectCharLoc = PATINDEX('%[^0-9A-Za-z ]%', @string);

	WHILE (@IncorrectCharLoc > 0)
	BEGIN
		SET @string = STUFF(@string, @IncorrectCharLoc, 1, '');

		SET @IncorrectCharLoc = PATINDEX('%[^0-9A-Za-z ]%', @string);
	END

	SET @string = @string;

RETURN @string;
END
GO
