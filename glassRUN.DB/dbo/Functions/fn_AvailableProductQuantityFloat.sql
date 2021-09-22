CREATE FUNCTION [dbo].[fn_AvailableProductQuantityFloat] --66605001, 6410
(
 @ProductCode nvarchar(100),
 @StockLocationId nvarchar(max)

)
RETURNS Float

BEGIN
Declare @StockLocationId2 nvarchar(500)
SET @StockLocationId2 = '07' + SUBSTRING(@StockLocationId,Len(@StockLocationId)-1,2)

    RETURN (


SELECT
 (select Sum(ItemQuantity) from ItemStock where DeliveryLocationCode in (@StockLocationId, @StockLocationId2)and ItemCode = @ProductCode and LocationCode in ('F','F2')) as ProductAvailableQuantity

		)
END
