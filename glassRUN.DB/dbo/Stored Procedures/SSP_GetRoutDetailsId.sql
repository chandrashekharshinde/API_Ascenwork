CREATE PROCEDURE [dbo].[SSP_GetRoutDetailsId] --'<Json><ServicesAction>RouteDetailsById</ServicesAction><CompanyId>1488</CompanyId><OriginId>23643</OriginId><DestinationId>0</DestinationId><TruckSizeId>180</TruckSizeId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @CompanyId bigint
Declare @RouteId bigint
Declare @OriginId bigint
Declare @DestinationId bigint
Declare @TruckSizeId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyId = tmp.[CompanyId],
@RouteId=tmp.[RouteId],
@OriginId = tmp.[OriginId],
@DestinationId = tmp.[DestinationId],
@TruckSizeId=tmp.TruckSizeId
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[RouteId] bigint,
			[CompanyId] bigint,
			[OriginId] bigint,
			[DestinationId] bigint,
			[TruckSizeId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array] ,[RouteId],
		(select cast ((SELECT distinct 'true' AS [@json:Array],
		r.[CarrierNumber] as Id
		from [Route] r  where r.CompanyId = rp.CompanyId and r.OriginId=rp.OriginId and r.DestinationId=rp.DestinationId and TruckSizeId=@TruckSizeId and r.isactive=1
		FOR XML path('TransporterList'),ELEMENTS) AS xml)),
			(select cast ((SELECT distinct 'true' AS [@json:Array],
		r.[CarrierNumber] as Id,r.RouteId 
		from [Route] r  where r.CompanyId = rp.CompanyId and r.OriginId=rp.OriginId and r.DestinationId=rp.DestinationId and TruckSizeId=@TruckSizeId and r.isactive=1
		FOR XML path('RoutList'),ELEMENTS) AS xml)),
		RP.[CompanyId],
		RP.[RouteNumber],
		RP.[OriginId],
		--(Select LocationName from Location where LocationId=RP.[OriginId])+  +ISNULL(' ('+(Select Pincode from Location where LocationId=RP.[OriginId])+')','') as CollectionName,
		(Select LocationName+ISNULL(' ('+Pincode+')','') from Location where LocationId=RP.[OriginId] and IsActive=1) as CollectionName,
		RP.[DestinationId],
		(Select LocationName+ISNULL(' ('+Pincode+')','') from Location where LocationId=RP.[DestinationId] and IsActive=1) as DeliverName,
		--(Select LocationName from Location where LocationId=RP.[DestinationId])+  +ISNULL(' ('+(Select Pincode from Location where LocationId=RP.[DestinationId])+')','') as DeliverName,
		RP.[TruckSizeId],
		RP.[CarrierNumber],
		RP.[IsActive],
		RP.[CreatedBy],
		RP.[CreatedDate]
		from [Route] RP
	  WHERE IsActive = 1 and RP.RouteId=@RouteId
	  --and RP.OriginId=@OriginId and DestinationId=@DestinationId and CompanyId=@CompanyId and TruckSizeId=@TruckSizeId
	FOR XML path('RouteList'),ELEMENTS,ROOT('Json')) AS XML)
END
