﻿
INNER JOIN Company c on r.CarrierNumber = c.CompanyId and c.CompanyType = 28
where r.DestinationId = @companyId and r.TruckSizeId = @TruckSizeId and r.OriginId = @LocationId and r.IsActive = 1