Create PROCEDURE [dbo].[SSP_GetLookupByLookupId] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @lookupId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @lookupId = tmp.[LookupId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[LookupId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,[LookUpId]
      ,[LookupCategory]
      ,[Name]
      ,[Code]
	  ,IsActive
				   FROM LookUp  
	  WHERE LookUpId=@lookupId
	FOR XML path('LookupList'),ELEMENTS,ROOT('Json')) AS XML)
END
