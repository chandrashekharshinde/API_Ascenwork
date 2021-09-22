CREATE View [dbo].[OrderProductView]  as
SELECT  op.OrderProductId,op.OrderId
  ,op.ProductCode
  ,op.ProductType
  ,op.ItemType
   ,i.ItemName
  --,ISNULL(op.ProductQuantity,0) as ProductQuantity ,
  --ISNULL(op.UnitPrice,0) as ItemPricesPerUnit
	  --, ISNULL((op.UnitPrice * op.ProductQuantity),0) as ItemPrices	 
	  ,CONVERT(DECIMAL(18,0), ISNULL(op.ProductQuantity,0)) as ProductQuantity ,
  CONVERT(DECIMAL(18,0), ISNULL(op.UnitPrice,0)) as ItemPricesPerUnit
	  , CONVERT(DECIMAL(18,0), ISNULL((op.UnitPrice * op.ProductQuantity),0)) as ItemPrices,
	  	   CONVERT(DECIMAL(18,0),ISNULL(op.DepositeAmount,0)) as DepositeAmountPerUnit,
		   			  CONVERT(DECIMAL(18,0),ISNULL((op.DepositeAmount * op.ProductQuantity),0)) as ItemTotalDepositeAmount,
	  --ISNULL(op.DepositeAmount,0) as DepositeAmountPerUnit,
--ISNULL((op.DepositeAmount * op.ProductQuantity),0) as ItemTotalDepositeAmount,

  (SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as UOM,
  (select top 1 SettingValue from SettingMaster where SettingParameter = 'ItemTaxInPec') as ItemTax,
   ISNULL(op.AssociatedOrder,0) as AssociatedOrder,
  -- (SELECT ISNULL([dbo].[fn_UsedOrderQuantityForOrder] (op.ProductCode,o.StockLocationId,o.CreatedDate),0)) as UsedQuantityInOrder,
	 --(SELECT ISNULL([dbo].[fn_AvailableProductQuantity] (op.ProductCode,o.StockLocationId),0)) as ProductAvailableQuantity 
	  0 as UsedQuantityInOrder,
	 0 as ProductAvailableQuantity 
 , op.Remarks  
   FROM dbo.OrderProduct op left 
   join Item i  on op.ProductCode = i.ItemCode
   join [order] o on  o.OrderId=op.OrderId
  WHERE op.IsActive=1 AND op.isactive=1 and i.IsActive = 1
