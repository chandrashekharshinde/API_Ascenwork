CREATE FUNCTION [dbo].[fn_GetPriceOfItem]
(@itemId bigint,@customerId bigint)
RETURNS decimal(18,2)
BEGIN
declare @price decimal(18,2)=0

declare @ItemCode nvarchar(200) 

set  @ItemCode = (select top 1 ItemCode  from Item where  ItemId=@itemId)

declare @CustomerCode  nvarchar(200) 

set  @CustomerCode = (select top 1 CompanyMnemonic  from Company where  CompanyId=@customerId)


declare @Count bigint

set  @Count =1

---------------create item  list variable
Declare @ItemShortCode nvarchar(200) ;
Declare @ItemLongCode nvarchar(200);
Declare @ItemPriceGroup nvarchar(200);



----- assign item variable 
SELECT @ItemShortCode=ItemShortCode,@ItemLongCode=ItemLongCode,@ItemPriceGroup=ItemPriceGroup FROM ItemMasterForPricing where ItemLongCode =@ItemCode



---

------------create Customer list variable
Declare @CustomerNumber nvarchar(200) ;
Declare @CustomerPriceGroup nvarchar(200);


----assing customer variable



SELECT  @CustomerNumber=A.CustomerNumber,@CustomerPriceGroup=CustomerPriceGroup
FROM   AddressBookMasterForPricing A JOIN CustomerMasterForPricing B ON A.CustomerNumber=B.CustomerNumber
and a.CustomerNumber=@CustomerCode


---1st priority 
--1. First priority search Sold to  Item Code and Cust Code
SELECT @price=PRICE
FROM ItemBasePrice A JOIN ItemMasterForPricing B ON (A.ItemShortCode = B.ItemShortCode)
  JOIN AddressBookMasterForPricing C ON (A.AddressNumber = C.CustomerNumber)
WHERE (DBO.DMYTOJUL(GETDATE())  between EffectiveDate and ExpiryDate) AND (A.ItemShortCode>0 AND AddressNumber>0)
and   A.ItemLongCode =@ItemLongCode  and C.CustomerNumber =@CustomerNumber

if(@price > 0)
begin

return @price
end
---2nd 
--2. Second priority search Sold To Item Code and Cust. Group

SELECT @price=PRICE
FROM ItemBasePrice A JOIN ItemMasterForPricing B ON (A.ItemShortCode = B.ItemShortCode)
  JOIN CustomerGroupForPricing C ON (A.CustomerGroupID = C.CustomerGroupID)
WHERE (DBO.DMYTOJUL(GETDATE())  between EffectiveDate and ExpiryDate)
  AND A.ItemShortCode>0 AND C.CustomerGroupID>0 
  and a.ItemLongCode=@ItemLongCode and c.CustomerPriceGroup=@CustomerPriceGroup

if(@price > 0)
begin

return @price
end

--3rd
--3. Third priority search Sold To Item Group and Cust. Code

SELECT @price=PRICE
FROM ItemBasePrice A 
  JOIN ItemGroupForPricing C ON (A.ItemGroupId = C.ItemPriceGroupID)
  JOIN AddressBookMasterForPricing D ON (A.AddressNumber = D.CustomerNumber)
WHERE (DBO.DMYTOJUL(GETDATE())  between EffectiveDate and ExpiryDate)
  AND ItemGroupId>0 AND AddressNumber>0
  and c.ItemPriceGroup=@ItemPriceGroup and D.CustomerNumber = @CustomerNumber

 


if(@price > 0)
begin

return @price
end


--4. Fourth priority search Sold To Item Group and Cust. Group
--On Sales Order look in 2 code ItemShortCode,CustomerGroupID 
SELECT @price=PRICE
FROM ItemBasePrice A 
  JOIN ItemGroupForPricing C ON (A.ItemGroupId = C.ItemPriceGroupID)
  JOIN CustomerGroupForPricing D ON (A.CustomerGroupID = D.CustomerGroupID)
WHERE (DBO.DMYTOJUL(GETDATE())  between EffectiveDate and ExpiryDate)
  AND A.ItemGroupId>0 AND D.CustomerGroupID>0
  and C.ItemPriceGroup=@ItemPriceGroup and D.CustomerPriceGroup=@CustomerPriceGroup
if(@price > 0)
begin

return @price
end

--5. Five priority just search Item Code for All Customer
--On Sales Order look in 2 code ItemShortCode,CustomerGroupID
SELECT @price=PRICE
FROM ItemBasePrice A JOIN ItemMasterForPricing B ON (A.ItemShortCode = B.ItemShortCode)
WHERE (DBO.DMYTOJUL(GETDATE())  between EffectiveDate and ExpiryDate )
  AND a.ItemShortCode>0 AND AddressNumber=0 AND CustomerGroupID=0
  and a.ItemLongCode=@ItemLongCode 
if(@price > 0)
begin

return @price
end

  --6. Six priority just search Item Group For All Customer
--On Sales Order look in 2 code ItemShortCode,CustomerGroupID
SELECT  @price=PRICE
FROM ItemBasePrice A 
  JOIN ItemGroupForPricing C ON (A.ItemGroupId = C.ItemPriceGroupID)
WHERE (DBO.DMYTOJUL(GETDATE())  between EffectiveDate and ExpiryDate)
  AND ItemGroupId>0 AND AddressNumber=0 AND CustomerGroupID=0
  and C.ItemPriceGroup =@ItemPriceGroup

  if(@price > 0)
begin

return @price
end


--7. Seventh priority just search Item from ItemBasePrice Using ItemLongCode

SELECT  @price=PRICE
FROM ItemBasePrice A 
WHERE (DBO.DMYTOJUL(GETDATE())  between EffectiveDate and ExpiryDate)
and A.ItemLongCode =@ItemCode

return @price

END
