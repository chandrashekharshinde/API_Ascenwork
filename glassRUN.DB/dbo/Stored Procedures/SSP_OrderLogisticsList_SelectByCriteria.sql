CREATE PROCEDURE [dbo].[SSP_OrderLogisticsList_SelectByCriteria] --'om.OrderMovementId IN (SELECT OrderMovementId FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 39 AND ActualTimeOfAction IS  NULL)','',fg
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' OrderLogisticsId',
@Output nvarchar(2000) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'OrderLogisticsId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


SET @sql = '
(select cast ((SELECT  ''true'' AS [@json:Array]  ,
ol.OrderLogisticsId
 ,OM.[OrderId]
  ,(select od.OrderNumber from [Order] od where od.OrderId=OM.[OrderId]) as OrderNumber
     ,ol.[OrderMovementId]
	  ,OM.[LocationType]
      ,ISNULL(tv.[VehicleRegistrationNumber]  ,''Truck'')   AS TruckRegistrationNumber

 FROM [dbo].OrderLogistics ol
 left JOIN ORDERMOVEMENT OM ON om.OrderMovementId = ol.[OrderMovementId]
 LEFT JOIN dbo.TransportVehicle tv ON tv.TransportVehicleId = ol.TruckId
 WHERE  ol.IsActive = 1  and ' + @WhereExpression + '
 ORDER BY ' + @SortExpression +'
  FOR XML PATH(''OrderLogisticsInfos''),ELEMENTS)AS XML))'
 

  SET @Output=@sql

  PRINT @sql

   PRINT 'Executed SSP_OrderLogisticsList_SelectByCriteria'
