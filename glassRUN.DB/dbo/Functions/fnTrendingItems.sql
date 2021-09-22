CREATE FUNCTION [dbo].[fnTrendingItems]
(
	@ItemCode nvarchar(max)
)
RETURNS 
@SplitValues TABLE 
(
	ItemCode nvarchar(max),
	ProductQuantity bigint
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set


	INSERT INTO @SplitValues(ItemCode,ProductQuantity)
	Select top 2  ep.ProductCode, round((sum(ep.ProductQuantity)/3),0) as ProductQuantity  from EnquiryProduct ep join Enquiry e on ep.EnquiryId=e.EnquiryId
	where  ep.IsActive=1 and isnull(ep.IsPackingItem,0)=0 and e.CreatedDate>=DATEADD(DAY,-3,GETDATE())
	group by ep.ProductCode Order by sum(ep.ProductQuantity) desc

RETURN
END
