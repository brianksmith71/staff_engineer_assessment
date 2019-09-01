DELETE dbo.Dates;

INSERT dbo.Dates 
	    (DateValue
        ,DateDayofMonth
        ,DateDayofYear
        ,DateQuarter
        ,DateWeekdayName
        ,DateMonthName
        ,DateYearMonth)
SELECT DISTINCT ContractStartDate AS DataValue
	            , DAY(ContractStartDate) AS DateDayOfMonth
	            , DATEPART(dy, ContractStartDate) AS DateDayOfYear
	            , DATEPART(qq, ContractStartDate) AS DateQuarter
	            , DATENAME(dw, ContractStartDate) AS DateWeekdayName
	            , DATENAME(mm, ContractStartDate) AS DateMonthName
	            , CONVERT(varchar(6), ContractStartDate, 112) AS DateYearMonth
  FROM dbo.Contracts
 WHERE ContractStartDate >= CAST('1/1/2010' AS datetime)
   AND ContractEndDate <= DATEADD(dd, 500, GETDATE())
		
UNION
	
SELECT ContractEndDate AS DataValue
	    , DAY(ContractEndDate) AS DateDayOfMonth
	    , DATEPART(dy, ContractEndDate) AS DateDayOfYear
	    , DATEPART(qq, ContractEndDate) AS DateQuarter
	    , DATENAME(dw, ContractEndDate) AS DateWeekdayName
	    , DATENAME(mm, ContractEndDate) AS DateMonthName
	    , CONVERT(varchar(6), ContractEndDate, 112) AS DateYearMonth
  FROM dbo.Contracts
 WHERE ContractEndDate >= CAST('1/1/2010' AS datetime)
   AND ContractEndDate <= DATEADD(dd, 500, GETDATE());

--SELECT * FROM dbo.Dates;		