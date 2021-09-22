CREATE PROCEDURE [dbo].[SSP_AllShipToList]-- '<Json><ServicesAction>LoadAllDriverList</ServicesAction></Json>'(@xmlDoc XML='<Json><CarrierId>0</CarrierId></Json>')ASBEGINDECLARE @intPointer INT;declare @CarrierId bigint=0EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDocSELECT @CarrierId = tmp.[CarrierId]		  FROM OPENXML(@intpointer,'Json',2)			WITH			(			[CarrierId] bigint			)tmp; WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)SELECT CAST((SELECT  Distinct 'true' AS [@json:Array],dl.CompanyID,c.CompanyName,
  c.CompanyMnemonic,dl.LocationId
   ,LocationName+' ('+LocationCode+')' as LocationName,ISNULL(DisplayName,LocationName) as DisplayName,LocationCode,Area,
   dl.IsActive from [Location] dl join Company c on dl.CompanyID = c.CompanyId
where dl.IsActive=1 and dl.LocationId in (Select distinct r.DestinationId from [Route] r where r.IsActive=1 )
Order by LocationNameFOR XML path('ShipToList'),ELEMENTS,ROOT('Json')) AS XML)END