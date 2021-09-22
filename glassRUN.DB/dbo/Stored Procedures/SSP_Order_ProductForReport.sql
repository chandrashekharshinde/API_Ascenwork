
create PROCEDURE [dbo].[SSP_Order_ProductForReport] --86224

 @orderid INT
AS
BEGIN

SELECT  OrderProductId ,
        OrderId ,
        ProductType ,
        Name,
        UnitOfMeasure ,
        UnitSize ,
		OrderMovementId,
	  ActualQuantity AS  NumberOfUnits,
		--NumberOfUnits,
	  ActualQuantity AS Quantity,
        PackTypeId ,
        IsActive ,
        CreatedBy ,
        CreatedDate ,
       
        ProductTypeValue ,
        OrderTypeValue,
		'' AS DisplayQuantityType
		,ItemCode
		,PurchaseOrderNumber
		,'' as CustomerCrossReferenceCode
		,TankLocation
		,PreDipVol
		,PostDipVol
		,TotalVolume 
        ,TotalVolumeMeasure 
        ,TotalWeight 
        ,TotalWeightMeasure 
		,RouteCode
		,Pumped
		,GradeSequence
			  ,0 as Prices
		 FROM (
        SELECT
		om.OrderMovementId,
		 op.OrderProductId,
        op.OrderId,
        op.ProductType,
       i.ItemName  as Name,
       '' as UnitOfMeasure,
        '' as UnitSize,
         op.ProductQuantity as NumberOfUnits,
         op.ProductQuantity as Quantity,
         0 as PackTypeId ,
        op.IsActive ,
        op.CreatedBy ,
        op.CreatedDate ,
        '' as SupplierId,

	  GETDATE() as 	 ActualDateOfDelivery,
		(SELECT [dbo].[fn_LookupValueById](8000)) AS ProductTypeValue,
		(SELECT [dbo].[fn_LookupValueById](o.ModeOfDelivery)) AS OrderTypeValue ,
		ISNULL(opm.ActualQuantity,0) AS ActualQuantity
		--,(SELECT TOP 1 dbo.Item.ItemCode FROM dbo.Item WHERE dbo.Item.ItemName COLLATE Latin1_General_CI_AS=op.Name) AS ItemCode
		,op.ProductCode AS ItemCode
		,o.PurchaseOrderNumber
		,'' as CustomerCrossReferenceCode
		,''AS TankLocation
		,'' AS PreDipVol
		,'' AS PostDipVol
		,ISNULL(0,0) AS TotalVolume
        ,0 as TotalVolumeMeasure 
        ,ISNULL(0,0) AS TotalWeight  
        ,0 as TotalWeightMeasure 
		, '' as RouteCode
		,CASE WHEN ISNULL(opm.IsPumped,0)=0 THEN 'N' ELSE 'Y' END AS Pumped
		,ISNULL(0,0) AS GradeSequence
		, 0 as IsFocScheme
		FROM dbo.OrderProduct op 
		JOIN dbo.[Order] o ON op.OrderId = o.OrderId
		left join Item i on op.ProductCode=i.ItemCode
		
		LEFT JOIN dbo.OrderMovement om ON   om.OrderId=o.OrderId 
		AND om.LocationType=
		(CASE WHEN 
		(SELECT COUNT(ckom.OrderMovementId) FROM OrderMovement ckom WHERE ckom.IsActive=1 AND ckom.OrderId=@orderid AND ckom.LocationType=1)>0 
		THEN 1 ELSE 2 end)
		LEFT JOIN dbo.OrderProductMovement opm ON  om.OrderMovementId = opm.OrderMovementId AND op.OrderProductId=opm.OrderProductId AND o.OrderId=opm.OrderId 
		
		WHERE op.OrderId=@orderid AND op.IsActive=1  and  o.IsActive=1 AND om.IsActive=1 AND opm.IsActive=1 And op.ProductCode !='65000000') AS OrderProduct ORDER BY GradeSequence ASC

END