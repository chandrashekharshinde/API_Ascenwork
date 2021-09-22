CREATE PROCEDURE [dbo].[SSP_GetAllCarrierByCompanyId] --'<Json><ServicesAction>LoadAllCarrierByBranchPlant</ServicesAction><branchPlantId>13</branchPlantId><ShipTo>256</ShipTo><TruckSizeId>36</TruckSizeId></Json>'
(
@xmlDoc XML
)
AS

DECLARE @intPointer INT;
Declare @branchPlantId bigint
Declare @shipTo bigint
Declare @truckSizeId bigint


BEGIN

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	   
	   @branchPlantId = tmp.[branchPlantId],
	   @shipTo = tmp.[ShipTo],
	   @truckSizeId = tmp.[TruckSizeId]
	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[branchPlantId] bigint,
			[ShipTo] bigint,
			[TruckSizeId] bigint
			
           
			)tmp;

 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  Select CAST((Select 'true' AS [@json:Array]  ,[CompanyId]
      ,[CompanyName]
      ,[CompanyMnemonic]
      ,[CompanyType]
      ,[ParentCompany]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId] 
	  From Company  where CompanyId in (select CarrierNumber from Route where DestinationId=@shipTo 
	  and OriginId=@branchPlantId and TruckSizeId=@truckSizeId) and CompanyType=28
	  
    FOR XML path('CarrierList'),ELEMENTS,ROOT('Json')) AS XML)

END
