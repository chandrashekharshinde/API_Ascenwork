Create  PROCEDURE [dbo].[SSP_SafeAppFormsList_SelectByCriteria] --'SupplierLOBId = 2 AND  Version <> '''' AND roleMasterid  IN (SELECT RoleId FROM  dbo.UserDetails WHERE UserId=39)'
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' AppFormId',
@Output nvarchar(2000) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = ' AppFormId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  ,
 AppFormId,
 0 as SupplierId,
 LOBId,
 0 AS SupplierLobId,
 FormType,
 formContent AS FormContent ,
 ContentType AS ContentType,
 Version,
 0 as ModeOfDelivery,
 OrderType

  FROM dbo.AppForms 
WHERE  IsActive = 1  AND ' + @WhereExpression + '
ORDER BY ' + @SortExpression +'
 FOR XML PATH(''SafeAppFormList''),ELEMENTS)AS XML))'
-- [dbo].[SSP_AppFormsList_SelectByCriteria] 'SupplierLOBId = 2 AND  Version <> '''' AND roleMasterid  IN (SELECT RoleId FROM  dbo.UserDetails WHERE UserId=39)'

 SET @Output=@sql


 PRINT 'Executed SSP_AppFormsList_SelectByCriteria'
