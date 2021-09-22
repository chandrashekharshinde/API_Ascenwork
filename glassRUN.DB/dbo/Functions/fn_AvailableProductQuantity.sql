CREATE FUNCTION [dbo].[fn_AvailableProductQuantity] --66605001, 6410
(
 @ProductCode nvarchar(100),
 @StockLocationId nvarchar(max)

)
RETURNS nvarchar(100)

BEGIN
Declare @StockLocationId2 nvarchar(500)
SET @StockLocationId2 = '07' + SUBSTRING(@StockLocationId,Len(@StockLocationId)-1,2)

    RETURN (


SELECT
 (select top 1 Sum(ItemQuantity) from ItemStock where DeliveryLocationCode in (@StockLocationId, @StockLocationId2)and ItemCode = @ProductCode and LocationCode='F') as ProductAvailableQuantity

		)
END
