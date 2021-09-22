Create PROCEDURE [dbo].[SSP_GetAllCitybyStateName] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>592</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @stateName nvarchar(Max);


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @stateName = tmp.[StateName]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[StateName]  nvarchar(Max)
           
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
  FROM [City] WHERE IsActive = 1 and StateId=(select top 1 StateId from [State] where stateName=@stateName )order by CityName Asc 
	FOR XML path('CityList'),ELEMENTS,ROOT('Json')) AS XML)
END