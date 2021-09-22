CREATE PROCEDURE [dbo].[SSP_CustomerServiceOrderDetails_Paging] --'<Json><ServicesAction>LoadCustomerServiceOrderDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><SalesOrderNumber></SalesOrderNumber><SalesOrderNumberCriteria></SalesOrderNumberCriteria><CompanyNameValue></CompanyNameValue><CompanyNameValueCriteria></CompanyNameValueCriteria><PurchaseOrderNumber></PurchaseOrderNumber><PurchaseOrderNumberCriteria></PurchaseOrderNumberCriteria><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><DeliveryLocation></DeliveryLocation><DeliveryLocationCriteria></DeliveryLocationCriteria><Gratis></Gratis><GratisCriteria></GratisCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><Status></Status><StatusCriteria></StatusCriteria><OrderType></OrderType><OrderDate></OrderDate><OrderDateCriteria></OrderDateCriteria><RoleMasterId>4</RoleMasterId><CultureId>1101</CultureId><ProductCode></ProductCode><ProductSearchCriteria></ProductSearchCriteria><UserId>592</UserId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(max)
Declare @sql nvarchar(max)
Declare @sql1 nvarchar(max)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
DECLARE @roleId bigint
Declare @userId bigint

Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(50)

DECLARE @SalesOrderNumber nvarchar(150)
DECLARE @SalesOrderNumberCriteria nvarchar(50)

DECLARE @PurchaseOrderNumber nvarchar(150)
DECLARE @PurchaseOrderNumberCriteria nvarchar(50)

DECLARE @EnquiryAutoNumber nvarchar(150)
DECLARE @EnquiryAutoNumberCriteria nvarchar(50)


DECLARE @BranchPlant nvarchar(150)
DECLARE @BranchPlantCriteria nvarchar(50)

DECLARE @Gratis nvarchar(150)
DECLARE @GratisCriteria nvarchar(50)

DECLARE @DeliveryLocation nvarchar(150)
DECLARE @DeliveryLocationCriteria nvarchar(50)

DECLARE @Status nvarchar(150)
DECLARE @StatusCriteria nvarchar(50)


DECLARE @SchedulingDate nvarchar(150)
DECLARE @SchedulingDateCriteria nvarchar(50)


DECLARE @OrderType nvarchar(150)


DECLARE @OrderDate nvarchar(150)
DECLARE @OrderDateCriteria nvarchar(50)

DECLARE @CompanyNameValue nvarchar(150)
DECLARE @CompanyNameValueCriteria nvarchar(50)

DECLARE @UserName nvarchar(150)
DECLARE @UserNameCriteria nvarchar(50)

DECLARE @Empties nvarchar(150)
DECLARE @EmptiesCriteria nvarchar(50)

Declare @CultureId bigint

DECLARE @ReceivedCapacityPalates nvarchar(150)
DECLARE @ReceivedCapacityPalatesCriteria nvarchar(50)


DECLARE @ProductCode nvarchar(max)

DECLARE @ProductSearchCriteria nvarchar(100)

set  @whereClause =''




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @SalesOrderNumber = tmp.[SalesOrderNumber],
    @SalesOrderNumberCriteria = tmp.[SalesOrderNumberCriteria],
	@PurchaseOrderNumber = tmp.[PurchaseOrderNumber],
	@PurchaseOrderNumberCriteria = tmp.[PurchaseOrderNumberCriteria],
	@EnquiryAutoNumber = tmp.[EnquiryAutoNumber],
    @EnquiryAutoNumberCriteria = tmp.[EnquiryAutoNumberCriteria],
	@BranchPlant = tmp.[BranchPlant],
    @BranchPlantCriteria = tmp.[BranchPlantCriteria],
	  @DeliveryLocation = tmp.[DeliveryLocation],
	   @DeliveryLocationCriteria = tmp.[DeliveryLocationCriteria],
	     @Gratis = tmp.[Gratis],
	   @GratisCriteria = tmp.[GratisCriteria],
	   @Status = tmp.[Status],
	   @StatusCriteria = tmp.[StatusCriteria],
	     @SchedulingDate = tmp.[SchedulingDate],
	   @SchedulingDateCriteria = tmp.[SchedulingDateCriteria],
	   @OrderType = tmp.[OrderType],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@roleId = tmp.[RoleMasterId],
	@OrderDate = tmp.[OrderDate],
	   @OrderDateCriteria = tmp.[OrderDateCriteria],
	   @CompanyNameValue = tmp.[CompanyNameValue],
	@CompanyNameValueCriteria = tmp.[CompanyNameValueCriteria],
   @ProductCode = [ProductCode],
   @ProductSearchCriteria = [ProductSearchCriteria],
    @UserName = [UserName],
   @UserNameCriteria = [UserNameCriteria],
   @Empties=tmp.[Empties],
   @CultureId = [CultureId],
   	@EmptiesCriteria=tmp.[EmptiesCriteria],
   @ReceivedCapacityPalates=tmp.[ReceivedCapacityPalates],
   	@ReceivedCapacityPalatesCriteria=tmp.[ReceivedCapacityPalatesCriteria],
   @userId = tmp.[UserId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [SalesOrderNumber] nvarchar(150),
   [SalesOrderNumberCriteria] nvarchar(50),
		 [PurchaseOrderNumber] nvarchar(150),
		 [PurchaseOrderNumberCriteria] nvarchar(50),
      [EnquiryAutoNumber] nvarchar(150),
   [EnquiryAutoNumberCriteria] nvarchar(50),
    [BranchPlant]  nvarchar(150),
   [BranchPlantCriteria] nvarchar(50),
   	[DeliveryLocation] nvarchar(150),
            [DeliveryLocationCriteria] nvarchar(50),
			[SchedulingDate] nvarchar(150),
            [SchedulingDateCriteria] nvarchar(50),
			[OrderType] nvarchar(50),
			[Gratis] nvarchar(150),
            [GratisCriteria] nvarchar(50),
			[Status] nvarchar(150),
            [StatusCriteria] nvarchar(50),
				[RoleMasterId] bigint,
			[OrderDate] nvarchar(150),
            [OrderDateCriteria] nvarchar(50),
			 [CompanyNameValue]  nvarchar(150),
   [CompanyNameValueCriteria] nvarchar(50),
   [UserName] nvarchar(150),
            [UserNameCriteria] nvarchar(50),
   [ProductCode] nvarchar(500),
   [ProductSearchCriteria] nvarchar(100),
   [Empties] nvarchar(150),
   [CultureId] bigint,
	[EmptiesCriteria] nvarchar(150),
   [ReceivedCapacityPalates] nvarchar(150),
	[ReceivedCapacityPalatesCriteria] nvarchar(150),
   [UserId] bigint
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'PraposedTimeOfAction desc' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF (@ProductCode IS NOT NULL)
 BEGIN 
 	SET @ProductCode = @ProductCode
	Set @ProductSearchCriteria = @ProductSearchCriteria
  END
Else 
BEGIN 
	SET @ProductCode = ''''
	Set @ProductSearchCriteria = ''''
  END



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

IF @Empties !=''
BEGIN
 SET @whereClause = @whereClause + ' and (case when (c.ActualEmpties < 0) then ''C'' else ''W'' end) =  ''' +@Empties+ ''''
END

IF @ReceivedCapacityPalates !=''
BEGIN
 SET @whereClause = @whereClause + ' and (case when ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ExpectedTimeOfDelivery,o.ShipTo,o.SoldTo,ISNULL(CONVERT(bigint,Capacity),0))) < 0) then ''0'' else ''1'' end) =  ''' +@ReceivedCapacityPalates+ ''''
END


IF @PurchaseOrderNumber !=''
BEGIN

  IF @PurchaseOrderNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PurchaseOrderNumber LIKE ''%' + @PurchaseOrderNumber + '%'''
  END
  IF @PurchaseOrderNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PurchaseOrderNumber NOT LIKE ''%' + @PurchaseOrderNumber + '%'''
  END
  IF @PurchaseOrderNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PurchaseOrderNumber LIKE ''' + @PurchaseOrderNumber + '%'''
  END
  IF @PurchaseOrderNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PurchaseOrderNumber LIKE ''%' + @PurchaseOrderNumber + ''''
  END          
  IF @PurchaseOrderNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and PurchaseOrderNumber =  ''' +@PurchaseOrderNumber+ ''''
  END
  IF @PurchaseOrderNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and PurchaseOrderNumber <>  ''' +@PurchaseOrderNumber+ ''''
  END
END

IF @EnquiryAutoNumber !=''
BEGIN

  IF @EnquiryAutoNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 EnquiryAutoNumber from Enquiry where EnquiryId = o.EnquiryId) LIKE ''%' + @EnquiryAutoNumber + '%'''
  END
  IF @EnquiryAutoNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 EnquiryAutoNumber from Enquiry where EnquiryId = o.EnquiryId) NOT LIKE ''%' + @EnquiryAutoNumber + '%'''
  END
  IF @EnquiryAutoNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 EnquiryAutoNumber from Enquiry where EnquiryId = o.EnquiryId) LIKE ''' + @EnquiryAutoNumber + '%'''
  END
  IF @EnquiryAutoNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 EnquiryAutoNumber from Enquiry where EnquiryId = o.EnquiryId) LIKE ''%' + @EnquiryAutoNumber + ''''
  END          
  IF @EnquiryAutoNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 EnquiryAutoNumber from Enquiry where EnquiryId = o.EnquiryId) =  ''' +@EnquiryAutoNumber+ ''''
  END
  IF @EnquiryAutoNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 EnquiryAutoNumber from Enquiry where EnquiryId = o.EnquiryId) <>  ''' +@EnquiryAutoNumber+ ''''
  END
END

IF @BranchPlant !=''
BEGIN

  IF @BranchPlantCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.StockLocationId LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.StockLocationId NOT LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.StockLocationId LIKE ''' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.StockLocationId LIKE ''%' + @BranchPlant + ''''
  END          
  IF @BranchPlantCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and o.StockLocationId =  ''' +@BranchPlant+ ''''
  END
  IF @BranchPlantCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and BranchPlantName <>  ''' +@BranchPlant+ ''''
  END
END

IF @DeliveryLocation !=''
BEGIN

  IF @DeliveryLocationCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''%' + @DeliveryLocation + '%'''
  END
  IF @DeliveryLocationCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode NOT LIKE ''%' + @DeliveryLocation + '%'''
  END
  IF @DeliveryLocationCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''' + @DeliveryLocation + '%'''
  END
  IF @DeliveryLocationCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''%' + @DeliveryLocation + ''''
  END          
  IF @DeliveryLocationCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationCode =  ''' + @DeliveryLocation + ''''
  END
  IF @DeliveryLocationCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationCode <>  ''' + @DeliveryLocation + ''''
  END
END

IF @Status !=''
BEGIN
          
  IF @StatusCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',o.CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) =  ''' + @Status + ''''
  END
  
END

IF @Gratis !=''
BEGIN

  IF @GratisCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AssociatedOrder LIKE ''%' + @Gratis + '%'''
  END
  IF @GratisCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AssociatedOrder NOT LIKE ''%' + @Gratis + '%'''
  END
  IF @GratisCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AssociatedOrder LIKE ''' + @Gratis + '%'''
  END
  IF @GratisCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AssociatedOrder LIKE ''%' + @Gratis + ''''
  END          
  IF @GratisCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and AssociatedOrder =  ''' + @Gratis + ''''
  END
  IF @GratisCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and AssociatedOrder <>  ''' + @Gratis + ''''
  END
END

IF @SchedulingDate !=''
BEGIN

  IF @SchedulingDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ExpectedTimeOfDelivery LIKE ''%' + @SchedulingDate + '%'''
  END
  IF @SchedulingDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ExpectedTimeOfDelivery NOT LIKE ''%' + @SchedulingDate + '%'''
  END
  IF @SchedulingDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ExpectedTimeOfDelivery LIKE ''' + @SchedulingDate + '%'''
  END
  IF @SchedulingDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ExpectedTimeOfDelivery LIKE ''%' + @SchedulingDate + ''''
  END          
  IF @SchedulingDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),ExpectedTimeOfDelivery,103) =  ''' + CONVERT(varchar(11),@SchedulingDate,103) + ''''
  END
  IF @SchedulingDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ExpectedTimeOfDelivery <>  ''' + @SchedulingDate + ''''
  END
END

IF @OrderDate !=''
BEGIN

  IF @OrderDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderDate LIKE ''%' + @OrderDate + '%'''
  END
  IF @OrderDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderDate NOT LIKE ''%' + @OrderDate + '%'''
  END
  IF @OrderDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderDate LIKE ''' + @OrderDate + '%'''
  END
  IF @OrderDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderDate LIKE ''%' + @OrderDate + ''''
  END          
  IF @OrderDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),OrderDate,103) =  ''' + CONVERT(varchar(11),@OrderDate,103) + ''''
  END
  IF @OrderDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and OrderDate <>  ''' + @OrderDate + ''''
  END
END

IF @CompanyNameValue !=''
BEGIN

  IF @CompanyNameValueCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0))='''' then SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5) else isnull(SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0)),SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5)) end LIKE ''%' + @CompanyNameValue + '%'''
  END
  IF @CompanyNameValueCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0))='''' then SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5) else isnull(SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0)),SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5)) end NOT LIKE ''%' + @CompanyNameValue + '%'''
  END
  IF @CompanyNameValueCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0))='''' then SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5) else isnull(SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0)),SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5)) end LIKE ''' + @CompanyNameValue + '%'''
  END
  IF @CompanyNameValueCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0))='''' then SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5) else isnull(SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0)),SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5)) end LIKE ''%' + @CompanyNameValue + ''''
  END          
  IF @CompanyNameValueCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and case when SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0))='''' then SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5) else isnull(SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0)),SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5)) end =  ''' +@CompanyNameValue+ ''''
  END
  IF @CompanyNameValueCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and case when SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0))='''' then SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5) else isnull(SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0)),SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5)) end <>  ''' +@CompanyNameValue+ ''''
  END
END


IF @UserName !=''
BEGIN

  IF @UserNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = o.CreatedBy) LIKE ''%' + @UserName + '%'''
  END
  IF @UserNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = o.CreatedBy) NOT LIKE ''%' + @UserName + '%'''
  END
  IF @UserNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = o.CreatedBy) LIKE ''' + @UserName + '%'''
  END
  IF @UserNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = o.CreatedBy) LIKE ''%' + @UserName + ''''
  END          
  IF @UserNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = o.CreatedBy) =  ''' +@UserName+ ''''
  END
  IF @UserNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = o.CreatedBy) <>  ''' +@UserName+ ''''
  END
END


IF @ProductCode != ''
Begin 
	if @ProductSearchCriteria = 'Include'
		Begin
			SET @whereClause = @whereClause + 'and o.OrderId in (SELECT OrderId FROM OrderProduct WHERE ProductCode IN (SELECT * FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')) GROUP BY OrderId HAVING COUNT(*) >= (SELECT COUNT(*) FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')))'
		ENd
	Else
		Begin
			SET @whereClause = @whereClause + 'and o.OrderId not in (SELECT OrderId FROM OrderProduct WHERE ProductCode IN (SELECT * FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')) GROUP BY OrderId HAVING COUNT(*) >= (SELECT COUNT(*) FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')))'
		ENd
End



IF @OrderType = 'Gratis Order'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderType in (''SG'',''S5'',''S6'')'
  END
IF @OrderType = 'Regular Order'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (OrderType not in (''SG'',''S5'',''S6'') or OrderType is NULL)'
  END
 
if @roleId=4
BEGIN
Print @roleId
SET @whereClause = @whereClause + ' and  o.SoldTo = ' + CONVERT(NVARCHAR(10), @userId)+''
END




SET @orderBy = 'PraposedTimeOfAction desc'



 SET @sql = ' WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((select  ''true'' AS [@json:Array],tmp.OrderId,tmp.OrderType,
 rownumber,TotalCount, tmp.OrderNumber,
 HoldStatus,
 ISNULL(TotalPrice,0) as TotalPrice,
  tmp.SalesOrderNumber,
  PurchaseOrderNumber,
  PraposedShift,
  CONVERT(varchar(11),PraposedTimeOfAction,103) as PraposedTimeOfAction,
  OrderDate,
  DeliveryLocationName,
  case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end as DeliveryLocation ,
  CompanyName,
  UserName,
CONVERT(varchar(11),tmp.ExpectedTimeOfDelivery,103) as ExpectedTimeOfDelivery,
   (SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ExpectedTimeOfDelivery,ShipTo,SoldTo,ISNULL(CONVERT(bigint,Capacity),0))) as ReceivedCapacityPalettes,
     ISNULL(CONVERT(bigint,Capacity),0) as Capacity,
EnquiryAutoNumber,
  Remarks,
  CurrentState,
  Status,
  Class,
  CONVERT(XML,enquiryProduct) ,
  ShipTo,
  SoldTo,  
    ReceivedCapacityPalettesCheck,
  PrimaryAddressId
    ,[SecondaryAddressId]
      ,[PrimaryAddress]
      ,[SecondaryAddress]    
     ,StockLocationId,
	 BranchPlantName,
	 Empties,
	 IsNull(EmptiesLimit,0) as EmptiesLimit,
   IsNull(ActualEmpties,0) as ActualEmpties, 
	 AssociatedOrder,
	 MultipleOrderId,
      [PreviousState]
           ,[TruckSizeId],
	  [TruckSize] from (SELECT ROW_NUMBER() OVER (ORDER BY ISNULL(om.PraposedTimeOfAction, ISNULL(o.ModifiedDate,o.CreatedDate)) desc) as rownumber , COUNT(*) OVER () as TotalCount,o.OrderId,o.OrderType,
  o.OrderNumber, 
  (case when  o.HoldStatus IS null or  o.HoldStatus ='''' then ''-'' else o.HoldStatus end) as HoldStatus,
 
    (SELECT [dbo].[fn_GetTotalAmount] (0,o.OrderId)) AS TotalPrice, 
   ISNULL(o.ModifiedDate,o.CreatedDate) as ModifiedDate,
  d.DeliveryLocationName,
  d.DeliveryLocationCode, 
  case when SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0))='''' then SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5) else isnull(SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0)),SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5)) end as CompanyName,
  (select top 1 UserName from Login where LoginId = o.CreatedBy) as UserName,
  o.ExpectedTimeOfDelivery,
  IsNULl(o.SalesOrderNumber,''-'') as SalesOrderNumber  ,  
  IsNULl(o.PurchaseOrderNumber,''-'') as PurchaseOrderNumber  ,
  om.PraposedShift as PraposedShift,
  om.PraposedTimeOfAction as PraposedTimeOfAction,
    o.OrderDate , 
   	 d.Capacity,
  o.Remarks,
  o.CurrentState,
    (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',o.CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) AS ''Status'',
  (SELECT [dbo].[fn_RoleWiseClass] (' + CONVERT(NVARCHAR(10), @roleId)+',o.CurrentState)) AS ''Class'',
  ISNULL((select EnquiryAutoNumber from Enquiry where EnquiryId = o.EnquiryId),''-'') as EnquiryAutoNumber,
  o.ShipTo ,
  o.SoldTo,  
  case when ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ExpectedTimeOfDelivery,o.ShipTo,o.SoldTo,ISNULL(CONVERT(bigint,Capacity),0)))) < 0  then ''0'' else ''1'' end  as ReceivedCapacityPalettesCheck,
  o.PrimaryAddressId,
  [SecondaryAddressId],
  [PrimaryAddress],
  [SecondaryAddress] ,   
  (Select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode=o.StockLocationId) as StockLocationId ,
   o.StockLocationId as BranchPlantName,
case when (c.ActualEmpties < 0) then ''C'' else ''W'' end as Empties,
(select top 1 EmptiesLimit from Company where companyid = o.SoldTo) as EmptiesLimit,
(select top 1 ActualEmpties from Company where companyid = o.SoldTo) as ActualEmpties,'


	 SET @sql1 = '  (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]   where IsActive=1 and orderId in ( select AssociatedOrder from [OrderProduct] op where op.IsActive = 1 and  OrderId = o.OrderId and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) as AssociatedOrder,
(SELECT  CONVERT(nvarchar(250),o.OrderId)+ '',''+ ISNULL(STUFF((Select (SELECT '','' + CAST(OrderId AS VARCHAR(max)) [text()] from [order]   where IsActive=1 and orderId in ( select AssociatedOrder from [OrderProduct] op where op.IsActive = 1 and  OrderId = o.OrderId and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,''''),'''')    ) as MultipleOrderId,
      [PreviousState],     
     o.[TruckSizeId],
	  ts.TruckSize,		
  (SELECT Cast ((SELECT    ''true'' AS [@json:Array]  ,op.OrderProductId,op.OrderId
  ,op.ProductCode
  ,op.ProductType
  ,op.ProductQuantity ,
   ISNULL(op.AssociatedOrder,0) as AssociatedOrder,
   (SELECT ISNULL([dbo].[fn_UsedOrderQuantityForOrder] (op.ProductCode,o.StockLocationId,o.CreatedDate),0)) as UsedQuantityInOrder,
	 (SELECT ISNULL([dbo].[fn_AvailableProductQuantity] (op.ProductCode,o.StockLocationId),0)) as ProductAvailableQuantity 
  ,op.Remarks  
   FROM dbo.OrderProduct op
  WHERE op.IsActive=1 AND o.OrderId=op.OrderId 
  FOR XML path(''OrderProductList''),ELEMENTS) AS xml)) AS enquiryProduct  
    from [dbo].[Order] o left join  DeliveryLocation d 
    on o.shipto = d.DeliveryLocationId
    left join Company c on c.CompanyId = d.CompanyId
    left join LookUp l on l.LookUpId = o.CurrentState
    left join TruckSize ts on ts.TruckSizeId = o.TruckSizeId
	left join OrderMovement om on o.OrderId = om.OrderId
                WHERE o.IsActive = 1 and o.OrderType not in (''SG'',''S5'',''S6'') and ' + @whereClause +' ) as tmp where 
    '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'


   --WHERE ' + @whereClause + ' and tmp.rownumber between ' + CONVERT(NVARCHAR(10), @PageIndex) + ' and ' + CONVERT(NVARCHAR(10), @PageSize) + 'ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'
   

 PRINT (@sql)
 print @sql1
 

--SELECT @sql
-- EXEC sp_executesql @sql
exec (@sql+@sql1)







END
