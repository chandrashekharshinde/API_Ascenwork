CREATE FUNCTION [dbo].[fn_GetPriceOfItemFromJDE] 
(@itemId bigint,@customerId bigint)
RETURNS decimal(18,2)
BEGIN
declare @price decimal(18,2)=0
declare @PriceListId bigint=0

if exists (select PriceListId from PriceListCustomerMapping where CustomerId=@customerId)
begin
select @PriceListId=PriceListId from PriceListCustomerMapping where CustomerId=@customerId

select @price=pld.Amount from 
PriceListDetails pld 
join PriceList pl on pld.PriceListId=pl.PriceListId
join PriceListCustomerMapping PLCM on PLCM.PriceListId=pld.PriceListId
where 
PLCM.CustomerId=@customerId and pld.ItemId=@itemId and pld.IsActive=1 and pl.IsActive=1

end
else
begin
select @price=pld.Amount from 
PriceListDetails pld 
join PriceList pl on pld.PriceListId=pl.PriceListId
where 
pl.IsDefaultPriceType=1 and pld.ItemId=@itemId and pld.IsActive=1 and pl.IsActive=1
end
return @price
END

--select  [dbo].[fn_GetPriceOfItemFromJDE](0,0)
