Create PROCEDURE [dbo].[SSP_ServiceActionConfiguration] --'<Json><ServicesAction>GetTruckDetailByLocationIdAndCompanyId</ServicesAction><LocationId>767</LocationId><CompanyId>191</CompanyId></Json>'
(
@xmlDoc XML
)
AS

DECLARE @intPointer INT;
Declare @CompanyId INT
BEGIN



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc




SELECT 

	   @CompanyId = tmp.[CompanyId]
	  
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			
			[CompanyId] int
			
           
			)tmp ;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT distinct 'true' AS [@json:Array] , 

ServicesAction,
ServicesAction as [Name]

  FROM ServiceConfiguration  
	FOR XML path('ServicesActionList'),ELEMENTS,ROOT('Json')) AS XML)

END