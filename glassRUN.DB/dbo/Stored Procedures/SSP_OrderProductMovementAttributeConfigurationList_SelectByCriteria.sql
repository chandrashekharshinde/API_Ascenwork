Create PROCEDURE [dbo].[SSP_OrderProductMovementAttributeConfigurationList_SelectByCriteria]--'SupplierLOBId = 2 AND  Version <> '''''
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' OrderProductMovementAttributeConfigurationId',
@Output nvarchar(2000) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'OrderProductMovementAttributeConfigurationId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  , OrderProductMovementAttributeConfigurationId,[dbo].[fn_LookupValueById] (ModeOfDelivery) AS DeliveryTypeText, [dbo].[fn_LookupValueById] (ProductTypeId) AS ProductTypeText,SupplierLOBID AS VcSupplierLobId,ParentAttributeConfigurationId,AttributeName,ResourceKey,AttributeType,
 AttributeMinOccurence,AttributeMaxOccurence,ProcessName,ListValues,Version FROM dbo.OrderProductMovementAttributeConfiguration 
 WHERE IsActive = 1 and ' + @WhereExpression + '
 ORDER BY ' + @SortExpression  + '
  FOR XML PATH(''OrderProductMovementAttributeConfigurationList''),ELEMENTS)AS XML))'


 
 SET @Output=@sql


 PRINT 'Executed SSP_OrderProductMovementAttributeConfigurationList_SelectByCriteria'


---to check
---[dbo].[SSP_OrderProductMovementAttributeConfigurationList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> '''''


 -- Execute the SQL query
