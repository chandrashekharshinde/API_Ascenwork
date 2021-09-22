Create PROCEDURE [dbo].[SSP_GetPlateNumberDriverMappingByplateNumberDriverMappingId] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @plateNumberDriverMappingId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @plateNumberDriverMappingId = tmp.[PlateNumberDriverMappingId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[PlateNumberDriverMappingId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,PlateNumberDriverMappingId
      ,PlateNumber
      ,DriverId
	  ,[Active]
				   FROM PlateNumberDriverMapping  
	  WHERE Active = 1 and PlateNumberDriverMappingId=@plateNumberDriverMappingId
	FOR XML path('PlateNumberDriverMappingList'),ELEMENTS,ROOT('Json')) AS XML)
END
