CREATE PROCEDURE [dbo].[SSP_EventNotificationListByCriteria] --'','',dfg
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'EventNotificationId',
@Output nvarchar(2000) output

AS




BEGIN


--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'EventNotificationId' END

-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '

	(SELECT CAST((
	
 SELECT 

EventNotificationId,
ObjectId as IntOrderId,
ObjectType,

CreatedDate,
(select SalesOrderNumber from [order] where orderid=ObjectId  ) as VcSalesOrderNumber 

 FROM  dbo.EventNotification
	WHERE IsActive=1 

  and ' + @WhereExpression + 'ORDER BY ' + @SortExpression+'
	
	 FOR XML RAW(''EventNotificationInfos''),ELEMENTS) AS XML))'
	
	
	-- Execute the SQL query

  SET @Output=@sql

  PRINT @sql

   PRINT 'Executed SSP_EventNotificationList_SelectByCriteria'
END