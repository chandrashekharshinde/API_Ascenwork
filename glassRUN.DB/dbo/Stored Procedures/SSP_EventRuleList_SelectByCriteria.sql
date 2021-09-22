Create PROCEDURE [dbo].[SSP_EventRuleList_SelectByCriteria]--'SupplierLOBId = 2 AND  Version <> '''''
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' SettingMasterId',
@Output nvarchar(2000) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'EventRuleId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  , EventRuleId,[dbo].[fn_LookupValueById] (ProductTypeId) AS ProductType ,[dbo].[fn_LookupValueById] (ModeOfDelivery) AS DeliveryType ,SupplierLOBID AS SupplierLobId,
 EventConfigurationID as EventConfigurationId,RuleFormula, RuleDescription, RuleType, Version
  FROM dbo.EventRule 
  WHERE   IsActive = 1  and ' + @WhereExpression + '
ORDER BY ' + @SortExpression  +'
 FOR XML PATH(''EventRuleList''),ELEMENTS)AS XML))'



 SET @Output=@sql


 PRINT 'Executed SSP_EventRuleList_SelectByCriteria'
---to check
---[dbo].[SSP_SettingMasterList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> ''''','',fgh
