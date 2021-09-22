Create PROCEDURE [dbo].[SSP_EventFormList_SelectByCriteria] --'SupplierLOBId = 3 AND  Version <> ''''','',fgh
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' EventFormId',
@Output nvarchar(2000) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'EventFormId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
( select cast ((SELECT  ''true'' AS [@json:Array]  , EventFormId,[dbo].[fn_LookupValueById] (ProductTypeId) AS ProductType ,[dbo].[fn_LookupValueById] (ModeOfDelivery) AS DeliveryType ,SupplierLOBID AS SupplierLobId
 ,EventConfigurationID
 ,ParentAttributeConfigurationId,AttributeName, ResourceKey,  [dbo].[fn_LookupValueById] (AttributeType) AS AttributeTypeValue , AttributeMinOccurence,AttributeMaxOccurence,ProcessName,ListValues,Version
  FROM dbo.EventForm 
  WHERE   IsActive = 1  and ' + @WhereExpression + '
ORDER BY ' + @SortExpression  +'
 FOR XML PATH(''EventFormInfos''),ELEMENTS)AS XML))'

--PRINT @sql

 SET @Output=@sql
 print  @Output

 PRINT 'Executed SSP_EventFormList_SelectByCriteria'
---to check
---[dbo].[SSP_SettingMasterList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> ''''','',fgh
