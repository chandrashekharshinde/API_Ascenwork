CREATE FUNCTION [dbo].[fn_GetTotalAmount]
(@enquiryId bigint,@orderId bigint)
RETURNS decimal(18,2)  
BEGIN
declare @amount decimal(18,2)
declare @depositAmount decimal(18,2)
declare @amountWithoutTax decimal(18,2)

declare @AmountTax float=0
declare @taxPercentage float=0

SET @taxPercentage=(Select SettingValue from [dbo].SettingMaster where SettingParameter='ItemTaxInPec')

if(@orderId=0)
BEGIN

Set @amountWithoutTax=ISNULL((select SUM(ProductQuantity * unitprice)  from [dbo].EnquiryProduct where EnquiryId=@enquiryId),0)

SET @AmountTax=((@amountWithoutTax*@taxPercentage)/100)

Set @depositAmount=ISNULL((select SUM(ProductQuantity * DepositeAmount)  from [dbo].EnquiryProduct where EnquiryId=@enquiryId),0)

SET @amount=(@amountWithoutTax+@AmountTax+@depositAmount)

END
ELSE IF(@enquiryId=0)
BEGIN

Set @amountWithoutTax=ISNULL((select SUM(ProductQuantity * UnitPrice)  from [dbo].OrderProduct where OrderId=@orderId and ItemType not in (0,39)),0)

SET @AmountTax=((@amountWithoutTax*@taxPercentage)/100)

Set @depositAmount=ISNULL((select SUM(ProductQuantity * DepositeAmount)  from [dbo].OrderProduct where OrderId=@orderId and ItemType not in (0,39)),0)

SET @amount=(@amountWithoutTax+@AmountTax+@depositAmount)
END


return @amount

END
