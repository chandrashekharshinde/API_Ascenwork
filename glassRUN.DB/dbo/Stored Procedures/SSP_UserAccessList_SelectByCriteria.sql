create PROCEDURE [dbo].[SSP_UserAccessList_SelectByCriteria]--'u.SupplierLOBId = 2  and  ud.roleId in (SELECT RoleMasterId FROM  dbo.RoleMaster WHERE RoleType=''StockLocationManager'') ','',dfgh
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' l.LoginId',
@Output nvarchar(2000) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'l.LoginId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  ,  L.LoginId  as UserId,
 L.UserName    as Username,
 L.HashedPassword    as HashedPassword,
 L.PasswordSalt    as PasswordSalt,

 8    as ProductType,
  7    as ModeOfDelivery,
  13 as LocationId,
  NULL as LocationType,

p.Name AS FullName 
FROM dbo.login l 
LEFT JOIN dbo.Profile p ON p.ProfileId = l.ProfileId
WHERE  l.Isactive=1 and ' + @WhereExpression + '
 ORDER BY ' + @SortExpression + '
  FOR XML PATH(''UserAccessInfos''),ELEMENTS)AS XML))'
 SET @Output=@sql

 PRINT @sql

 PRINT 'Executed SSP_UserAccessList_SelectByCriteria'
