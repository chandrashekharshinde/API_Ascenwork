
CREATE FUNCTION [dbo].[fn_CheckCreditLimitAvailability]
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


declare @ItemTaxInPec nvarchar(max)
set @ItemTaxInPec = (select top 1 SettingValue from SettingMaster where SettingParameter = 'ItemTaxInPec')


RETURN (
select (
select case when TotalUnitPrice > (AvailableCreditLimit-TotalPendingEnquiryAmount) then 0 else 1 end as pending from 
(select ((TotalPendingEnquiryAmount) + (TotalPendingEnquiryAmount*@ItemTaxInPec/100)) as TotalPendingEnquiryAmount  ,AvailableCreditLimit,((TotalUnitPrice) + (TotalUnitPrice*@ItemTaxInPec/100)) as TotalUnitPrice  
from (select (SELECT ISNULL([dbo].[fn_PendingEnquiryTotalAmount] (e.SoldTo,e.CreatedDate),0)) as TotalPendingEnquiryAmount,
ISNULL((select AvailableCreditLimit from Company where CompanyId = e.SoldTo and IsActive = 1),0) as AvailableCreditLimit,
Sum(isnull(ep.ProductQuantity,0)*isnull(ep.UnitPrice,0)) as TotalUnitPrice
  from Enquiry e  with (nolock) left join EnquiryProduct ep  with (nolock) on e.EnquiryId = ep.EnquiryId 
   where e.IsActive=1 and ep.IsActive=1 and ProductCode !=@woodenpalletcode and   e.EnquiryId=@EnquiryId
  group by e.EnquiryId,e.SoldTo,e.CreatedDate
 ) as stock ) as t
  ) as FinalCreditLimit  )


END