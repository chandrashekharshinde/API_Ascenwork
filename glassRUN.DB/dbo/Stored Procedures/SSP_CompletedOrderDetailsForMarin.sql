
CREATE PROCEDURE [dbo].[SSP_CompletedOrderDetailsForMarin]--86034,0
@OrderId BIGINT,
@customs INT
AS
BEGIN

--SELECT CAST((
SELECT o.OrderId ,
       0 as SupplierLOBId ,
	   '' as InvoiceNumber,
       o.SoldTo as  CustomerId ,
      8000 as OrderType ,
	   'Pack' AS OrderTypeValue,
       o.OrderNumber ,
       o.PurchaseOrderNumber ,
       o.SalesOrderNumber ,
        0 as PartOfSalesOrder ,
       o.OrderDate as   RequestedDateOfDelivery ,
      ( select top 1 ActualTimeOfAction From OrderMovement om  where om.OrderId=o.orderid and LocationType=2 )AS ActualDateOfDelivery,
       o.PreviousState ,
       o.CurrentState ,
       o.NextState ,
      '' asEmailSentTimeForFulfilment ,
       o.IsActive ,
       o.CreatedBy ,
       o.CreatedDate ,
        convert(bit,0) as IsPartialDelivered,
	   '' as DrnRemark,
	   c.CompanyName AS CustomerName,
	    '' as VesselName,
	   '' as IMONumber,
	   '' asVesselEmail,
	   null as VesselETA,
	   null as VesselETD,
	   null as PortName,
	 null  AS Country,
	   null as BerthName,
	 dl.LocationName AS LocationName,
	   4 as LOBId,
	   null as SupplierId,
	   (select dbo.fn_LookupValueById(4)) AS LobVlaue
	  ,(SELECT sm.SettingValue FROM dbo.SettingMaster sm WHERE sm.SettingParameter='PodPath' AND sm.ProductType=8000) AS RdlcPath
	  ,c.CompanyMnemonic as  CustomerCode
	  , 7001  as  ModeOfDelivery
	  , (SELECT
CASE
  WHEN @customs=1  THEN ''
  WHEN (SELECT COUNT(*) FROM  dbo.PdcInformation WHERE OrderId=o.OrderId ) >= 1  THEN 'X'
  ELSE ''
END) AS Predeliverychecklist
,

(SELECT
CASE
  WHEN @customs=1  THEN ''
  WHEN (0 ) != '0'  THEN 'X'
  ELSE ''
END) AS SameCountry
,
(SELECT
CASE
  WHEN @customs=1  THEN ''
  WHEN (0 ) != '0'  THEN ''
  ELSE 'X'
END) AS DifferentCountry
		FROM [Order] o 
		CROSS APPLY(SELECT OrderId,(SELECT [dbo].[fn_LookupValueById](om.LocationType)) AS Name,
		LocationType,Location,
		(SELECT LocationName FROM dbo.Location WHERE LocationId=om.Location) AS LocationName 
		  FROM dbo.OrderMovement om 
		   WHERE  --(SELECT [dbo].[fn_LookupValueById](om.LocationType))='CollectionStop'-- AND 
		   om.LocationType= CASE WHEN ((1)=0) THEN 2 ELSE 1 END
		   and om.OrderId=o.OrderId AND om.IsActive=1) as location
		LEFT JOIN Location dl ON o.StockLocationId = dl.LocationCode
	
		JOIN Company c ON c.CompanyId=o.SoldTo
		
	WHERE 

	o.IsActive=1 --AND 

	--o.CurrentState = CASE WHEN @customs=0 THEN 24 ELSE 22 END

	AND o.OrderId=@OrderId


END