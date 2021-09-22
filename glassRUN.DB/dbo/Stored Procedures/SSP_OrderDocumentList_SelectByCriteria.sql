Create PROCEDURE [dbo].[SSP_OrderDocumentList_SelectByCriteria] --'ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 39 AND ActualTimeOfAction IS  NULL)','',sdf
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'OrderDocumentId',
@Output nvarchar(2000) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'OrderDocumentId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '(select cast ((SELECT  ''true'' AS [@json:Array]  ,

  od.OrderId,
  	  o.OrderNumber,
  od.OrderProductId,

  od.DocumentTypeId,

 (SELECT dbo.fn_LookupValueById(DocumentTypeId)) ''DocumentType'',
  DocumentBlob

 FROM dbo.OrderDocument od join [Order] o on od.OrderId=o.OrderId
  WHERE  ' + @WhereExpression + '
ORDER BY ' + @SortExpression  +'

 FOR XML PATH(''OrderDocumentInfos''),ELEMENTS)AS XML))'
 

 --PRINT @sql
 -- Execute the SQL query
--EXEC sp_executesql @sql

 SET @Output=@sql

 PRINT 'Executed SSP_OrderDocumentList_SelectByCriteria'

-- PRINT @Output
