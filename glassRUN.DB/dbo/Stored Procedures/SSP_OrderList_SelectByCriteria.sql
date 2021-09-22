CREATE  PROCEDURE [dbo].[SSP_OrderList_SelectByCriteria]-- 'ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 120 AND ActualTimeOfAction IS  NULL)','',dfdf
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'OrderId',
@Output nvarchar(max) output
AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'OrderId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(max)


SET @sql = '(select cast ((SELECT  ''true'' AS [@json:Array]  ,
	   o.[OrderId] as IntOrderId
      ,o.[OrderNumber]
      ,o.[EnquiryId]
      ,o.[ExpectedTimeOfDelivery]
      ,o.[CarrierETA]
      ,o.[CarrierETD]
      ,o.[OrderDate]
      ,o.[TruckSizeId]
      , o.[SoldTo] 
      ,o.[ShipTo] 
	  ,dl.LocationCode  as  ShipToCode
	  ,dl.LocationName  as ShipToName
	  ,(Isnull(dl.AddressLine1,''-'') +'' ''+ Isnull(dl.AddressLine2,''-'')+'' ''+Isnull(dl.AddressLine3,''-'')) as ShipToAddress
	  ,ISNULL(c.Field6,'''') as PresellerCode
	  ,ISNuLL((select  top 1 Name   From Profile  where driverid=c.Field6),'''') as PresellerName
	  ,ISNULL((select  top 1 ContactNumber   From Profile  where driverid=c.Field6),'''') as SalesmandPhone
      ,o.[PrimaryAddressId]
      ,o.[SecondaryAddressId]
      ,o.[PrimaryAddress]
      ,o.[SecondaryAddress]
      ,o.[ModeOfDelivery]
      ,o.[OrderType]
      ,o.[PurchaseOrderNumber]
      ,o.[SalesOrderNumber]
      ,o.[PickNumber]
      ,o.[Remarks]
      ,o.[PreviousState]
      ,o.[CurrentState]
      ,o.[NextState]
	  ,ISNULL((Select top 1 tid.TruckInDeatilsId from TruckInDeatils tid join TruckInOrder tio on tid.TruckInDeatilsId=tio.TruckInDeatilsId where tio.OrderNumber=o.[OrderNumber] and tid.IsActive=1),0) as TruckInDeatilsId
	  ,(select top 1 GroupName from OrderMovement where OrderId = o.[OrderId] and LocationType = 2) as DeliveryGroupNumber
	  ,(select top 1 GroupName from OrderMovement where OrderId = o.[OrderId] and LocationType = 1) as CollectionGroupNumber
	  ,(select top 1 PlanNumber from OrderMovement where OrderId = o.[OrderId] and LocationType = 1) as CollectionPlanNumber
	  ,(select top 1 PlanNumber from OrderMovement where OrderId = o.[OrderId] and LocationType = 2) as DeliveryPlanNumber
	  ,Case when (select COUNT(*) from OrderMovement where OrderId = o.[OrderId] and LocationType = 2 and (ActualTimeOfAction is not null Or ActualTimeOfAction = ''''))  > 0 then 1 else 0 end as IsCompleted
      ,o.[IsRecievingLocationCapacityExceed]
      ,o.[IsPickConfirmed]
      ,o.[IsPrintPickSlip]
      ,o.[IsSTOTUpdated]
      ,o.[SequenceNo]
      ,o.[StockLocationId]
      ,o.[CarrierNumber]
      ,o.[PalletSpace]
      ,o.[NumberOfPalettes]
	  ,o.[PaymentTerm] as PaymentTerm
      ,o.[TruckWeight]
      ,o.[Description1]
      ,o.[Description2]
      ,o.[OrderedBy]
      ,o.[GratisCode]
      ,o.[Province]
      ,o.[LoadNumber]
      ,o.[ReferenceNumber]
	  ,Isnull(o.DiscountAmount,0) as DiscountAmount
	  ,isnull((Select top 1 SettingValue from SettingMaster where SettingParameter=''ItemTaxInPec''),0) as ItemTaxInPec
	  ,c.CompanyName
	  ,c.CompanyMnemonic
	  ,c.CreditLimit
	  ,c.AvailableCreditLimit
	  ,isnull(c.TaxId , ''-'')  as  TaxId
	  ,(ISNULL(c.CreditLimit,0) - ISNULL(c.AvailableCreditLimit,0)) as AR
	  ,(Isnull(c.AddressLine1,''-'') +'' ''+ Isnull(c.AddressLine2,''-'')+'' ''+Isnull(c.AddressLine3,''-'')) as CustomerAddress
	  ,c.BillTo
	  ,(select cast ((SELECT  ''true'' AS [@json:Array],1221 as ObjectType, 
	  ISNULL(DiscountAmount,0) as DiscountAmount,
	  ISNULL(DiscountPercent,0) as DiscountPercent
	 
	  FOR XML path(''OrderDiscountList''),ELEMENTS) AS xml))

	   FROM [Order] o join Company c on o.SoldTo=c.CompanyId
	    join [Location]  dl on dl.LocationId =o.ShipTo
	   WHERE o.IsActive = 1 and ' + @WhereExpression + '
	   ORDER BY ' + @SortExpression  + '
	   FOR XML PATH(''AsnInfos''),ELEMENTS)AS XML))'
 


 
 SET @Output=@sql
 PRINT @sql
 PRINT 'Executed SSP_OrderList_SelectByCriteria'
 --PRINT @Output
 -- Execute the SQL query
--EXEC sp_executesql @sql

 
 ----[dbo].[SSP_OrderProductList_SelectByCriteria] 'ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 41 AND ActualTimeOfAction IS  NULL)','',dfd
