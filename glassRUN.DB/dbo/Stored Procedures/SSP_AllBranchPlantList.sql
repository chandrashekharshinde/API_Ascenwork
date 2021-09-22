CREATE PROCEDURE [dbo].[SSP_AllBranchPlantList]-- '<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>0</CompanyId></Json>'

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
SELECT CAST((SELECT distinct 'true' AS [@json:Array] , LocationId as  [DeliveryLocationId] ,LocationId as  Id,[LocationName] +ISNULL(' ('+[LocationCode]+')','') as [Name]
      ,LocationName as [DeliveryLocationName]
      ,LocationCode as [DeliveryLocationCode]
     
     
     
  FROM Location l  join [Route] r on r.OriginId=l.LocationId  WHERE l.IsActive = 1 and LocationType in (21)
	FOR XML path('DeliveryLocationList'),ELEMENTS,ROOT('DeliveryLocation')) AS XML)
END
