CREATE PROCEDURE [dbo].[SSP_PlateNumberAllocation_Paging] --'<Json><ServicesAction>LoadSoNumberWiseDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><SalesOrderNumber></SalesOrderNumber><SalesOrderNumberCriteria></SalesOrderNumberCriteria><SoldTo></SoldTo><SoldToCriteria></SoldToCriteria><ShipTo></ShipTo><ShipToCriteria></ShipToCriteria><TruckSize></TruckSize><TruckSizeCriteria></TruckSizeCriteria><Carrier></Carrier><CarrierCriteria></CarrierCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><LoginId>6</LoginId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)


DECLARE @SalesOrderNumber nvarchar(150)
DECLARE @SalesOrderNumberCriteria nvarchar(150)
DECLARE @BranchPlant nvarchar(150)
DECLARE @BranchPlantCriteria nvarchar(150)
DECLARE @ShipTo nvarchar(150)
DECLARE @ShipToCriteria nvarchar(150)
DECLARE @TruckSize nvarchar(150)
DECLARE @TruckSizeCriteria nvarchar(150)
Declare @OrderType nvarchar(50)
Declare @LoginId nvarchar(50)


set  @whereClause =''




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @SalesOrderNumber = tmp.[SalesOrderNumber],
	   @SalesOrderNumberCriteria = tmp.[SalesOrderNumberCriteria],
	   @BranchPlant = tmp.[BranchPlant],
	   @BranchPlantCriteria = tmp.[BranchPlantCriteria],
	   @ShipTo = tmp.[ShipTo],
	   @ShipToCriteria = tmp.[ShipToCriteria],	 
	    @TruckSize = tmp.[TruckSize],
	   @TruckSizeCriteria = tmp.[TruckSizeCriteria],	  
	   @PageSize = tmp.[PageSize],
	   @PageIndex = tmp.[PageIndex],
	   @OrderBy = tmp.[OrderBy],
	   @OrderType=tmp.[OrderType],
	   @LoginId = tmp.[LoginId]
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000),
			[SalesOrderNumber] nvarchar(150),
			[SalesOrderNumberCriteria] nvarchar(50),
			[BranchPlant] nvarchar(150),
			[BranchPlantCriteria] nvarchar(50),
			[ShipTo] nvarchar(150),
			[ShipToCriteria] nvarchar(50),
           	[TruckSize] nvarchar(50),
			[TruckSizeCriteria] nvarchar(50),
			[OrderType] nvarchar(50),
			[LoginId] nvarchar(50)
			)tmp




		


IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'OrderDate desc' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

IF @SalesOrderNumber !=''
BEGIN

  IF @SalesOrderNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SalesOrderNumber LIKE ''%' + @SalesOrderNumber + '%'''
  END
  IF @SalesOrderNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SalesOrderNumber NOT LIKE ''%' + @SalesOrderNumber + '%'''
  END
  IF @SalesOrderNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SalesOrderNumber LIKE ''' + @SalesOrderNumber + '%'''
  END
  IF @SalesOrderNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SalesOrderNumber LIKE ''%' + @SalesOrderNumber + ''''
  END          
  IF @SalesOrderNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and SalesOrderNumber =  ''' +@SalesOrderNumber+ ''''
  END
  IF @SalesOrderNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and SalesOrderNumber <>  ''' +@SalesOrderNumber+ ''''
  END
END

IF @BranchPlant !=''
BEGIN

  IF @BranchPlantCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant NOT LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant LIKE ''' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant LIKE ''%' + @BranchPlant + ''''
  END          
  IF @BranchPlantCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and BranchPlant =  ''' +@BranchPlant+ ''''
  END
  IF @BranchPlantCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and BranchPlant <>  ''' +@BranchPlant+ ''''
  END
END


IF @ShipTo !=''
BEGIN

  IF @ShipToCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipTo LIKE ''%' + @ShipTo + '%'''
  END
  IF @ShipToCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipTo NOT LIKE ''%' + @ShipTo + '%'''
  END
  IF @ShipToCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipTo LIKE ''' + @ShipTo + '%'''
  END
  IF @ShipToCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipTo LIKE ''%' + @ShipTo + ''''
  END          
  IF @ShipToCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ShipTo =  ''' +@ShipTo+ ''''
  END
  IF @ShipToCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ShipTo <>  ''' +@ShipTo+ ''''
  END
END

IF @TruckSize !=''
BEGIN

  IF @TruckSizeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipTo LIKE ''%' + @TruckSize + '%'''
  END
  IF @TruckSizeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipTo NOT LIKE ''%' + @TruckSize + '%'''
  END
  IF @TruckSizeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipTo LIKE ''' + @TruckSize + '%'''
  END
  IF @TruckSizeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipTo LIKE ''%' + @TruckSize + ''''
  END          
  IF @TruckSizeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ShipTo =  ''' +@TruckSize+ ''''
  END
  IF @TruckSizeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ShipTo <>  ''' +@TruckSize+ ''''
  END
END




SET @whereClause = @whereClause + 'and o.OrderType not in (''SG'',''S5'',''S6'') and o.SalesOrderNumber is not null '
--(SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause] (@LoginId,'SSP_OrderGrid_Paging')) +''





	SET @sql = ' WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT   ''true'' AS [@json:Array] , * from (select TotalCount,rownumber,
SalesOrderNumber,
ShipTo,
case when LEN(ShipTo)>15 then LEFT(ShipTo, 15)+ ''...'' else ShipTo end as DeliveryLocation ,
case when LEN(SoldTo)>15 then LEFT(SoldTo, 15)+ ''...'' else SoldTo end as SoldTo ,CarrierNumber
,ReceivedCapacityPalettes,
convert(bigint,Capacity) as Capacity

,TruckSize,TruckSizeData ,TruckCapacityWeight,TruckSizeValue,
				ExpectedTimeOfDelivery,CurrentState,Status, AssociatedOrder , PickingDate as PickingDate,PlateNumber
				,BranchPlant,OrderDate,Field4,PraposedTimeOfAction,PraposedShift,ExpectedTimeOfAction,ExpectedShift
				 FROM (SELECT COUNT(SalesOrderNumber) OVER () as TotalCount,
	ROW_NUMBER() OVER (ORDER BY [OrderId]) as rownumber, SalesOrderNumber,
				 dl.DeliveryLocationName AS ShipTo,
				 	 dl.Capacity,
					 	((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (o.ExpectedTimeOfDelivery,o.ShipTo,o.SoldTo,ISNULL(CONVERT(bigint,dl.Capacity),0)))) as ReceivedCapacityPalettes,
				 dlSold.DeliveryLocationName AS SoldTo,	
	(select CompanyMnemonic from Company where CompanyId in (select CarrierNumber from [Order] where OrderId=o.OrderId)) as CarrierNumber,
	ts.TruckSize +''''+  '' ('' + Convert(nvarchar(500),ISNULL(o.TruckWeight,0)) + '' / '' + Convert(nvarchar(500),ISNULL(ts.TruckCapacityWeight,0)) + '')''  as TruckSize,
	'' ('' + Convert(nvarchar(500),ISNULL(o.TruckWeight,0)) + '' / '' + Convert(nvarchar(500),ISNULL(ts.TruckCapacityWeight,0)) + '')T''  as TruckSizeData,
	ts.TruckCapacityWeight as TruckCapacityWeight,
	ts.TruckSize  as TruckSizeValue
	
	,CONVERT(varchar(11),o.ExpectedTimeOfDelivery,103) as ExpectedTimeOfDelivery,
	o.CurrentState,
	(SELECT [dbo].[fn_LookupValueById] (o.CurrentState)) AS ''Status'',
	--(select ( select SalesOrderNumber from [order] where orderId in ( select top 1 AssociatedOrder from [OrderProduct] op where OrderId = o.OrderId and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0))) AS AssociatedOrder
	(Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]   where IsActive=1 and orderId in ( select top 1 AssociatedOrder from [OrderProduct] op where OrderId = o.OrderId and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))) as AssociatedOrder
	,(SELECT top 1 ExpectedTimeOfAction FROM OrderMovement Where LocationType=1 and OrderId=o.OrderId) AS PickingDate
	 ,(SELECT top 1 TruckPlateNumber FROM orderlogistics WHERE ordermovementid IN (SELECT OrderMovementId FROM OrderMovement WHERE OrderId=o.OrderId AND LocationType=1)) AS PlateNumber
	, (Select top 1 DeliveryLocationCode from Deliverylocation where DeliveryLocationCode=o.StockLocationId) as BranchPlant
	,o.OrderDate
	,o.Field4
	,(select PraposedTimeOfAction from ordermovement where OrderId=o.orderId) as PraposedTimeOfAction
	,(select PraposedShift from ordermovement where OrderId=o.orderId) as PraposedShift
	,(select ExpectedTimeOfAction from ordermovement where OrderId=o.orderId) as ExpectedTimeOfAction
	,(select ExpectedShift from ordermovement where OrderId=o.orderId) as ExpectedShift
 FROM dbo.[Order] o left JOIN dbo.DeliveryLocation dl ON dl.DeliveryLocationId=o.ShipTo 
 left JOIN dbo.DeliveryLocation dlSold ON dlSold.DeliveryLocationId=o.ShipTo
 left JOIN dbo.TruckSize ts ON ts.TruckSizeId=o.TruckSizeId 
				WHERE o.IsActive = 1 and ' + @whereClause +' GROUP BY SalesOrderNumber,o.ShipTo,o.SoldTo,dl.Capacity,dlSold.DeliveryLocationName,dl.DeliveryLocationName,o.TruckWeight ,ts.TruckCapacityWeight,
				 TruckSize,ExpectedTimeOfDelivery,CurrentState,o.OrderId,o.StockLocationId,o.OrderDate,o.Field4) as d  ) tmp
   WHERE '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+' 
   
   FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'




	PRINT @sql
	--SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
	EXEC sp_executesql @sql

END