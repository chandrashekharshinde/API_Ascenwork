CREATE FUNCTION [dbo].[fn_CheckStockValidation]
(@EnquiryId bigint)
RETURNS nvarchar(max)

BEGIN
DECLARE @ProductCode nvarchar(max)=''
Declare @NumberOfItem int=0

Declare @StockLocationId nvarchar(max)
Declare @CreatedDate datetime

declare @totalUsedQuantity nvarchar(max)
declare @availableProductStock nvarchar(max)
declare @remainingProductStock float
declare @orderQty bigint
declare @woodenpalletcode nvarchar(max)

set @woodenpalletcode = (select SettingValue from SettingMaster where SettingParameter = 'WoodenPalletCode')

select @NumberOfItem=count(EnquiryProductId) from EnquiryProduct where IsActive=1 and ProductCode != @woodenpalletcode and EnquiryId=@EnquiryId

select @CreatedDate=CreatedDate from Enquiry where IsActive=1 and EnquiryId=@EnquiryId


DECLARE @cnt INT = 1;

WHILE @cnt <= @NumberOfItem
BEGIN

select top 1 @ProductCode=ProductCode,@orderQty=ProductQuantity from (select rank() OVER (ORDER BY EnquiryProductId) as [rank],* from EnquiryProduct where IsActive=1 and ProductCode != @woodenpalletcode and  EnquiryId=@EnquiryId ) as d where [rank]=@cnt order by [rank]


set @totalUsedQuantity =(SELECT ISNULL([dbo].[fn_UsedEnquiryQuantity] (@ProductCode,@StockLocationId,@CreatedDate),0)) 

set @availableProductStock=(SELECT ISNULL([dbo].[fn_AvailableProductQuantity] (@ProductCode,@StockLocationId),0)) 

set @remainingProductStock=( CONVERT(float,@availableProductStock)-CONVERT(float,@totalUsedQuantity))

  if @orderQty > @remainingProductStock 
  begin

set @ProductCode=0
    break
  end
  else
  begin

set @ProductCode=1
  end

SET @cnt = @cnt + 1;
END;


 return @ProductCode
END
