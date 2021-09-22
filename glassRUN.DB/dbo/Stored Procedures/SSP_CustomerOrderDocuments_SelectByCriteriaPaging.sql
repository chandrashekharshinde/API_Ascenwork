CREATE PROCEDURE [dbo].[SSP_CustomerOrderDocuments_SelectByCriteriaPaging] --'OrderId IN (SELECT OrderId FROM  dbo.[Order] WHERE CustomerId IN (SELECT ReferenceID FROM dbo.UserDetails WHERE  UserID = 20021 ) AND CurrentState not in (SELECT  [dbo].[fn_LookupIdByValue](''Unscheduled'')))','',0,15,sdf
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'OrderDocumentId',
@Output nvarchar(2000) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'OrderDocumentId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(SELECT CAST((SELECT ''true'' AS [@json:Array] ,
 od.OrderDocumentId,
  od.OrderId as IntOrderId,

  od.OrderProductId as IntOrderProductId,

  od.DocumentTypeId,

 (SELECT dbo.fn_LookupValueById(od.DocumentTypeId)) ''VcOrderDocumentType''


 FROM dbo.OrderDocument od join [order] o on o.OrderId=od.OrderId
 WHERE  ( DocumentTypeId In (SELECT  [dbo].[fn_LookupIdByValue](''POD'')) or DocumentTypeId In (SELECT  [dbo].[fn_LookupIdByValue](''TemplateForm''))) AND
  ' + @WhereExpression + '
FOR XML PATH(''OrderDocumentInfos''),ELEMENTS )AS XML))'

 

 PRINT @sql
 -- Execute the SQL query
--EXEC sp_executesql @sql

 SET @Output=@sql

 PRINT 'Executed SSP_OrderDocumentList_SelectByCriteria'