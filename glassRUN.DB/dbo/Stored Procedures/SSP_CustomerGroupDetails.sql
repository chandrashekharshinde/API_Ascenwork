create PROCEDURE [dbo].[SSP_CustomerGroupDetails] --'<Json><ServicesAction>GetAllMasterDetailByPageid</ServicesAction><PageId>6</PageId><RoleId>4</RoleId><UserId>512</UserId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint
Declare @RoleId bigint
Declare @userId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId]

	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint
			
           
			)tmp ;

	
		
			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT top 1  'true' AS [@json:Array] ,COUNT(*) OVER () as TotalCount	  
       from [CustomerGroupForPricing] 
	FOR XML path('CustomerGroupList'),ELEMENTS,ROOT('Json')) AS XML)
END

