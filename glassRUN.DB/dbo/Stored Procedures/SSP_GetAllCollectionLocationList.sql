﻿
INNER JOIN Location l on r.OriginId = l.LocationId and l.LocationType = 21 and l.IsActive = 1
INNER JOIN Company c on r.CarrierNumber = c.CompanyId and c.CompanyType = 28
where r.DestinationId = @companyId and r.TruckSizeId = @TruckSizeId