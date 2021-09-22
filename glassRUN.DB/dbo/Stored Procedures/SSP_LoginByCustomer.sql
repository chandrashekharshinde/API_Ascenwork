CREATE  PROCEDURE [dbo].[SSP_LoginByCustomer] --'1111458a',''
@xmlDoc XML


AS

BEGIN
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(4000);
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
 @username = tmp.[userName]
	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			userName nvarchar(max)

			)tmp;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
SELECT CAST((SELECT   'true' AS [@json:Array],

l.LoginId as IntUserId,
'YES' as IsValidLogin,
'YES' as IsRegistered,
'Login Successful' as ErrorMessage,
'sessionValue' as SessionId,
isnull((SELECT STUFF((select ',' +DimensionValue from UserDimensionMapping Where PageName='OrderList' and DimensionName='StockLocationId' and UserDimensionMapping.isactive=1 and UserId=l.LoginId  FOR XML PATH('')),1, 1, '')),0) AS StockLocationCode,
l.DefaultLanguage,
l.ProfileId,
l.RoleMasterId,
l.UserName as Username,
l.HashedPassword,
l.PasswordSalt,
l.LoginAttempts,
l.IsActive,
l.CreatedDate,
'oil_and_gas_marine' AS VcLobName,
3 as IntSupplierLobId,
(select top 1 logo  from Company where CompanyId=4) as SupplierLogo,
(SELECT CAST((select 'true' AS [@json:Array],

p.ProfileId as UserID,
p.Name,
p.IsActive,
p.ReferenceId as IntReferenceId,
p.ReferenceType,
p.IsActive,
r.RoleMasterId as RoleID,
r.RoleName,
c.CompanyMnemonic as VcCustomerCode,
c.CompanyName as VcCustomerName,
c.Addressline1,
c.EmptiesLimit,
c.ActualEmpties,
c.CreditLimit,
c.CreditLimit as AvailableLimit,
c.ParentCompany as IntCompanyId, 
(select pc.CompanyMnemonic  from Company  pc where pc.CompanyId=c.ParentCompany) as VcCompanyCode

From 
Login p   left join Company c on c.CompanyId=p.ReferenceId

 where LoginId =l.LoginId FOR XML path('UserDetails'),ELEMENTS)AS XML)),

( SELECT CAST((
SELECT 'true' AS [@json:Array],
	 i.ItemId,
	 i.ItemId as  VcItemId,
     i.ItemShortCode ,
	 0 as ParentItemId,
	 32 as ItemType,
	 i.ItemName,
	 i.ItemName as VcItemName,
	 i.ItemCode as VcItemCode,
	 i.ProductType,
	 (select dbo.fn_LookupValueById(i.PrimaryUnitOfMeasure)) as  VcUnitMasterName,
	 (select dbo.fn_LookupValueById(i.PrimaryUnitOfMeasure)) as UnitMasterId,
	convert (nvarchar(max),isnull((Select SUM(ISQ.[ItemQuantity]) from [dbo].[ItemStock] ISQ where ISQ.[ItemCode]=i.ItemCode),0)) as IntStockInQuantity,
		5000 as VcAvailableQuota,
		(select dbo.fn_GetPriceOfItem(ItemId, (select  ReferenceId From Login where UserName=@username))) as IntPrices,
		i.ImageUrl as VcImageUrl,
       PFI.FocItemCode as IntPromoId,
       isnull(PFI.FocItemQuantity,0) as FocItemQuantity,
       isnull(PFI.ItemQuanity,0) as ItemQuanity
FROM  Item i left join PromotionFocItemDetail PFI on i.ItemCode=PFI.ItemCode and  GETDATE() BETWEEN PFI.FromDate AND PFI.ToDate  where  i.IsActive=1 
 FOR XML path('ItemInfos'),ELEMENTS)AS XML)),

 ( SELECT CAST((
SELECT 'true' AS [@json:Array],
SettingParameter,SettingValue
		
 FROM  SettingMaster
 FOR XML path('SettingMaster'),ELEMENTS)AS XML)),


 (SELECT CAST((
select 'true' AS [@json:Array],

[LocationId] as VcDeliveryLocationId ,
LocationName as VcName,
ISNULL(AddressLine1,'') + ISNULL(', ' + AddressLine2,'') +  ISNULL(', ' +City,'') +  ISNULL(', ' +State,'') +  ISNULL(', ' +Pincode,'') as ShipToAddress,
Capacity ,
(SELECT   ISNULL(STUFF((Select (SELECT ',' + CAST(ts.TruckSize AS VARCHAR(max)) [text()] from TruckSize ts  where ts.TruckSizeId in 
( select r.TruckSizeId from  Route  r  where    DestinationId=[Location].LocationId) FOR XML PATH(''))
),1,1,''),'')    ) as TruckSizes

from [Location] where IsActive=1 and  CompanyID in (select  ReferenceId From Login where UserName=@username)
 FOR XML path('DeliveryLocationInfos'),ELEMENTS)AS XML))

From Login l left join RoleMaster r on l.RoleMasterId=r.RoleMasterId 
WHERE  l.IsActive=1 -- and  r.RoleMasterId in (4,14,15)
 And Username= @username 
FOR XML path('UsersList'),ELEMENTS,ROOT('Users')) AS XML)

END
