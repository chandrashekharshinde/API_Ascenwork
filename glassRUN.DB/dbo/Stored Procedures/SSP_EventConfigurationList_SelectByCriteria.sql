Create PROCEDURE [dbo].[SSP_EventConfigurationList_SelectByCriteria] --'SupplierLOBId = 2 AND  Version <> ','',a
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' EventConfigurationID',
@Output nvarchar(2000) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'EventConfigurationID' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  , EventConfigurationID as EventConfigurationId,SupplierLOBId ,Process ,ec.EventCode
 ,IsRequired,SequenceNumber, StockLocationID as StockLocationId, TransportOperatorID, PlaceOfExecution,pce.ResourceKey
  FROM dbo.EventConfiguration ec JOIN dbo.ProcessConfigurationEvent pce ON ec.EventCode = pce.EventCode
  WHERE  ' + @WhereExpression + '
ORDER BY ' + @SortExpression  +'
 FOR XML PATH(''EventConfigurationInfos''),ELEMENTS)AS XML))'



 SET @Output=@sql

 PRINT @Output
 
 PRINT 'Executed SSP_EventConfigurationList_SelectByCriteria'
---to check
---[dbo].[SSP_SettingMasterList_SelectByCriteria]'SupplierLOBId = 2 AND  Version <> ''''','',fgh
