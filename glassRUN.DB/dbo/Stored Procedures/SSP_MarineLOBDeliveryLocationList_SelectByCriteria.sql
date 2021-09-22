CREATE PROCEDURE [dbo].[SSP_MarineLOBDeliveryLocationList_SelectByCriteria]--'o.ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 121 AND ActualTimeOfAction IS  NULL)','',hjk
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'DL.LocationId',
@Output NVARCHAR(max) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'DL.LocationId' END


-- ISSUE QUERY
DECLARE @sql NVARCHAR(max)


SET @sql = '(select cast ((SELECT  ''true'' AS [@json:Array]  ,
 o.[OrderId]
      ,3 as SupplierLOBId
	  ,c.CompanyId as  CustomerId
       ,8000 as OrderType
	  , 7001 as ModeOfDelivery 
      ,o.[OrderNumber]
      ,o.[PurchaseOrderNumber]
      ,o.[SalesOrderNumber]
      ,NULL as PartOfSalesOrder
	  ,om.ExpectedTimeOfAction as  RequestedDateOfDelivery
      , o.ExpectedTimeOfDelivery as  ExpectedDateOfDelivery
	  
      ,NULL as ActualDateOfDelivery
	   ,NULL as ReceivedEmail
      ,o.[PreviousState]
      ,o.[CurrentState]
      ,o.[NextState]
      ,NULL as EmailSentTimeForFulfilment
	  ,NULL as CustomerSignatureName
	  ,NULL as DriverSignatureName
      ,o.[IsActive]
      ,o.[CreatedBy]
      ,o.[CreatedDate]
      
	   ,c.CompanyName AS ''CustomerName''
	  ,	1 as IsTripSheetCreated
	  ,NULL as IsPartialDelivered
	   ,NULL as DrnRemark
	  
		, dl.LocationName as DeliveryLocation
		, dl.LocationName as VesselName
 ,NULL as VesselETA
 ,NULL as VesselETD
 ,NULL as  IMONumber
 ,dl.LocationId as MarineLobDeliveryLocationId
 ,NULL as IsVesselVerified
,NULL as IsNextPortSameCountry
 ,NULL as MooringStartTime
 , NULL as UnMooringStartTime
 , NULL as UnMooringEndTime
 ,NULL as Status
,NULL as PortName
 ,NULL as PortCode
 ,1 as IsPDCRequired
,NULL as Country
, NULL as BerthName
 ,NULL as Remarks
   ,NULL as VesselEmail
,''Stock location 1'' as StockLocation
,case when om.LocationType=1 then 21 else 27 end as  LocationType
,om.OrderMovementId
,om.GroupName
,case when om.ActualTimeOfAction is null then 0 else 1 end as IsStopComplete
--,(SELECT [dbo].[fn_LookupValueById] (DL.LocationType)) as LocationTypeValue 
,(select case when om.LocationType=1 then ''Collection'' else ''Delivery'' end ) as LocationTypeValue 
,(select count(op.OrderProductId) from OrderProduct op where op.OrderId=o.OrderId and op.IsActive =1 and  op.ProductCode not in (select SettingValue from SettingMaster where SettingParameter=''WoodenPalletCode'')) as ProductCount
 FROM [ORDER] o left JOIN Company c ON c.CompanyId = o.SoldTo
 left join [OrderMovement] om on o.OrderId=om.OrderId
LEFt JOIN [Location] DL ON om.[Location] = dl.LocationId

 WHERE  o.IsActive = 1   
 AND c.IsActive = 1 
 and ' + @WhereExpression + '
 ORDER BY ' + @SortExpression +'
  FOR XML PATH(''DeliveryLocationList''),ELEMENTS)AS XML))'


  SET @Output=@sql

  PRINT @Output

 PRINT 'Executed SSP_MarineLOBDeliveryLocationList_SelectByCriteria'
