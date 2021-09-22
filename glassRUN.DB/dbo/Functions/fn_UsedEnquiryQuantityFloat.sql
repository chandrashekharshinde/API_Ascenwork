CREATE FUNCTION [dbo].[fn_UsedEnquiryQuantityFloat]
(
	@ProductCode nvarchar(100),
	@StockLocationId nvarchar(max),
	@CreatedDate datetime

)
RETURNS Float
BEGIN
    RETURN (

SELECT
 (select Sum(ep1.ProductQuantity) as ProductQuantity
from Enquiry e 
left join EnquiryProduct ep1 
on e.EnquiryId = ep1.EnquiryId and ep1.ProductCode = @ProductCode
where ep1.ProductCode = @ProductCode and ep1.stocklocationCOde = @StockLocationId and e.CreatedDate < @CreatedDate and e.CurrentState = 1
group by ProductCode) as UsedQuantityInEnquiry

		)
END
