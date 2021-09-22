CREATE FUNCTION [dbo].[fn_GetCurrentDepositOfItem]
(@itemId bigint,@customerId bigint)
RETURNS decimal(18,2)
BEGIN
declare @currentDeposit decimal(18,2)

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
-----	assign item variable 
SELECT	@ItemShortCode=ItemShortCode,@ItemLongCode=ItemLongCode,@ItemPriceGroup=ItemPriceGroup FROM	ItemMasterForPricing where ItemLongCode =@ItemCode


---

------------create Customer list variable
Declare @CustomerNumber nvarchar(200) ;
Declare @CustomerPriceGroup nvarchar(200);


----assing customer variable



SELECT 	@CustomerNumber=A.CustomerNumber,@CustomerPriceGroup=CustomerPriceGroup
FROM 		AddressBookMasterForPricing A JOIN CustomerMasterForPricing B ON A.CustomerNumber=B.CustomerNumber
and a.CustomerNumber=@CustomerCode




---1st priority 
--1. First priority search Sold to  Item Code and Cust Code


select @currentDeposit=Amount From  CurrentDeposit where ItemLongCode=@ItemLongCode and CustomerNumber =@CustomerNumber



if(@currentDeposit > 0)
begin

return @currentDeposit
end
---2nd 
--2. Second priority search Sold To Item Code and Cust. Group

		select @currentDeposit=Amount From  CurrentDeposit 

		where ItemLongCode =@ItemLongCode and CustomerGroup=@CustomerPriceGroup

if(@currentDeposit > 0)
begin

return @currentDeposit
end

--3rd
--3. Third priority search Sold To Item Group and Cust. Code

		select @currentDeposit=Amount From  CurrentDeposit 

		where ItemGroup =@ItemPriceGroup and CustomerNumber=@CustomerNumber


if(@currentDeposit > 0)
begin

return @currentDeposit
end


--4. Fourth priority search Sold To Item Group and Cust. Group
--On Sales Order look in 2 code ItemShortCode,CustomerGroupID	

		select @currentDeposit=Amount From  CurrentDeposit 

		where ItemGroup =@ItemPriceGroup and CustomerGroup=@CustomerPriceGroup

if(@currentDeposit > 0)
begin

return @currentDeposit
end

--5. Five priority just search Item Code for All Customer
--On Sales Order look in 2 code ItemShortCode,CustomerGroupID

		select @currentDeposit=Amount From  CurrentDeposit 

		where ItemLongCode =@ItemLongCode and CustomerNumber = 0  and   (CustomerGroup='' or CustomerGroup='0')
if(@currentDeposit > 0)
begin

return @currentDeposit
end

		--6. Six priority just search Item Group For All Customer
--On Sales Order look in 2 code ItemShortCode,CustomerGroupID

		select @currentDeposit=Amount From  CurrentDeposit 

		where ItemGroup =@ItemPriceGroup and CustomerNumber = 0  and (CustomerGroup='' or CustomerGroup='0') and  (ItemLongCode='' or ItemLongCode='0')

return @currentDeposit

END
