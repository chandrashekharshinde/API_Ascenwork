﻿CREATE PROCEDURE [dbo].[SSP_AllShipToList]-- '<Json><ServicesAction>LoadAllDriverList</ServicesAction></Json>'
  c.CompanyMnemonic,dl.LocationId
   ,LocationName+' ('+LocationCode+')' as LocationName,ISNULL(DisplayName,LocationName) as DisplayName,LocationCode,Area,
   dl.IsActive from [Location] dl join Company c on dl.CompanyID = c.CompanyId
where dl.IsActive=1 and dl.LocationId in (Select distinct r.DestinationId from [Route] r where r.IsActive=1 )
Order by LocationName