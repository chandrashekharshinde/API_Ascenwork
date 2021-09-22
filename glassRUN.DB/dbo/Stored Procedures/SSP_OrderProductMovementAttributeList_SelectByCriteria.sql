
Create PROCEDURE [dbo].[SSP_OrderProductMovementAttributeList_SelectByCriteria] --'opma.OrderId IN (SELECT OrderId FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 88 AND ActualTimeOfAction IS  NULL)','',''
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'OrderProductMovementAttributeId',
@Output nvarchar(2000) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'OrderProductMovementAttributeId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '(select cast ((SELECT  ''true'' AS [@json:Array]  , OrderProductMovementAttributeId,
          OrderProductMovementId ,
          opma.OrderCompartmentId ,
          opma.OrderID ,
          opma.OrderProductID ,
          OrderProductMovementAttributeConfigurationId ,
		  CompartmentName,
          AttributeName ,
          AttributeValue ,
		  SequenceNumber
		   
 FROM  dbo.OrderProductMovementAttribute opma 
 WHERE  opma.IsActive = 1 and ' + @WhereExpression + '
 ORDER BY '+ @SortExpression +'
FOR XML PATH(''OrderProductMovementAttributeList''),ELEMENTS)AS XML))'
 
 
 
 SET @Output=@sql
 
 PRINT @Output

 PRINT 'Executed SSP_OrderProductMovementAttributeList_SelectByCriteria'
