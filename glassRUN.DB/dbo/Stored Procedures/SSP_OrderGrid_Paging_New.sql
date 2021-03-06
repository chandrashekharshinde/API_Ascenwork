CREATE PROCEDURE [dbo].[SSP_OrderGrid_Paging_New] --'<Json><ServicesAction>LoadOrderGrid</ServicesAction><PageIndex>0</PageIndex><OrderBy/><SalesOrderNumber/><SalesOrderNumberCriteria/><CompanyNameValue/><CompanyNameValueCriteria/><PurchaseOrderNumber/><PurchaseOrderNumberCriteria/><EnquiryAutoNumber/><EnquiryAutoNumberCriteria/><BranchPlant/><BranchPlantCriteria/><BranchPlantCode/><BranchPlantCodeCriteria/><BranchPlantName/><BranchPlantNameCriteria/><DeliveryLocation/><DeliveryLocationCriteria/><Gratis/><GratisCriteria/><RequestDate/><RequestDateCriteria/><Status/><StatusCriteria/><OrderType>SO</OrderType><OrderDate/><OrderDateCriteria/><PickUpDate/><PickUpDateCriteria/><ConfirmedPickUpDate/><ConfirmedPickUpDateCriteria/><Empties/><EmptiesCriteria/><ReceivedCapacityPalates/><ReceivedCapacityPalatesCriteria/><StatusForChangeInPickShift/><StatusForChangeInPickShiftCriteria/><RoleMasterId>5</RoleMasterId><CultureId>1101</CultureId><ProductCodeData/><ProductCodeCriteria/><ProductName/><ProductNameCriteria/><ProductQuantity/><ProductQuantityCriteria/><ProductCode/><ProductSearchCriteria/><Description1/><Description1Criteria/><Description2/><Description2Criteria/><Province/><ProvinceCriteria/><OrderedBy/><OrderedByCriteria/><IsRPMPresent/><IsRPMPresentCriteria/><CarrierNumber>2</CarrierNumber><CarrierNumberCriteria>startswith</CarrierNumberCriteria><UserId>0</UserId><LoginId>7</LoginId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(max)
Declare @sql nvarchar(max)
Declare @sql1 nvarchar(max)
Declare @sql2 nvarchar(max)
Declare @sql3 nvarchar(max)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
DECLARE @roleId bigint
Declare @userId bigint
Declare @LoginId bigint
Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(150)

DECLARE @SalesOrderNumber nvarchar(150)
DECLARE @SalesOrderNumberCriteria nvarchar(50)

DECLARE @PurchaseOrderNumber nvarchar(150)
DECLARE @PurchaseOrderNumberCriteria nvarchar(50)

DECLARE @EnquiryAutoNumber nvarchar(150)
DECLARE @EnquiryAutoNumberCriteria nvarchar(50)


DECLARE @BranchPlant nvarchar(150)
DECLARE @BranchPlantCriteria nvarchar(50)

DECLARE @BranchPlantCode nvarchar(150)
DECLARE @BranchPlantCodeCriteria nvarchar(50)

DECLARE @BranchPlantName nvarchar(150)
DECLARE @BranchPlantNameCriteria nvarchar(50)

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


DECLARE @statusForChangeInPickShift nvarchar(150)
DECLARE @statusForChangeInPickShiftCriteria nvarchar(50)

Declare @CultureId bigint

DECLARE @ReceivedCapacityPalates nvarchar(150)
DECLARE @ReceivedCapacityPalatesCriteria nvarchar(50)


DECLARE @ProductCode nvarchar(max)

DECLARE @ProductSearchCriteria nvarchar(100)

DECLARE @TruckSize nvarchar(150)
DECLARE @TruckSizeCriteria nvarchar(50)

DECLARE @ProductCodeData nvarchar(150)
DECLARE @ProductCodeCriteria nvarchar(50)

DECLARE @ProductName nvarchar(150)
DECLARE @ProductNameCriteria nvarchar(50)

DECLARE @ProductQuantity nvarchar(150)
DECLARE @ProductQuantityCriteria nvarchar(50)


DECLARE @Description1 nvarchar(150)
DECLARE @Description1Criteria nvarchar(50)

DECLARE @LoadNumber nvarchar(150)
DECLARE @LoadNumberCriteria nvarchar(50)

DECLARE @Description2 nvarchar(150)
DECLARE @Description2Criteria nvarchar(50)


DECLARE @CarrierNumber nvarchar(150)
DECLARE @CarrierNumberCriteria nvarchar(50)


DECLARE @Province nvarchar(150)
DECLARE @ProvinceCriteria nvarchar(50)

DECLARE @OrderedBy nvarchar(150)
DECLARE @OrderedByCriteria nvarchar(50)


DECLARE @IsRPMPresent nvarchar(150)
DECLARE @IsRPMPresentCriteria nvarchar(50)

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
	 @LoginId = [LoginId],
	@BranchPlantCode = tmp.[BranchPlantCode],
    @BranchPlantCodeCriteria = tmp.[BranchPlantCodeCriteria],

	@BranchPlantName = tmp.[BranchPlantName],
    @BranchPlantNameCriteria = tmp.[BranchPlantNameCriteria],

	  @DeliveryLocation = tmp.[DeliveryLocation],
	   @DeliveryLocationCriteria = tmp.[DeliveryLocationCriteria],
	     @Gratis = tmp.[Gratis],
	   @GratisCriteria = tmp.[GratisCriteria],
	   @Status = tmp.[Status],
	   @StatusCriteria = tmp.[StatusCriteria],
	     @SchedulingDate = tmp.[SchedulingDate],
	   @SchedulingDateCriteria = tmp.[SchedulingDateCriteria],
	   @OrderType = tmp.[OrderType],
    @PageSize = 30,
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@roleId = tmp.[RoleMasterId],
	@OrderDate = tmp.[OrderDate],
	   @OrderDateCriteria = tmp.[OrderDateCriteria],
	   @LoadNumber = tmp.[LoadNumber],
    @LoadNumberCriteria = tmp.[LoadNumberCriteria],	
	   @TruckSize = tmp.[TruckSize],
    @TruckSizeCriteria = tmp.[TruckSizeCriteria],
	   @CompanyNameValue = tmp.[CompanyNameValue],
	@CompanyNameValueCriteria = tmp.[CompanyNameValueCriteria],
   @ProductCode = [ProductCode],
   @ProductSearchCriteria = [ProductSearchCriteria],
    @UserName = [UserName],
   @UserNameCriteria = [UserNameCriteria],
   @Empties=tmp.[Empties],
   @CultureId = [CultureId],
   	@EmptiesCriteria=tmp.[EmptiesCriteria],
	@statusForChangeInPickShift=tmp.[StatusForChangeInPickShift],
	@statusForChangeInPickShiftCriteria=tmp.[StatusForChangeInPickShiftCriteria],
   @ReceivedCapacityPalates=tmp.[ReceivedCapacityPalates],
   	@ReceivedCapacityPalatesCriteria=tmp.[ReceivedCapacityPalatesCriteria],
	@ProductCodeData = tmp.[ProductCodeData],
    @ProductCodeCriteria = tmp.[ProductCodeCriteria],
	@ProductName = tmp.[ProductName],
    @ProductNameCriteria = tmp.[ProductName],
	@ProductQuantity = tmp.[ProductQuantity],
    @ProductQuantityCriteria = tmp.[ProductQuantityCriteria],
	@Description1 = tmp.[Description1],
    @Description1Criteria = tmp.[Description1Criteria],
    @Description2 = tmp.[Description2],
    @Description2Criteria = tmp.[Description2Criteria],
    @Province = tmp.[Province],
    @ProvinceCriteria = tmp.[ProvinceCriteria],
	@OrderedBy = tmp.[OrderedBy],
    @OrderedByCriteria = tmp.[OrderedByCriteria],
    @CarrierNumber = tmp.[CarrierNumber],
    @CarrierNumberCriteria = tmp.[CarrierNumberCriteria],
	  @IsRPMPresent=tmp.[IsRPMPresent],
   	@IsRPMPresentCriteria=tmp.[IsRPMPresentCriteria],
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

    [BranchPlantCode]  nvarchar(150),
   [BranchPlantCodeCriteria] nvarchar(50),

    [BranchPlantName]  nvarchar(150),
   [BranchPlantNameCriteria] nvarchar(50),

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
            [LoadNumber] nvarchar(150),
			[LoadNumberCriteria] nvarchar(50),
			 [CompanyNameValue]  nvarchar(150),
   [CompanyNameValueCriteria] nvarchar(50),
   [TruckSize] nvarchar(150),
            [TruckSizeCriteria] nvarchar(50),
   [UserName] nvarchar(150),
            [UserNameCriteria] nvarchar(50),
   [ProductCode] nvarchar(500),
   [ProductSearchCriteria] nvarchar(100),
   [Empties] nvarchar(150),
   [CultureId] bigint,
	[EmptiesCriteria] nvarchar(150),
   [ReceivedCapacityPalates] nvarchar(150),
	[ReceivedCapacityPalatesCriteria] nvarchar(150),
	[ProductCodeData] nvarchar(150),
            [ProductCodeCriteria] nvarchar(50),
			[ProductName] nvarchar(150),
            [ProductNameCriteria] nvarchar(50),
			[ProductQuantity] nvarchar(150),
            [ProductQuantityCriteria] nvarchar(50),
			Description1 nvarchar(50),
   Description1Criteria nvarchar(50),
   Description2 nvarchar(50),
   Description2Criteria nvarchar(50),
    [CarrierNumber] nvarchar(50),
   [CarrierNumberCriteria] nvarchar(150),
   [Province] nvarchar(150),
            [ProvinceCriteria] nvarchar(50),
			[OrderedBy] nvarchar(150),
            [OrderedByCriteria] nvarchar(50),
			StatusForChangeInPickShift  nvarchar(150),
			StatusForChangeInPickShiftCriteria nvarchar(50),
			[IsRPMPresent] nvarchar(150),
            [IsRPMPresentCriteria] nvarchar(50),
   [UserId] bigint,
   [LoginId] bigint
           
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

IF @statusForChangeInPickShift !=''
BEGIN
 SET @whereClause = @whereClause + ' and (case when  PraposedTimeOfAction != ExpectedTimeOfAction or PraposedShift != ExpectedShift then ''1'' else ''0'' end) =  ''' +@statusForChangeInPickShift+ ''''
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
  
  SET @whereClause = @whereClause + ' and StockLocationId LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and StockLocationId NOT LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and StockLocationId LIKE ''' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and StockLocationId LIKE ''%' + @BranchPlant + ''''
  END          
  IF @BranchPlantCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and StockLocationId =  ''' +@BranchPlant+ ''''
  END
  IF @BranchPlantCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and StockLocationId <>  ''' +@BranchPlant+ ''''
  END
END

IF @BranchPlantCode !=''
BEGIN

  IF @BranchPlantCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and StockLocationId LIKE ''%' + @BranchPlantCode + '%'''
  END
  IF @BranchPlantCodeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and StockLocationId NOT LIKE ''%' + @BranchPlantCode + '%'''
  END
  IF @BranchPlantCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and StockLocationId LIKE ''' + @BranchPlantCode + '%'''
  END
  IF @BranchPlantCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and StockLocationId LIKE ''%' + @BranchPlantCode + ''''
  END          
  IF @BranchPlantCodeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and StockLocationId =  ''' +@BranchPlantCode+ ''''
  END
  IF @BranchPlantCodeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and StockLocationId <>  ''' +@BranchPlantCode+ ''''
  END
END


IF @BranchPlantName !=''
BEGIN

  IF @BranchPlantNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 DeliveryLocationName from DeliveryLocation where DeliveryLocationCode=o.StockLocationId) LIKE ''%' + @BranchPlantName + '%'''
  END
  IF @BranchPlantNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 DeliveryLocationName from DeliveryLocation where DeliveryLocationCode=o.StockLocationId) NOT LIKE ''%' + @BranchPlantName + '%'''
  END
  IF @BranchPlantNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 DeliveryLocationName from DeliveryLocation where DeliveryLocationCode=o.StockLocationId) LIKE ''' + @BranchPlantName + '%'''
  END
  IF @BranchPlantNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 DeliveryLocationName from DeliveryLocation where DeliveryLocationCode=o.StockLocationId) LIKE ''%' + @BranchPlantName + ''''
  END          
  IF @BranchPlantNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 DeliveryLocationName from DeliveryLocation where DeliveryLocationCode=o.StockLocationId) =  ''' +@BranchPlantName+ ''''
  END
  IF @BranchPlantNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 DeliveryLocationName from DeliveryLocation where DeliveryLocationCode=o.StockLocationId) <>  ''' +@BranchPlantName+ ''''
  END
END

IF @LoadNumber !=''
BEGIN

  IF @LoadNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LoadNumber LIKE ''%' + @LoadNumber + '%'''
  END
  IF @LoadNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LoadNumber NOT LIKE ''%' + @LoadNumber + '%'''
  END
  IF @LoadNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LoadNumber LIKE ''' + @LoadNumber + '%'''
  END
  IF @LoadNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and LoadNumber LIKE ''%' + @LoadNumber + ''''
  END          
  IF @LoadNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and LoadNumber =  ''' +@LoadNumber+ ''''
  END
  IF @LoadNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and LoadNumber <>  ''' +@LoadNumber+ ''''
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

 --SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',o.CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) =  N''' + @Status + ''''

 --SET @whereClause = @whereClause + ' and o.CurrentState = (select LookUpId from LookUp where Name= N''' + @Status + ''' and LookupCategory=7)'

 SET @whereClause = @whereClause + ' and CurrentState in (select Statusid from RoleWiseStatus where resourcekey= (select top 1 resourcekey from resources where resourceValue=N''' + @Status + ''' and PageName=''status'') and Roleid=' + CONVERT(NVARCHAR(10), @roleId)+')'

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
			SET @whereClause = @whereClause + 'and OrderId in (SELECT OrderId FROM OrderProduct WHERE ProductCode IN (SELECT * FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')) GROUP BY OrderId HAVING COUNT(*) >= (SELECT COUNT(*) FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')))'
		ENd
	Else
		Begin
			SET @whereClause = @whereClause + 'and OrderId not in (SELECT OrderId FROM OrderProduct WHERE ProductCode IN (SELECT * FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')) GROUP BY OrderId HAVING COUNT(*) >= (SELECT COUNT(*) FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')))'
		ENd
End

IF @TruckSize !=''
BEGIN

  IF @TruckSizeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize LIKE ''%' + @TruckSize + '%'''
  END
  IF @TruckSizeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize NOT LIKE ''%' + @TruckSize + '%'''
  END
  IF @TruckSizeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize LIKE ''' + @TruckSize + '%'''
  END
  IF @TruckSizeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize LIKE ''%' + @TruckSize + ''''
  END          
  IF @TruckSizeCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and TruckSize =  ''' + @TruckSize + ''''
  END
  IF @TruckSizeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckSize <>  ''' + @TruckSize + ''''
  END
END

IF @ProductCodeData !=''
BEGIN

  IF @ProductCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductCode LIKE ''%' + @ProductCodeData + '%'''
  END
  IF @ProductCodeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductCode NOT LIKE ''%' + @ProductCodeData + '%'''
  END
  IF @ProductCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductCode LIKE ''' + @ProductCodeData + '%'''
  END
  IF @ProductCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductCode LIKE ''%' + @ProductCodeData + ''''
  END          
  IF @ProductCodeCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and ProductCode =  ''' + @ProductCodeData + ''''
  END
  IF @ProductCodeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ProductCode <>  ''' + @ProductCodeData + ''''
  END
END



IF @ProductName !=''
BEGIN

  IF @ProductNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductName LIKE ''%' + @ProductName + '%'''
  END
  IF @ProductNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductName NOT LIKE ''%' + @ProductName + '%'''
  END
  IF @ProductNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductName LIKE ''' + @ProductName + '%'''
  END
  IF @ProductNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductName LIKE ''%' + @ProductName + ''''
  END          
  IF @ProductNameCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and ProductName =  ''' + @ProductName + ''''
  END
  IF @ProductNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ProductName <>  ''' + @ProductName + ''''
  END
END


IF @ProductQuantity !=''
BEGIN

  IF @ProductQuantityCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductQuantity LIKE ''%' + @ProductQuantity + '%'''
  END
  IF @ProductQuantityCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductQuantity NOT LIKE ''%' + @ProductQuantity + '%'''
  END
  IF @ProductQuantityCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductQuantity LIKE ''' + @ProductQuantity + '%'''
  END
  IF @ProductQuantityCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductQuantity LIKE ''%' + @ProductQuantity + ''''
  END          
  IF @ProductQuantityCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and ProductQuantity =  ''' + @ProductQuantity + ''''
  END
  IF @ProductQuantityCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ProductQuantity <>  ''' + @ProductQuantity + ''''
  END
END

IF @Description1 !=''
BEGIN

  IF @Description1Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description1 LIKE ''%' + @Description1 + '%'''
  END
  IF @Description1Criteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description1 NOT LIKE ''%' + @Description1 + '%'''
  END
  IF @Description1Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description1 LIKE ''' + @Description1 + '%'''
  END
  IF @Description1Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description1 LIKE ''%' + @Description1 + ''''
  END          
  IF @Description1Criteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and Description1 =  ''' + @Description1 + ''''
  END
  IF @Description1Criteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Description1 <>  ''' + @Description1 + ''''
  END
END

IF @Description2 !=''
BEGIN

  IF @Description2Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description2 LIKE ''%' + @Description2 + '%'''
  END
  IF @Description2Criteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description2 NOT LIKE ''%' + @Description2 + '%'''
  END
  IF @Description2Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description2 LIKE ''' + @Description2 + '%'''
  END
  IF @Description2Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description2 LIKE ''%' + @Description2 + ''''
  END          
  IF @Description2Criteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and Description2 =  ''' + @Description2 + ''''
  END
  IF @Description2Criteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Description2 <>  ''' + @Description2 + ''''
  END
END

IF @Province !=''
BEGIN

  IF @ProvinceCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Province LIKE ''%' + @Province + '%'''
  END
  IF @ProvinceCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Province NOT LIKE ''%' + @Province + '%'''
  END
  IF @ProvinceCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Province LIKE ''' + @Province + '%'''
  END
  IF @ProvinceCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Province LIKE ''%' + @Province + ''''
  END          
  IF @ProvinceCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and Province =  ''' + @Province + ''''
  END
  IF @ProvinceCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Province <>  ''' + @Province + ''''
  END
END


IF @OrderedBy !=''
BEGIN

  IF @OrderedByCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderedBy LIKE ''%' + @OrderedBy + '%'''
  END
  IF @OrderedByCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderedBy NOT LIKE ''%' + @OrderedBy + '%'''
  END
  IF @OrderedByCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderedBy LIKE ''' + @OrderedBy + '%'''
  END
  IF @OrderedByCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderedBy LIKE ''%' + @OrderedBy + ''''
  END          
  IF @OrderedByCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and OrderedBy =  ''' + @OrderedBy + ''''
  END
  IF @OrderedByCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and OrderedBy <>  ''' + @OrderedBy + ''''
  END
END

Print @CarrierNumberCriteria
IF @CarrierNumber !=''
BEGIN

  IF @CarrierNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select CompanyMnemonic From Company  with (nolock) where CompanyId in (select CarrierNumber from Route  with (nolock)where DestinationId=o.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation with (nolock) where DeliveryLocationCode in (o.StockLocationId)and TruckSizeId= o.TruckSizeId)) and CompanyType=28) LIKE ''%' + @CarrierNumber + '%'''
  END
  IF @CarrierNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select CompanyMnemonic From Company  with (nolock) where CompanyId in (select CarrierNumber from Route with (nolock) where DestinationId=o.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation with (nolock) where DeliveryLocationCode in (o.StockLocationId)and TruckSizeId= o.TruckSizeId)) and CompanyType=28) NOT LIKE ''%' + @CarrierNumber + '%'''
  END
  IF @CarrierNumberCriteria = 'startswith'
  BEGIN
  Print 'Hii'
  SET @whereClause = @whereClause + ' and (Select CompanyMnemonic From Company  with (nolock) where CompanyId in (select CarrierNumber from Route  with (nolock)where DestinationId=o.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation with (nolock) where DeliveryLocationCode in (o.StockLocationId)and TruckSizeId= o.TruckSizeId)) and CompanyType=28) LIKE ''' + @CarrierNumber + '%'''
      
      
  END
  IF @CarrierNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select CompanyMnemonic From Company  with (nolock) where CompanyId in (select CarrierNumber from Route with (nolock) where DestinationId=o.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation with (nolock) where DeliveryLocationCode in (o.StockLocationId)and TruckSizeId= o.TruckSizeId)) and CompanyType=28) LIKE ''%' + @CarrierNumber + ''''
  END          
  IF @CarrierNumberCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and (Select CompanyMnemonic From Company  with (nolock) where CompanyId in (select CarrierNumber from Route  with (nolock)where DestinationId=o.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation with (nolock) where DeliveryLocationCode in (o.StockLocationId)and TruckSizeId= o.TruckSizeId)) and CompanyType=28) =  ''' + @CarrierNumber + ''''
  END
  IF @CarrierNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select CompanyMnemonic From Company  with (nolock) where CompanyId in (select CarrierNumber from Route with (nolock) where DestinationId=o.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation with (nolock) where DeliveryLocationCode in (o.StockLocationId)and TruckSizeId= o.TruckSizeId)) and CompanyType=28) <>  ''' + @CarrierNumber + ''''
  END
END



IF @IsRPMPresent !=''
BEGIN
	if(@IsRPMPresent = '1')
	Begin
	SET @whereClause = @whereClause + ' and o.EnquiryId IN (select EnquiryId from ReturnPakageMaterial  with (nolock) )'
	End
	Else
	Begin
	SET @whereClause = @whereClause + ' and o.EnquiryId NOT IN (select EnquiryId from ReturnPakageMaterial with (nolock) )'
	End
END


if @roleId=3
BEGIN
Print @roleId

IF @OrderType = 'Gratis Order'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderType in (''SG'',''S5'',''S6'')'
  END
Else
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (OrderType not in (''SG'',''S5'',''S6'') or OrderType is NULL)'
  END

END
 
if @roleId=4
BEGIN
Print @roleId



IF @OrderType = 'Gratis Order'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderType in (''SG'',''S5'',''S6'')'
  END
Else
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (OrderType not in (''SG'',''S5'',''S6'') or OrderType is NULL)'
  END

SET @whereClause = @whereClause + ' and  o.SoldTo = ' + CONVERT(NVARCHAR(10), @userId)+''
END


If @roleId = 7
Begin 
	SET @whereClause = @whereClause + 'and o.CarrierNumber =(' + CONVERT(NVARCHAR(10), @userId)+')'

	IF @OrderType != 'SO'
		Begin 		
			SET @whereClause = @whereClause + 'and o.OrderType in (''ST'')'
		End
	ELSE
		BEGIN
			SET @whereClause = @whereClause + 'and o.OrderType in (''SO'')'
		END
End

If (@roleId = 7 Or @roleId = 5 Or @roleId = 6)
BEGIN

SET @whereClause = @whereClause + 'and o.OrderType not in (''SG'',''S5'',''S6'') and o.SalesOrderNumber is not null ';
-- (SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause] (@LoginId,'SSP_OrderGrid_Paging')) +''

	If (@roleId = 7 Or @roleId = 5)
		Begin
				Declare @settingValue nvarchar(50)
					SET @settingValue=(Select SettingValue from SettingMaster where SettingParameter='OrderShownToCarrier' and IsActive=1)
				If @settingValue=1
					BEGIN
						SET @whereClause = @whereClause + ' and om.PraposedTimeOfAction is not null and PraposedShift is not null'
					END
		End
END



Print @whereClause

SET @orderBy = 'Convert(date,ExpectedTimeOfAction) desc, ExpectedShift desc'

declare @sqlTotalCount1 nvarchar(max)

set @sqlTotalCount1=' SELECT COUNT(o.OrderId) 
      from [dbo].[Order] o  with (nolock) left join  DeliveryLocation d on o.shipto = d.DeliveryLocationId
    left join Company c  with (nolock) on c.CompanyId = d.CompanyId
    left join TruckSize ts  with (nolock)on ts.TruckSizeId = o.TruckSizeId
	left join OrderMovement om  with (nolock)on o.OrderId = om.OrderId
                WHERE o.IsActive = 1  and ' + @whereClause 



 SET @sql = ' WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((select  ''true'' AS [@json:Array],tmp.OrderId,tmp.OrderType,
 rownumber,
 ('+@sqlTotalCount1+') as TotalCount, tmp.OrderNumber,
 HoldStatus,
 ISNULL(TotalPrice,0) as TotalPrice,
  tmp.SalesOrderNumber,
  tmp.SalesOrderNumber as SOGratisNumber,
  LoadNumber,
  PurchaseOrderNumber,
  ISNULL(PraposedShift,'''') as ProposedShift,
  ISNULL(CONVERT(varchar(11),PraposedTimeOfAction,103),'''') as ProposedTimeOfAction,
  StatusForChangeInPickShift,
  OrderDate,
  DeliveryLocationName,
  case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end as DeliveryLocation ,
  CompanyName,
  CompanyMnemonic,
  UserName,
ISNULL(CONVERT(varchar(11),tmp.ExpectedTimeOfDelivery,103),'''') as ExpectedTimeOfDelivery,
ISNULL(CONVERT(varchar(11),tmp.ExpectedTimeOfDelivery,103),'''') as RequestDate,
   (SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ExpectedTimeOfDelivery,ShipTo,SoldTo,ISNULL(CONVERT(bigint,Capacity),0))) as ReceivedCapacityPalettes,
     ISNULL(CONVERT(bigint,Capacity),0) as Capacity,
	  IsRPMPresent,
EnquiryAutoNumber,
 ProductCode,
 ProductName,
 CONVERT(decimal(18,0),ProductQuantity) as ProductQuantity,
  GratisCode,
  Province,
  OrderedBy,  
  Description1,
  Description2,
    CarrierNumberValue,
  Field1,
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
    ,ISNULL(Note,'''') as Note
    ,StockLocationId,
	BranchPlantName,
	DeliveryLocationBranchName,
	Empties,
	IsNull(EmptiesLimit,0) as EmptiesLimit,
	IsNull(ActualEmpties,0) as ActualEmpties, 
	AssociatedOrder
    ,[PreviousState]
    ,[TruckSizeId],
	  [TruckSize] ,
	  Email,
	  PlateNumberData,
	  PlateNumber,
	  PreviousPlateNumber,
	  ISNULL(DriverName,''-'') as DriverName,
	  ISNULL(ProfileId,0) as ProfileId,
	  ISNULL(TruckInPlateNumber,'''') as TruckInPlateNumber,
	  ISNULL(TruckOutPlateNumber,'''') as TruckOutPlateNumber,
	  ISNULL(TruckInDateTime,'''') as TruckInDateTime,	 
	  ISNULL(TruckOutDateTime,'''') as TruckOutDateTime,
	  CarrierNumber,
	  TruckRemark, 
	  ISNULL(ExpectedShift,'''') as ExpectedShift,
	  ISNULL(CONVERT(varchar(11),ExpectedTimeOfAction,103),'''') as ExpectedTimeOfAction,
	  ISNULL(DeliveryPersonnelId,0) as DeliveryPersonnelId
	  	  from (SELECT ROW_NUMBER() OVER (ORDER BY o.CreatedDate desc) as rownumber 
	  	 
	  	  ,o.OrderId,o.OrderType,
  o.OrderNumber, 
  (case when  o.HoldStatus IS null or  o.HoldStatus ='''' then ''-'' else o.HoldStatus end) as HoldStatus,
     (SELECT [dbo].[fn_GetTotalAmount] (0,o.OrderId)) AS TotalPrice, 
   ISNULL(o.ModifiedDate,o.CreatedDate) as ModifiedDate,
  d.DeliveryLocationName,
  d.DeliveryLocationCode, 
    case when SUBSTRING((select top 1 CompanyName from Company  with (nolock) where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company  with (nolock) where CompanyId =  o.SoldTo),0))='''' then SUBSTRING((select top 1 CompanyName from Company  with (nolock) where CompanyId =  o.SoldTo),1,5) else isnull(SUBSTRING((select top 1 CompanyName from Company  with (nolock) where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company  with (nolock) where CompanyId =  o.SoldTo),0)),SUBSTRING((select top 1 CompanyName from Company  with (nolock) where CompanyId =  o.SoldTo),1,5)) end as CompanyName,
	(select top 1 CompanyMnemonic from Company  with (nolock) where CompanyId =  o.SoldTo) as CompanyMnemonic,
  (select top 1 UserName from Login  with (nolock) where LoginId = o.CreatedBy) as UserName,'

   SET @sql1 = 'o.ExpectedTimeOfDelivery,
   o.ExpectedTimeOfDelivery as RequestDate,
   
  IsNULl(o.SalesOrderNumber,''-'') as SalesOrderNumber  ,  
  IsNULl(o.PurchaseOrderNumber,''-'') as PurchaseOrderNumber  ,
  IsNULl(o.LoadNumber,''-'') as LoadNumber  ,  
  om.PraposedShift as PraposedShift,
  om.PraposedTimeOfAction as PraposedTimeOfAction,
    o.OrderDate , 
   	 d.Capacity,
	 case 
   when exists (
      select * from ReturnPakageMaterial rpm  with (nolock) where rpm.EnquiryId = o.EnquiryId and IsActive = 1
   ) 
   then 1 
   else 0 
end AS IsRPMPresent,
  o.Remarks,
  o.CurrentState,
    (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',o.CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) AS ''Status'',
  (SELECT [dbo].[fn_RoleWiseClass] (' + CONVERT(NVARCHAR(10), @roleId)+',o.CurrentState)) AS ''Class'',
  ISNULL((select EnquiryAutoNumber from Enquiry  with (nolock) where EnquiryId = o.EnquiryId),''-'') as EnquiryAutoNumber,
  o.ShipTo ,
  (select top 1 ProductCode from OrderProduct  with (nolock) where OrderId =  o.OrderId) as ProductCode,
  (Select top 1 ItemName from Item  with (nolock) where ItemCode in (select top 1 ProductCode from OrderProduct  with (nolock) where OrderId = o.OrderId)) as ProductName,
  (select top 1 ProductQuantity from OrderProduct  with (nolock) where OrderId =  o.OrderId) as ProductQuantity,
  o.GratisCode,
   o.Province ,
   o.OrderedBy,     
		 o.Description1,
		 o.Description2,
		 ISNULL(d.Field1,'''') as Field1,
  o.SoldTo,  
  case when ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ExpectedTimeOfDelivery,o.ShipTo,o.SoldTo,ISNULL(CONVERT(bigint,Capacity),0)))) < 0  then ''0'' else ''1'' end  as ReceivedCapacityPalettesCheck,
  o.PrimaryAddressId,
  [SecondaryAddressId],
      [PrimaryAddress],
      [SecondaryAddress] ,   
      (select top 1 Note from  Notes  with (nolock) where ObjectId = o.OrderId and ObjectType = 1221 and RoleId in (select RoleId from NotesRoleWiseConfiguration  with (nolock) where ViewNotesByRoleId = ' + CONVERT(NVARCHAR(10), @roleId) + ' and ObjectType = 1221)) as Note,
     (Select top 1 DeliveryLocationId from DeliveryLocation  with (nolock) where DeliveryLocationCode=o.StockLocationId) as StockLocationId,
	 (Select top 1 DeliveryLocationName from DeliveryLocation  with (nolock) where DeliveryLocationCode=o.StockLocationId) as DeliveryLocationBranchName,
	 	 o.StockLocationId as BranchPlantName,
	 case when (c.ActualEmpties < 0) then ''C'' else ''W'' end as Empties,
	 (case when  PraposedTimeOfAction != ExpectedTimeOfAction or PraposedShift != ExpectedShift then ''1'' else ''0'' end) as StatusForChangeInPickShift,
	 (select top 1 EmptiesLimit from Company  with (nolock) where companyid = o.SoldTo) as EmptiesLimit,
(select top 1 ActualEmpties from Company  with (nolock) where companyid = o.SoldTo) as ActualEmpties,  (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [OrderProduct] op  with (nolock) where op.IsActive = 1 and  OrderId = o.OrderId and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) as AssociatedOrder,
      [PreviousState],     
     o.[TruckSizeId],
	  ts.TruckSize,'
	 SET @sql2 = '
	  --c.Email,
	     (Select STUFF((Select (SELECT '','' + CAST(Contacts AS VARCHAR(max)) [text()] from contactinformation   with (nolock)  where IsActive=1 and ObjectId = o.ShipTO  and ContactType=''Email'' and (ObjectType=''SoldTo'' Or ObjectType=''ShipTo'')  FOR XML PATH(''''))
),1,1,'''') ) as Email,
	  (SELECT top 1 TruckPlateNumber FROM orderlogistics  with (nolock) WHERE ordermovementid IN (SELECT OrderMovementId FROM OrderMovement  with (nolock) WHERE OrderId=o.OrderId AND LocationType=1)) AS PlateNumberData,

	  (SELECT top 1 TruckPlateNumber FROM orderlogistics  with (nolock) WHERE ordermovementid IN (SELECT OrderMovementId FROM OrderMovement  with (nolock) WHERE OrderId=o.OrderId AND LocationType=1)) AS PlateNumber,

	   ISNULL((SELECT TOP 1 PlateNumber From (select Top 1 * from OrderLogistichistory  with (nolock) where Orderid=o.OrderId and PlateNumberBy = ''Carrier''   ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId),
	  (SELECT TOP 1 PlateNumber From (select Top 1 * from OrderLogistichistory  with (nolock) where Orderid=o.OrderId and PlateNumberBy = ''TruckOut''  ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId)) as PreviousPlateNumber,	 	 

	  (SELECT TOP 1 PlateNumber From (select Top 1 * from OrderLogistichistory  with (nolock) where Orderid=o.OrderId and PlateNumberBy = ''TruckIn''  ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId) as TruckInPlateNumber,
	  (SELECT TOP 1 PlateNumber From (select Top 1 * from OrderLogistichistory   with (nolock) where Orderid=o.OrderId and PlateNumberBy = ''TruckOut''  ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId) as TruckOutPlateNumber,
	  (select TruckInTime from OrderLogistics  with (nolock) where OrderMovementId in (select top 1 OrderMovementId from OrderMovement  with (nolock) where OrderId=o.OrderId)) as TruckInDateTime,
	  	 (select TruckOutTime from OrderLogistics  with (nolock) where OrderMovementId in (select top 1 OrderMovementId from OrderMovement  with (nolock) where OrderId=o.OrderId)) as TruckOutDateTime,
	 (select top 1 carriernumber from route  with (nolock) where destinationid=o.ShipTo) as CarrierNumber,
	 (Select CompanyMnemonic From Company  with (nolock)  where CompanyId in (select CarrierNumber from Route  with (nolock) where DestinationId=o.ShipTo 
      and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation  with (nolock) where DeliveryLocationCode in (o.StockLocationId)and TruckSizeId= o.TruckSizeId)) and CompanyType=28) as CarrierNumberValue,
	 (select top 1 remark from OrderLogistichistory  with (nolock) where Orderid=o.OrderId and PlateNumberBy <> ''Carrier'' ORDER BY OrderLogistichistoryId DESC) as TruckRemark,
	  (Select Name from Profile  with (nolock) where ProfileId in (Select ProfileId from Login  with (nolock) where LoginId in (select DeliveryPersonnelId from OrderLogistics  with (nolock) where OrderMovementId in (select top 1 OrderMovementId from OrderMovement with (nolock) where OrderId=o.OrderId)))) as DriverName,	
	  (Select ProfileId from Login with (nolock) where LoginId in (select DeliveryPersonnelId from OrderLogistics  with (nolock)where OrderMovementId in (select top 1 OrderMovementId from OrderMovement  with (nolock)where OrderId=o.OrderId))) as ProfileId,
	   '
	 SET @sql3 = '
	 (case when om.ExpectedShift IS NOT NULL then om.ExpectedShift ELse om.PraposedShift END) as ExpectedShift,
 (case when om.ExpectedTimeOfAction IS NOT NULL then om.ExpectedTimeOfAction ELse om.PraposedTimeOfAction END) as ExpectedTimeOfAction,
	  om.DeliveryPersonnelId as DeliveryPersonnelId,
	    (SELECT Cast ((SELECT    ''true'' AS [@json:Array]  ,op.OrderProductId,op.OrderId
  ,op.ProductCode
  ,op.ProductType
  ,op.ItemType
   ,i.ItemName
  ,CONVERT(DECIMAL(18,0), ISNULL(op.ProductQuantity,0)) as ProductQuantity ,
  CONVERT(DECIMAL(18,0), ISNULL(op.UnitPrice,0)) as ItemPricesPerUnit
	  , CONVERT(DECIMAL(18,0), ISNULL((op.UnitPrice * op.ProductQuantity),0)) as ItemPrices,
	  	   CONVERT(DECIMAL(18,0),ISNULL(op.DepositeAmount,0)) as DepositeAmountPerUnit,
		   			  CONVERT(DECIMAL(18,0),ISNULL((op.DepositeAmount * op.ProductQuantity),0)) as ItemTotalDepositeAmount,

  (SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as UOM,
  (select top 1 SettingValue from SettingMaster  with (nolock)where SettingParameter = ''ItemTaxInPec'') as ItemTax,
   ISNULL(op.AssociatedOrder,0) as AssociatedOrder,
   (SELECT ISNULL([dbo].[fn_UsedOrderQuantityForOrder] (op.ProductCode,o.StockLocationId,o.CreatedDate),0)) as UsedQuantityInOrder,
	 (SELECT ISNULL([dbo].[fn_AvailableProductQuantity] (op.ProductCode,o.StockLocationId),0)) as ProductAvailableQuantity 
  ,op.Remarks  
   FROM dbo.OrderProduct op  with (nolock)left join Item i  on op.ProductCode = i.ItemCode
  WHERE op.IsActive=1 AND o.OrderId=op.OrderId and i.IsActive = 1
  FOR XML path(''OrderProductList''),ELEMENTS) AS xml)) AS enquiryProduct 
      from [dbo].[Order] o  with (nolock) left join  DeliveryLocation d on o.shipto = d.DeliveryLocationId
    left join Company c  with (nolock) on c.CompanyId = d.CompanyId

    left join TruckSize ts  with (nolock)on ts.TruckSizeId = o.TruckSizeId
	left join OrderMovement om  with (nolock)on o.OrderId = om.OrderId
                WHERE o.IsActive = 1  and ' + @whereClause +' ) as tmp where 
    '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'


   --WHERE ' + @whereClause + ' and tmp.rownumber between ' + CONVERT(NVARCHAR(10), @PageIndex) + ' and ' + CONVERT(NVARCHAR(10), @PageSize) + 'ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'
   

 PRINT (@sql)
 print @sql1
 print @sql2
 print @sql3

--SELECT @sql
-- EXEC sp_executesql @sql
exec (@sql+@sql1+@sql2+@sql3)







END