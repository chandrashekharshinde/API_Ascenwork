
create  PROCEDURE [dbo].[SSP_OrderStateConfirmationList_SelectByCriteria] --'OS.OrderMovementId IN (SELECT OrderMovementId FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 39 AND ActualTimeOfAction IS NULL)','',fgh
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' OS.[OrderStateConfirmationId]',
@Output nvarchar(2000) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = ' OS.[OrderStateConfirmationId]' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = 
'(select cast ((SELECT  ''true'' AS [@json:Array]  ,
 OS.[OrderStateConfirmationId]
      ,OS.[OrderMovementId]
	   ,OM.[LocationType]
      ,OS.[OrderId]
      ,OS.[SupplierConfirmationId]
      ,OS.[SupplierConfirmationStatus]
      ,OS.[SupplierConfirmationDate]
      ,OS.[RecieverConfirmationId]
      ,OS.[RecieverConfirmationStatus]
      ,OS.[RecieverConfirmationDate]
      ,OS.[IsActive]
	  
 FROM [ORDERSTATECONFIRMATION] OS 
 left JOIN ORDERMOVEMENT OM ON om.OrderMovementId = OS.[OrderMovementId]
 WHERE  OS.IsActive = 1 AND ' + @WhereExpression + '
ORDER BY ' + @SortExpression  + '
FOR XML PATH(''OrderStateConfirmationInfos''),ELEMENTS)AS XML))'



 SET @Output=@sql
 PRINT @Output

 PRINT 'Executed SSP_OrderStateConfirmationList_SelectByCriteria'




--DECLARE @dyanamicQuery NVARCHAR(max)
--DECLARE @orderStateConfirmationListOutput nvarchar(max)

--SET @dyanamicQuery = 'OS.OrderMovementId IN (SELECT OrderMovementId FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = '+ CONVERT(NVARCHAR(200),41) +' AND ActualTimeOfAction IS NULL)'

--EXEC  [dbo].[SSP_OrderStateConfirmationList_SelectByCriteria] @dyanamicQuery,'',@orderStateConfirmationListOutput OUTPUT

-- PRINT @orderStateConfirmationListOutput
