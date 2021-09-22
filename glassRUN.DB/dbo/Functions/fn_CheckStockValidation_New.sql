CREATE FUNCTION [dbo].[fn_CheckStockValidation_New]
(@EnquiryId bigint)
RETURNS nvarchar(max)

BEGIN
DECLARE @ProductCode nvarchar(max)=''
Declare @NumberOfItem int=0

Declare @StockLocationId nvarchar(max)
Declare @CreatedDate datetime

declare @totalUsedQuantity float
declare @availableProductStock float
declare @remainingProductStock float
declare @orderQty bigint
declare @woodenpalletcode nvarchar(max)

set @woodenpalletcode = (select top 1 SettingValue from SettingMaster where SettingParameter = 'WoodenPalletCode')



select @CreatedDate=CreatedDate from Enquiry where IsActive=1 and EnquiryId=@EnquiryId


DECLARE @cnt INT = 0;

select @cnt=COUNT(*) from (
select case when ProductQuantity > (availableProductStock-totalUsedQuantity) then 0 else 1 end as pending from (
select (SELECT ISNULL([dbo].[fn_UsedEnquiryQuantityFloat] (ProductCode,(Select StockLocationId from Enquiry where EnquiryId=@EnquiryId),@CreatedDate),0)) as totalUsedQuantity,
(SELECT ISNULL([dbo].[fn_AvailableProductQuantityFloat] (ProductCode,(Select StockLocationId from Enquiry where EnquiryId=@EnquiryId)),0)) as availableProductStock,isnull(ProductQuantity,0) as ProductQuantity
  from EnquiryProduct with (nolock) where IsActive=1 
  and ISNULL(IsPackingItem,0) =0
  and ItemType !=30
  and   EnquiryId=@EnquiryId) as stock 
  ) as finalstock  where pending=0


If @cnt != 0
begin
set @ProductCode=0
end
else
begin
set @ProductCode=1
end


 return @ProductCode
END
