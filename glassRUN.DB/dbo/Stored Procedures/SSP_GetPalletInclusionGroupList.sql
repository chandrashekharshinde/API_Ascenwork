﻿
CREATE PROCEDURE [dbo].[SSP_GetPalletInclusionGroupList]-- '<Json><ServicesAction>LoadAllDriverList</ServicesAction></Json>'
t.TruckSizeId,t.TruckSize,t.TruckCapacityPalettes,t.TruckCapacityWeight
--,r.CarrierNumber
--,c.CompanyMnemonic,c.CompanyName
from [Route] r join TruckSize t on t.TruckSizeId=r.TruckSizeId 
--left join Company c on c.CompanyId=r.CarrierNumber
where r.DestinationId=@DestinationId