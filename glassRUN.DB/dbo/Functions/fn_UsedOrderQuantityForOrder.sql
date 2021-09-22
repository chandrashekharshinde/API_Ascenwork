CREATE FUNCTION [dbo].[fn_UsedOrderQuantityForOrder]
(
	@ProductCode nvarchar(100),
	@StockLocationId nvarchar(max),
	@CreatedDate datetime

)
RETURNS nvarchar(100)
BEGIN
    RETURN (

SELECT
 
(select Sum(op.ProductQuantity)
from [Order] o  with (nolock)  left join OrderProduct op  with (nolock) 
on o.OrderId = op.OrderId and op.ProductCode = @ProductCode
where op.ProductCode = @ProductCode and op.StockLocationCode = @StockLocationId and o.CreatedDate < @CreatedDate and o.CurrentState = 3
group by ProductCode) as UsedQuantityInOrder

		)
END
