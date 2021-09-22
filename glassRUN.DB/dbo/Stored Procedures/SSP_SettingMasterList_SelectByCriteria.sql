CREATE PROCEDURE [dbo].[SSP_SettingMasterList_SelectByCriteria]--'SupplierLOBId = 3 AND  Version <> ''''','',''
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' SettingMasterId',
@Output nvarchar(2000) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'SettingMasterId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  , 
SettingMasterId,
SettingParameter,
SettingValue,0 AS SupplierLobId,
SettingParameter as label,
SettingValue as value,
 [dbo].[fn_LookupValueById] (DeliveryType) AS DeliveryTypeText, 
[dbo].[fn_LookupValueById] (ProductType) AS ProductTypeText, Description, Version  FROM dbo.SettingMaster 
  WHERE   ' + @WhereExpression + '
ORDER BY ' + @SortExpression  +'
FOR XML PATH(''SettingMasterList''),ELEMENTS)AS XML))'



 SET @Output=@sql

 PRINT @Output
 PRINT 'Executed SSP_SettingMasterList_SelectByCriteria'
---to check
---[dbo].[SSP_SettingMasterList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> ''''','',fgh