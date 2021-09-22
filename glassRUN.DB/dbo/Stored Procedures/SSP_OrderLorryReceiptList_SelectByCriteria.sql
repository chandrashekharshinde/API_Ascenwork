﻿CREATE PROCEDURE [dbo].[SSP_OrderLorryReceiptList_SelectByCriteria]--'ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 19 AND ActualTimeOfAction IS  NULL)','',dfdf
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'OrderId',
@Output nvarchar(max) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'OrderId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(max)


SET @sql ='(Select Cast((select   ''true'' AS [@json:Array]  , OrderId ,

  ORDER BY ' + @SortExpression  + '
 FOR XML PATH(''LorryReceiptInfos''),ELEMENTS)AS XML))'

  
 


 
 SET @Output=@sql
 PRINT @sql
 PRINT 'Executed SSP_LorryReceiptList_SelectByCriteria'