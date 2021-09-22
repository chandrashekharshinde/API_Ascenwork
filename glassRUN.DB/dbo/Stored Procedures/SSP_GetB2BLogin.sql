CREATE PROCEDURE [dbo].[SSP_GetB2BLogin] --'<Json><userName>Subd1</userName></Json>'
@xmlDoc XML


AS

BEGIN
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(4000);
Declare @username nvarchar(max)
Declare @vendorId  nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
 @username = tmp.[userName],
 @vendorId= tmp.[vendorId]
	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			userName nvarchar(max),
			vendorId nvarchar(max)

			)tmp;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
SELECT CAST((SELECT   'true' AS [@json:Array],

l.LoginId as IntUserId,
'YES' as IsValidLogin,
'YES' as IsRegistered,
'Login Successful' as ErrorMessage,
'sessionValue' as SessionId,
isnull((SELECT STUFF((select ',' +DimensionValue from UserDimensionMapping Where PageName='OrderList' and DimensionName='StockLocationId' and UserId=l.LoginId  FOR XML PATH('')),1, 1, '')),0) AS StockLocationCode,
l.ProfileId,
l.RoleMasterId,
l.UserName as Username,
l.HashedPassword,
l.PasswordSalt,
l.LoginAttempts,
l.IsActive,
l.CreatedDate,
ISNULL(l.CompletedSetupStep,0) as CompletedSetupStep,
ISNULL(l.IsStepCompleted,0) as IsStepCompleted,
'oil_and_gas_marine' AS VcLobName,
3 as IntSupplierLobId,
(select top 1 logo  from Company where CompanyId=l.ReferenceId) as SupplierLogo,
ISNULL(l.IsAgree,0) as IsAgree,
Isnull((Select top 1 ResourceValue from Resources where ResourceKey='res_EulAgreement' and CultureId=1101 and IsActive=1),'') as EulAgreement,
Isnull((Select top 1 sm.SettingValue from SettingMaster sm where sm.SettingParameter='EULARequired' and IsActive=1),'') as EULARequired,
(SELECT CAST((select
p.ProfileId as UserID,
p.Name,
p.IsActive,
p.ReferenceId ,
p.ReferenceType,
p.UserName,
r.RoleMasterId,
r.RoleName,
c.CompanyMnemonic,
c.CompanyName,
c.Addressline1,
c.EmptiesLimit,
c.ActualEmpties,
c.CreditLimit,
(Select STRING_AGG(ItemCode, ', ')  from Item WHERE IsActive = 1 and
isnull(ItemOwner,0)in(p.ReferenceId )) OwnerProductCode,

(Select STRING_AGG(ItemCode, ',')  from Item WHERE IsActive = 1 and
isnull(ItemOwner,0)in(SELECT ID FROM [dbo].[fngetHierarchyParent] (p.ReferenceId ))) as HeinekenProductCode,

(Select STRING_AGG(ItemCode, ',') from Item WHERE IsActive = 1 
and ItemId in (Select ItemSupplier.ItemId from ItemSupplier where ItemSupplier.CompanyId in (SELECT hi.ParentCompanyId FROM [dbo].Hierarchy hi where hi.CompanyId = p.ReferenceId and hi.IsActive = 1  and ISNULL(hi.ParentCompanyId,0) != 0 ) and ItemSupplier.IsActive = 1)
and isnull(ItemOwner,0)in(SELECT ID FROM [dbo].[fngetHierarchyParent] (p.ReferenceId))) as DistributorProductCode,
1 as MainParentCompany,
isnull((SELECT STUFF((select ',' +CAST(hi.ParentCompanyId AS NVARCHAR(50)) FROM [dbo].Hierarchy hi where hi.CompanyId = p.ReferenceId and ISNULL(hi.ParentCompanyId,0) != 0 and hi.IsActive = 1  FOR XML PATH('')),1, 1, '')),0)  As ParentCompany  
From 
Login p   left join Company c on c.CompanyId=p.ReferenceId
where LoginId =l.LoginId FOR XML path('UserDetails'),ELEMENTS)AS XML)),
(SELECT CAST((select top 1
lh.[LoginHistoryId]
      ,lh.[LoginId]
      ,lh.[Username]
      ,lh.[LogoutType]
      ,lh.[LoggingInTime]
      ,lh.[LoggingOutTime]
      ,lh.[DeviceLoggingInTime]
      ,lh.[DeviceLoggingOutTime]
      ,lh.[AddFrom]
      ,lh.[MACAddress]
      ,lh.[LoginReason]
      ,lh.[LogoutReason]
      ,lh.[LoginStatus]
      ,lh.[LoginNetworkStatus]
      ,lh.[LogoutNetworkStatus]
      ,lh.[LogOutLatitude]
      ,lh.[LogOutLongitude]
      ,lh.[LoginLatitude]
      ,lh.[LoginLongitude]
      ,lh.[LoggingInDeviceUniqueId]
      ,lh.[LogoutDeviceUniqueId]
      ,lh.[Guid]
      ,lh.[IsActive]
      ,lh.[CreatedDate]
      ,lh.[CreatedBy]
      ,lh.[CreatedFromIPAddress]
      ,lh.[UpdatedDate]
      ,lh.[UpdatedBy]
      ,lh.[UpdatedFromIPAddress]
From 
LoginHistory lh
where lh.Username =l.UserName and lh.AddFrom='B2B' 
and Isnull(lh.LoggingInDeviceUniqueId,'') !='' 
and lh.LoginStatus='1' 
and Isnull(lh.DeviceLoggingOutTime,'1900-01-01 00:00:00.000') ='1900-01-01 00:00:00.000'
and isnull(l.IsStepCompleted,'0') !='1'
order by lh.LoginHistoryId desc
FOR XML path('LoginHistoryList'),ELEMENTS)AS XML))
From Login l left join RoleMaster r on l.RoleMasterId=r.RoleMasterId 
WHERE  l.IsActive=1 
 And Username= @username 
FOR XML path('UsersList'),ELEMENTS,ROOT('Users')) AS XML)



END
