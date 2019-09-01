IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'ReturnPersonAttribution')
BEGIN
	DROP PROCEDURE dbo.ReturnPersonAttribution;
END
GO

CREATE PROCEDURE dbo.ReturnPersonAttribution
AS
	SET NOCOUNT ON;

	/*This is not as performant as I would like it but I believe it returns the right rows*/
	/*I try avoiding derived tables*/

	SELECT c.PersonID
	       , c.ContractStartDate AS AttributionStartDate
           , MIN(c1.ContractEndDate) AS AttributionEndDate
	  FROM dbo.Contracts c 
	 INNER JOIN dbo.Contracts c1 
		ON c.PersonID = c1.PersonID 
	   AND c.ContractStartDate <= c1.ContractEndDate
       AND NOT EXISTS (SELECT 1 
	                     FROM dbo.Contracts c2 
                        WHERE c1.PersonID = c2.PersonID 
					      AND c1.ContractEndDate >= c2.ContractStartDate 
					 	  AND c1.ContractEndDate < c2.ContractEndDate) 
	 WHERE NOT EXISTS (SELECT 1 
	                    FROM [dbo].Contracts c3 
                       WHERE c.PersonID = c3.PersonID 
					     AND c.ContractStartDate > c3.ContractStartDate 
						 AND c.ContractStartDate <= c3.ContractEndDate) 
	 GROUP BY c.PersonID, c.ContractStartDate 
	 ORDER BY c.PersonID, c.ContractStartDate;

RETURN;
