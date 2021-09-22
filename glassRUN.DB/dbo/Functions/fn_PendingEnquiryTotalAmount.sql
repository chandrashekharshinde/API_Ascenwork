CREATE FUNCTION [dbo].[fn_PendingEnquiryTotalAmount]
(
	@SoldTo nvarchar(max),
	@CreatedDate datetime
)



RETURNS Float
BEGIN


    RETURN (
		SELECT (select Sum(isnull(ep.ProductQuantity,0)*isnull(ep.UnitPrice,0)) as ProductQuantity
from Enquiry e 
left join EnquiryProduct ep
on e.EnquiryId = ep.EnquiryId 
where ep.ItemType != 0 and ep.ProductType != 40 and ep.ProductType != 30 and ep.ProductType != 31 and  e.SoldTo = @SoldTo and e.CreatedDate < @CreatedDate and e.CurrentState = 1 and e.IsActive = 1 and ep.IsActive = 1
group by SoldTo) as TotalAmountOfEnquiry
		)
END