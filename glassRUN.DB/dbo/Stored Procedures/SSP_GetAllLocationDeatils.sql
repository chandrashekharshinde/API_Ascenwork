CREATE PROCEDURE [dbo].[SSP_GetAllLocationDeatils] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>592</CompanyId></Json>'

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
	[LocationId],
	[LocationId] as Id,	
	[LocationName],
	[LocationName] as [Name],
	[DisplayName],
	[LocationCode],
	[CompanyID],
	[LocationType],
	[LocationIdentifier],
	[Area],
	[AddressLine1],
	[AddressLine2],
	[AddressLine3],
	[AddressLine4]
  FROM [Location] WHERE IsActive = 1 and LocationType=27
	FOR XML path('LocationList'),ELEMENTS,ROOT('Json')) AS XML)
END
