Create PROCEDURE [dbo].[SSP_ProcessConfigurationList_SelectByCriteria] --'SupplierLOBId = 3 AND  Version <> ''''','',fgh
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' ProcessConfigurationForAppID',
@Output nvarchar(2000) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'ProcessConfigurationForAppID' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '(select cast ((SELECT  ''true'' AS [@json:Array]  , [ProcessConfigurationForAppID]
		    ,[SupplierID]
           ,[LOBId]
		   ,[SupplierLOBId]
           ,[dbo].[fn_LookupValueById] (ModeOfDelivery) AS DeliveryType 
           ,[dbo].[fn_LookupValueById] (ProductType) AS ProductTypeName 
           ,[ProcessID]
		   ,[dbo].[fn_LookupValueById] (ProcessID) AS ProcessName 
           ,[SequenceNumber]
           ,[IsApp]
  FROM dbo.ProcessConfigurationForApp 
  WHERE  ' + @WhereExpression + '
ORDER BY ' + @SortExpression  +'

 FOR XML PATH(''ProcessConfigurationList''),ELEMENTS)AS XML))'

--PRINT @sql

 SET @Output=@sql


 PRINT 'Executed SSP_ProcessConfigurationList_SelectByCriteria'


--- EventFormId,[dbo].[fn_LookupValueById] (ProductTypeId) AS ProductType ,[dbo].[fn_LookupValueById] (ModeOfDelivery) AS DeliveryType ,SupplierLOBID AS SupplierLobId
 --,EventConfigurationID
 --,ParentAttributeConfigurationId,AttributeName, ResourceKey,  [dbo].[fn_LookupValueById] (AttributeType) AS AttributeTypeValue , AttributeMinOccurence,AttributeMaxOccurence,ProcessName,ListValues,
 --Version
---to check
---[dbo].[SSP_SettingMasterList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> ''''','',fgh
