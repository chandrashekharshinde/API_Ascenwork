CREATE PROCEDURE [dbo].[SSP_GetAllCompanyAsTransporter]

AS
BEGIN
	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
		SELECT CAST((
			SELECT DISTINCT
				'true' AS [@json:Array] ,
				[CompanyId],
				[CompanyName]+ ' ('+CompanyMnemonic+')' as CompanyName
			FROM [dbo].[Company]
			WHERE IsActive=1
			And CompanyType=28
			order by [CompanyName] asc
		FOR XML path('CompanyList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
