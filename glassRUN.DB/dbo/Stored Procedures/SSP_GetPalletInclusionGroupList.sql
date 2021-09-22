
CREATE PROCEDURE [dbo].[SSP_GetPalletInclusionGroupList]-- '<Json><ServicesAction>LoadAllDriverList</ServicesAction></Json>'(@xmlDoc XML='<Json><DestinationId>0</DestinationId></Json>')ASBEGINDECLARE @intPointer INT;declare @DestinationId bigint=0EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocSELECT @DestinationId = tmp.[DestinationId]FROM OPENXML(@intpointer,'Json',2)WITH([DestinationId] bigint)tmp; WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)SELECT CAST((SELECT Distinct 'true' AS [@json:Array],r.DestinationId,Isnull(r.PalletInclusionGroup,'0') as PalletInclusionGroup,
t.TruckSizeId,t.TruckSize,t.TruckCapacityPalettes,t.TruckCapacityWeight
--,r.CarrierNumber
--,c.CompanyMnemonic,c.CompanyName
from [Route] r join TruckSize t on t.TruckSizeId=r.TruckSizeId 
--left join Company c on c.CompanyId=r.CarrierNumber
where r.DestinationId=@DestinationIdFOR XML path('TruckSizeList'),ELEMENTS,ROOT('Json')) AS XML)END