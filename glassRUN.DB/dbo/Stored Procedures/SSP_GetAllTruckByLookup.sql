Create PROCEDURE [dbo].[SSP_GetAllTruckByLookup] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] , Name,LookUpId from LookUp where LookupCategory in (select LookUpCategoryId from LookUpCategory where Name='VehicleType')
	FOR XML path('TruckList'),ELEMENTS,ROOT('Json')) AS XML)
END
