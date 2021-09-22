CREATE  PROCEDURE [dbo].[SSP_OrderProductMovementList_SelectByCriteria]--'opm.OrderMovementId IN (SELECT OrderMovementId FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] =117 AND ActualTimeOfAction IS  NULL)','',dfgd
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' opm.OrderProductMovementId',
@Output nvarchar(max) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'opm.OrderProductMovementId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(max)


SET @sql = '(select cast ((SELECT  ''true'' AS [@json:Array]  
 ,opm.[OrderId] as IntOrderId
  ,opm.[OrderId]
 ,(select od.OrderNumber from [Order] od where od.OrderId=opm.[OrderId]) as OrderNumber
 ,(select op.ProductCode from [OrderProduct] op where op.OrderProductId=opm.[OrderProductId]  and isactive = 1) as ProductCode
 ,(select op.ItemType from [OrderProduct] op where op.OrderProductId=opm.[OrderProductId]  and isactive = 1) as ItemType
 ,(select (SELECT [dbo].[fn_LookupValueById] (I.PrimaryUnitOfMeasure)) from Item I where I.ItemCode in (select op.ProductCode from [OrderProduct] op where op.OrderProductId=opm.[OrderProductId] and isactive = 1)) as [UnitOfMeasure]
 ,(select PrimaryUnitOfMeasure from Item where itemCode in (select op.ProductCode from [OrderProduct] op where op.OrderProductId=opm.[OrderProductId] and isactive = 1)) as PrimaryUnitOfMeasure
 ,opm.[OrderProductId]
,opm.[OrderProductId] as IntOrderProductId
 ,opm.[OrderMovementId] as IntOrderMovementId
,OM.[LocationType] as VcLocationType
 ,opm.[OrderMovementId]
,OM.[LocationType]
,OM.[GroupName]  
 , Convert(bigint,ISNULL(opm.[PlannedQuantity] ,0)) as  PlannedQuantity
 ,  Convert(bigint,ISNULL(opm.[ActualQuantity] ,0))  as ActualQuantity
 ,opm.[DeliveryStartTime]
 ,opm.[DeliveryEndTime]
 ,Convert(bigint,ISNULL(opm.[PlannedQuantity] ,0)) as VcPlannedQuantity
 ,Convert(bigint,ISNULL(opm.[ActualQuantity] ,0)) as VcActualQuantity
 ,opm.[DeliveryStartTime] as DtDeliveryStartTime
 ,opm.[DeliveryEndTime] as  DtDeliveryEndTime
 ,opm.[OMLotNumber]
,opm.IsPumped 

,OPM.IsDeliveredAll as IsDeliveredAll
,Case when (select COUNT(*) from OrderAndSIRelation where OrderId = opm.[OrderId] and IsActive = 1)  > 0 then 1 else 0 end as IsSIExist
,0 as VcGradeSequence
,0 as GradeSequence
	  ,
 (select cast ((SELECT  ''true'' AS [@json:Array]  ,  OrderId,t1.OrderProductId,
 (select top 1 op.ProductCode from [OrderProduct] op where op.OrderProductId = t1.OrderProductId  and isactive = 1) as ProductCode,
 isnull(t1.OMLotNumber,'''') as LotNumber,
isnull(PlannedQuantity,0) as Quantity,
 isnull(ActualQuantity,0) as CollectedQuantity ,
 isnull(PlannedQuantity,0) as ProductQuantity,
 isnull(ActualQuantity,0) as PlanCollectedQuantity ,
 isnull(ActualQuantity,0) as DeliveredQuantity
FROM OrderProductMovement t1 
WHERE t1.IsActive=1 
and t1.OrderProductMovementId = opm.OrderProductMovementId

FOR XML path(''ProductLotInfo''),ELEMENTS) AS xml))
 ,(select cast ((SELECT  ''true'' AS [@json:Array]  , OrderId ,ProductCode,t1.ItemType,isnull(t1.LotNumber,'''') as LotNumber, isnull(ProductQuantity,0) as Quantity,isnull(ProductQuantity,0) as ProductQuantity, isnull(CollectedQuantity,0) as CollectedQuantity,isnull(CollectedQuantity,0) as PlanCollectedQuantity, isnull(DeliveredQuantity,0) as DeliveredQuantity
		FROM OrderProduct t1 
		WHERE t1.IsActive=1 and t1.OrderId = opm.[OrderId] and ISNULL(DeliveredQuantity,0) !=0  
		and t1.OrderProductId = opm.OrderProductId
 FOR XML path(''UsedLotInformationList''),ELEMENTS) AS xml))
 FROM [dbo].[OrderProductMovement] opm
 left JOIN ORDERMOVEMENT OM ON om.OrderMovementId = opm.[OrderMovementId]
 WHERE  opm.IsActive = 1 
  and ' + @WhereExpression + '
 ORDER BY ' + @SortExpression +'
  FOR XML PATH(''OrderProductMovementInfos''),ELEMENTS)AS XML))'
 

  SET @Output=@sql

  PRINT @Output
--  and (t1.OrderId in 
--(CASE WHEN not EXISTS  (select top 1 SIOrderId from OrderAndSIRelation os where os.OrderId=opm.[OrderId] and IsActive = 1) 
--  THEN opm.[OrderId] 
--END)
--or  t1.OrderId in (select SIOrderId from OrderAndSIRelation os where os.OrderId=opm.[OrderId] and IsActive = 1))
   PRINT 'Executed SSP_OrderProductMovementList_SelectByCriteria'