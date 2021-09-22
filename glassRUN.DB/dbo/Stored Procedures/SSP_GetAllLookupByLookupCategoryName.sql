CREATE PROCEDURE [dbo].[SSP_GetAllLookupByLookupCategoryName] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @LookupCategory bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @LookupCategory = tmp.[LookupCategory]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[LookupCategory] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] , Name,LookUpId from LookUp where LookupCategory in (select LookUpCategoryId from LookUpCategory where Name= @LookupCategory)
	FOR XML path('LookUpList'),ELEMENTS,ROOT('Json')) AS XML)
END
