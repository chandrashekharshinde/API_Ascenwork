﻿CREATE PROCEDURE [dbo].[SSP_GetAllCollectionLocationList] @xmlDoc XMLASBEGINDECLARE @intPointer INT;Declare @companyId bigint;Declare @TruckSizeId bigint;EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocSELECT @companyId = tmp.[CompanyId],       @TruckSizeId = tmp.[TruckSizeId]FROM OPENXML(@intpointer,'Json',2)			WITH			(			[CompanyId] bigint,			[TruckSizeId] bigint			)tmp ;			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) SELECT CAST((SELECT 'true' AS [@json:Array] , l.LocationCode As LocationCode, l.LocationCode + '-' +l.LocationName as LocationName, c.CompanyId As CarrierId, c.CompanyMnemonic As CarrierCode, c.CompanyName As CarrierName from Route r
INNER JOIN Location l on r.OriginId = l.LocationId and l.LocationType = 21 and l.IsActive = 1
INNER JOIN Company c on r.CarrierNumber = c.CompanyId and c.CompanyType = 28
where r.DestinationId = @companyId and r.TruckSizeId = @TruckSizeId	FOR XML path('BranchPlantList'),ELEMENTS,ROOT('Json')) AS XML)END