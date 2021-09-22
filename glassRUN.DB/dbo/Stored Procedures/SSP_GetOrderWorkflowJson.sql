CREATE PROCEDURE [dbo].[SSP_GetOrderWorkflowJson]  --'ORDERID IN (SELECT ORDERID FROM ORDERMOVEMENT WHERE [DeliveryPersonnelId] = 508 AND GroupName in (select GroupName From OrderMovement where ActualTimeOfAction is  null))','',''

@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'OrderId',
@Output nvarchar(max) output


AS


--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'OrderId' END


-- ISSUE QUERY
DECLARE @sql nvarchar(max)
DECLARE @sql1 nvarchar(max)
DECLARE @sql2 nvarchar(max)
DECLARE @sql3 nvarchar(max)
Declare @sql4 nvarchar(max)

SET @sql = '
(SELECT CAST((select ''true'' AS [@json:Array] ,
o.OrderId,o.OrderNumber,
   (select cast ((SELECT  OrderId,  OrderNumber , OrderType  ,  SoldToCode  , SoldToName   , ShipToCode   ,ShipToName  , PickDateTime  ,ExpectedTimeOfDelivery  , CONVERT(VARCHAR(20),  o.OrderDate, 103)  as   OrderDate   ,  CONVERT(VARCHAR(5), o.OrderDate,108)   as   OrderTime , PurchaseOrderNumber , SalesOrderNumber ,
Stock.LocationCode  as ''CollectionCode''  , stock.LocationName  as ''CollectionName'',stock.Pincode  as ''CollectionPinCode'' , (select    top 1  StateName From State  where StateId=stock.State)  as ''CollectionStateName'',
shipTo.LocationCode  as ''DeliveryCode''  , shipTo.LocationName  as ''DeliveryName'',shipTo.Pincode  as ''DeliveryPinCode'' , (select    top 1  StateName From State  where StateId=shipTo.State)  as ''DeliveryStateName'',
 CurrentState    , carrier.CompanyMnemonic  as ''CarrierCode''  , carrier.CompanyName  as ''CarrierName''  
       From  [order]   ord   left join  location stock  on ord.StockLocationId = stock.LocationCode 
	   left join  Location shipTo  on shipTo.LocationId =ord.ShipTo  
	   left join Company  carrier on carrier.CompanyId=ord.CompanyId  where  ord.ORDERID  = o.OrderId
 FOR XML path(''Order''),ELEMENTS) AS xml)) ,
  (select cast ((SELECT  *,(select OrderNumber from [Order] where ORDERID = o.OrderId) as OrderNumber
    from   OrderProduct  where ORDERID = o.OrderId
 FOR XML path(''OrderProduct''),ELEMENTS) AS xml)) ,'

 SET @sql4 = '
 (select cast ((Select Top 1 
 (select OrderNumber from [Order] where ORDERID = o.OrderId) as OrderNumber,
      [CompanyId]
      ,[CompanyName]
      ,[CompanyMnemonic]
      ,(SELECT [dbo].[fn_LookupValueById] ([CompanyType])) as [CompanyType]
      ,[ParentCompany]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId]
      ,[Country]
      ,[Postcode]
      ,[Region]
      ,[RouteCode]
      ,[ZoneCode]
      ,[CategoryCode]
      ,[BranchPlant]
      ,[Email]
      ,[TaxId]
      ,[SoldTo]
      ,[ShipTo]
      ,[BillTo]
	  ,(select top 1 zc.ZoneCode from ZoneCode zc where zc.CompanyId=[Customer].CompanyId) as ZoneCode
	   ,(select top 1 zc.ZoneName from ZoneCode zc where zc.CompanyId=[Customer].CompanyId) as ZoneName
      ,[ContactPersonNumber]
      ,[ContactPersonName]
          ,[header]
      ,[footer]
	        ,[SequenceNo]
      ,[SubChannel]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[CreditLimit]
      ,[AvailableCreditLimit]
      ,[EmptiesLimit]
      ,[ActualEmpties]
      ,[PaymentTermCode]
      ,[CategoryType] 
       from Company [Customer] Where [Customer].CompanyId= (select CompanyId from [Order] where ORDERID = o.OrderId)
 FOR XML path(''Supplier''),ELEMENTS) AS xml)) ,
  '
 set @sql1 = '
  (select cast ((Select Top 1 
  (select OrderNumber from [Order] where ORDERID = o.OrderId) as OrderNumber,
      [CompanyId]
      ,[CompanyName]
      ,[CompanyMnemonic]
      ,(SELECT [dbo].[fn_LookupValueById] ([CompanyType])) as [CompanyType]
      ,[ParentCompany]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId]
      ,[Country]
      ,[Postcode]
      ,[Region]
      ,[RouteCode]
      ,[ZoneCode]
      ,[CategoryCode]
      ,[BranchPlant]
      ,[Email]
      ,[TaxId]
      ,[SoldTo]
      ,[ShipTo]
      ,[BillTo]
     ,(select top 1 zc.ZoneCode from ZoneCode zc where zc.CompanyId=Supplier.CompanyId) as ZoneCode
	   ,(select top 1 zc.ZoneName from ZoneCode zc where zc.CompanyId=Supplier.CompanyId) as ZoneName
      ,[ContactPersonNumber]
      ,[ContactPersonName]
	        ,[header]
      ,[footer]
          ,[SequenceNo]
      ,[SubChannel]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[CreditLimit]
      ,[AvailableCreditLimit]
      ,[EmptiesLimit]
      ,[ActualEmpties]
      ,[PaymentTermCode]
      ,[CategoryType]
       from Company [Supplier] Where [Supplier].CompanyId in (select SoldTo from [Order] where ORDERID = o.OrderId)
 FOR XML path(''SoldTo''),ELEMENTS) AS xml)) ,
 '
 set @sql2 = '
  (select cast ((Select Top 1*,
  (select OrderNumber from [Order] where ORDERID = o.OrderId) as OrderNumber
      ,(SELECT [dbo].[fn_LookupValueById] ([LocationType])) as[LocationType]
      ,(Select top 1 PCL.LocationName from [Location] PCL where PCL.LocationId=CollectionLocation.Parentid) as [ParentLocationName]
	  ,(Select top 1 PCL.LocationCode from [Location] PCL where PCL.LocationId=CollectionLocation.Parentid) as [ParentLocationCode]
      from [Location] [CollectionLocation]  Where [CollectionLocation].LocationCode in (select StockLocationId from [Order] where ORDERID = o.OrderId)
 FOR XML path(''CollectionLocation''),ELEMENTS) AS xml)) ,
  '
 set @sql3 = '
(select cast ((Select Top 1 *,
(select OrderNumber from [Order] where ORDERID = o.OrderId) as OrderNumber,
      (SELECT [dbo].[fn_LookupValueById] ([LocationType])) as[LocationType]
      ,(Select top 1 PCL.LocationName from [Location] PCL where PCL.LocationId=DeliveryLocation.Parentid) as [ParentLocationName]
	  ,(Select top 1 PCL.LocationCode from [Location] PCL where PCL.LocationId=DeliveryLocation.Parentid) as [ParentLocationCode]
      ,[BillType] from [Location] [DeliveryLocation]  Where [DeliveryLocation].LocationCode in (select ShipTo from [Order] where ORDERID = o.OrderId)
 FOR XML path(''DeliveryLocation''),ELEMENTS) AS xml)),
(select cast ((SELECT top 1 [TruckSizeId]
      ,(SELECT [dbo].[fn_LookupValueById] ([VehicleType])) as [VehicleType]
     
  FROM [dbo].[TruckSize] where TruckSizeId  in (select TruckSizeId from [Order] where ORDERID  = o.OrderId) 
  FOR XML path(''TruckSize''),ELEMENTS) AS xml))

  FROM [dbo].[Order] o where ' + @WhereExpression + '

 FOR XML PATH(''OrderWorkflowJson''),ELEMENTS)AS XML))'

 
 
 SET @Output=@sql + @sql4 + @sql1 + @sql2 + @sql3  
 
 PRINT @Output

 PRINT @sql + @sql4 + @sql1 + @sql2 + @sql3  

 PRINT 'Executed SSP_OrderMovementList_SelectByCriteria'
