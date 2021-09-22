CREATE PROCEDURE [dbo].[SSP_GetAllCitybyStateId] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>592</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @stateId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @stateId = tmp.[StateId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[StateId] bigint
           
			)tmp ;
			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] , 
    CityId,
    StateId,
	CityName,
	CityCode,
	IsActive,
	CreatedBy,
	CreatedDate,
	UpdatedBy,
	UpdatedDate
  FROM [City] WHERE IsActive = 1 and StateId=@stateId order by CityName Asc 
	FOR XML path('CityList'),ELEMENTS,ROOT('Json')) AS XML)
END