CREATE PROCEDURE [dbo].[SSP_OrderNewGrid_Paging] --'<Json><ServicesAction>LoadOrderGrid</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy/><SalesOrderNumber/><SalesOrderNumberCriteria/><CompanyNameValue/><CompanyNameValueCriteria/><PurchaseOrderNumber/><PurchaseOrderNumberCriteria/><EnquiryAutoNumber/><EnquiryAutoNumberCriteria/><BranchPlant/><BranchPlantCriteria/><BranchPlantCode/><BranchPlantCodeCriteria/><BranchPlantName/><BranchPlantNameCriteria/><DeliveryLocation/><DeliveryLocationCriteria/><Gratis/><GratisCriteria/><RequestDate/><RequestDateCriteria/><Status/><StatusCriteria/><OrderType>SO</OrderType><OrderDate/><OrderDateCriteria/><Empties/><EmptiesCriteria/><ReceivedCapacityPalates/><ReceivedCapacityPalatesCriteria/><StatusForChangeInPickShift/><StatusForChangeInPickShiftCriteria/><RoleMasterId>3</RoleMasterId><CultureId>1102</CultureId><ProductCodeData/><ProductCodeCriteria/><ProductName/><ProductNameCriteria/><ProductQuantity/><ProductQuantityCriteria/><ProductCode/><ProductSearchCriteria/><Description1/><Description1Criteria/><Description2/><Description2Criteria/><Province/><ProvinceCriteria/><OrderedBy/><OrderedByCriteria/><IsRPMPresent/><IsRPMPresentCriteria/><UserId>0</UserId><LoginId>8</LoginId></Json>'
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

DECLARE @PickShift nvarchar(150)
DECLARE @PickShiftCriteria nvarchar(50)


DECLARE @SchedulingDate nvarchar(150)
DECLARE @SchedulingDateCriteria nvarchar(50)


DECLARE @OrderType nvarchar(150)


DECLARE @OrderDate nvarchar(150)
DECLARE @OrderDateCriteria nvarchar(50)


DECLARE @PickUpDate nvarchar(150)
DECLARE @PickUpDateCriteria nvarchar(50)


DECLARE @ConfirmedPickUpDate nvarchar(150)
DECLARE @ConfirmedPickUpDateCriteria nvarchar(50)



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
DECLARE @TruckOutTime nvarchar(150)
DECLARE @TruckOutTimeCriteria nvarchar(50)

DECLARE @AllocatedPlateNo nvarchar(150)
DECLARE @AllocatedPlateNoCriteria nvarchar(50)

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
	    @PickShift = tmp.[PickShift],
	   @PickShiftCriteria = tmp.[PickShiftCriteria],
	     @SchedulingDate = tmp.[SchedulingDate],
	   @SchedulingDateCriteria = tmp.[SchedulingDateCriteria],
	   @OrderType = tmp.[OrderType],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@roleId = tmp.[RoleMasterId],
	@OrderDate = tmp.[OrderDate],
	   @OrderDateCriteria = tmp.[OrderDateCriteria],
	   @PickUpDate = tmp.[PickUpDate],
	@PickUpDateCriteria = tmp.[PickUpDateCriteria],
	@ConfirmedPickUpDate = tmp.[ConfirmedPickUpDate],
	@ConfirmedPickUpDateCriteria = tmp.[ConfirmedPickUpDateCriteria],	
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
	  @IsRPMPresent=tmp.[IsRPMPresent],
   	@IsRPMPresentCriteria=tmp.[IsRPMPresentCriteria],
   		@TruckOutTime = tmp.TruckOutTime,
	   @TruckOutTimeCriteria = tmp.TruckOutTimeCriteria,
	   @AllocatedPlateNo = tmp.AllocatedPlateNo,
	   @AllocatedPlateNoCriteria = tmp.AllocatedPlateNoCriteria,
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
			[PickShift] nvarchar(50),
			[PickShiftCriteria] nvarchar(50),
				[RoleMasterId] bigint,
			[OrderDate] nvarchar(150),
            [OrderDateCriteria] nvarchar(50),
				[PickUpDate] nvarchar(150),
			[PickUpDateCriteria] nvarchar(150),
			ConfirmedPickUpDate nvarchar(150),
			ConfirmedPickUpDateCriteria nvarchar(150),
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
			[TruckOutTime] nvarchar(150),
	   [TruckOutTimeCriteria] nvarchar(50),
	   [AllocatedPlateNo] nvarchar(150),
	   [AllocatedPlateNoCriteria] nvarchar(50),
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
 SET @whereClause = @whereClause + ' and (case when ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ExpectedTimeOfDelivery,ShipTo,SoldTo,ISNULL(CONVERT(bigint,Capacity),0))) < 0) then ''0'' else ''1'' end) =  ''' +@ReceivedCapacityPalates+ ''''
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
  
  SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    LIKE ''%' + @EnquiryAutoNumber + '%'''
  END
  IF @EnquiryAutoNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    NOT LIKE ''%' + @EnquiryAutoNumber + '%'''
  END
  IF @EnquiryAutoNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    LIKE ''' + @EnquiryAutoNumber + '%'''
  END
  IF @EnquiryAutoNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    LIKE ''%' + @EnquiryAutoNumber + ''''
  END          
  IF @EnquiryAutoNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    =  ''' +@EnquiryAutoNumber+ ''''
  END
  IF @EnquiryAutoNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 e.EnquiryAutoNumber from Enquiry e  where e.[EnquiryId]=txtp.[EnquiryId])    <>  ''' +@EnquiryAutoNumber+ ''''
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
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName LIKE ''%' + @BranchPlantName + '%'''
  END
  IF @BranchPlantNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName NOT LIKE ''%' + @BranchPlantName + '%'''
  END
  IF @BranchPlantNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName LIKE ''' + @BranchPlantName + '%'''
  END
  IF @BranchPlantNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName LIKE ''%' + @BranchPlantName + ''''
  END          
  IF @BranchPlantNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationName =  ''' +@BranchPlantName+ ''''
  END
  IF @BranchPlantNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationName <>  ''' +@BranchPlantName+ ''''
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

 --SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) =  N''' + @Status + ''''

 --SET @whereClause = @whereClause + ' and CurrentState = (select LookUpId from LookUp where Name= N''' + @Status + ''' and LookupCategory=7)'

 SET @whereClause = @whereClause + ' and CurrentState in (select Statusid from RoleWiseStatus where resourcekey= (select top 1 resourcekey from resources where resourceValue=N''' + @Status + ''' and PageName=''status'') and Roleid=' + CONVERT(NVARCHAR(10), @roleId)+')'

  END
  
END


IF @PickShift !=''
BEGIN
          
  IF @PickShiftCriteria = 'eq'
 BEGIN

 --SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) =  N''' + @Status + ''''

 --SET @whereClause = @whereClause + ' and CurrentState = (select LookUpId from LookUp where Name= N''' + @Status + ''' and LookupCategory=7)'

 SET @whereClause = @whereClause + ' and (case when (Select Name from lookup where lookupid=om.ExpectedShift) IS NOT NULL then (Select Name from lookup where lookupid=om.ExpectedShift) else (Select Name from lookup where lookupid=om.PraposedShift) END) = '''+@PickShift+''''

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




IF @PickUpDate !=''
BEGIN

  IF @PickUpDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PraposedTimeOfAction LIKE ''%' + @PickUpDate + '%'''
  END
  IF @PickUpDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PraposedTimeOfAction NOT LIKE ''%' + @PickUpDate + '%'''
  END
  IF @PickUpDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PraposedTimeOfAction LIKE ''' + @PickUpDate + '%'''
  END
  IF @PickUpDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PraposedTimeOfAction LIKE ''%' + @PickUpDate + ''''
  END          
  IF @PickUpDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),PraposedTimeOfAction,103) =  ''' + CONVERT(varchar(11),@PickUpDate,103) + ''''
  END
  IF @PickUpDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and PraposedTimeOfAction <>  ''' + @PickUpDate + ''''
  END
END




IF @ConfirmedPickUpDate !=''
BEGIN

  IF @ConfirmedPickUpDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ExpectedTimeOfAction LIKE ''%' + @ConfirmedPickUpDate + '%'''
  END
  IF @ConfirmedPickUpDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ExpectedTimeOfAction NOT LIKE ''%' + @ConfirmedPickUpDate + '%'''
  END
  IF @ConfirmedPickUpDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ExpectedTimeOfAction LIKE ''' + @ConfirmedPickUpDate + '%'''
  END
  IF @ConfirmedPickUpDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ExpectedTimeOfAction LIKE ''%' + @ConfirmedPickUpDate + ''''
  END          
  IF @ConfirmedPickUpDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),ExpectedTimeOfAction,103) =  ''' + CONVERT(varchar(11),@ConfirmedPickUpDate,103) + ''''
  END
  IF @ConfirmedPickUpDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ExpectedTimeOfAction <>  ''' + @ConfirmedPickUpDate + ''''
  END
END




IF @CompanyNameValue !=''
BEGIN

  IF @CompanyNameValueCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyName LIKE ''%' + @CompanyNameValue + '%'''
  END
  IF @CompanyNameValueCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyName NOT LIKE ''%' + @CompanyNameValue + '%'''
  END
  IF @CompanyNameValueCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyName LIKE ''' + @CompanyNameValue + '%'''
  END
  IF @CompanyNameValueCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyName LIKE ''%' + @CompanyNameValue + ''''
  END          
  IF @CompanyNameValueCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CompanyName =  ''' +@CompanyNameValue+ ''''
  END
  IF @CompanyNameValueCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and CompanyName <>  ''' +@CompanyNameValue+ ''''
  END
END


IF @UserName !=''
BEGIN

  IF @UserNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = CreatedBy) LIKE ''%' + @UserName + '%'''
  END
  IF @UserNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = CreatedBy) NOT LIKE ''%' + @UserName + '%'''
  END
  IF @UserNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = CreatedBy) LIKE ''' + @UserName + '%'''
  END
  IF @UserNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = CreatedBy) LIKE ''%' + @UserName + ''''
  END          
  IF @UserNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = CreatedBy) =  ''' +@UserName+ ''''
  END
  IF @UserNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 UserName from Login where LoginId = CreatedBy) <>  ''' +@UserName+ ''''
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





IF @TruckOutTime !=''
BEGIN

  IF @TruckOutTimeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckOutDateTime LIKE ''%' + @TruckOutTime + '%'''
  END
  IF @TruckOutTimeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckOutDateTime NOT LIKE ''%' + @TruckOutTime + '%'''
  END

  IF @TruckOutTimeCriteria = 'default'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ' + @TruckOutTime + ''
  END
  IF @TruckOutTimeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckOutDateTime LIKE ''' + @TruckOutTime + '%'''
  END
  IF @TruckOutTimeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckOutDateTime LIKE ''%' + @TruckOutTime + ''''
  END          
  IF @TruckOutTimeCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and TruckOutDateTime =  ''' + @TruckOutTime + ''''
  END
  IF @TruckOutTimeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckOutDateTime <>  ''' + @TruckOutTime + ''''
  END
END



IF @AllocatedPlateNo !=''
BEGIN

  IF @AllocatedPlateNoCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PlateNumberData LIKE ''%' + @AllocatedPlateNo + '%'''
  END
  IF @AllocatedPlateNoCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PlateNumberData NOT LIKE ''%' + @AllocatedPlateNo + '%'''
  END

  IF @AllocatedPlateNoCriteria = 'default'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ' + @AllocatedPlateNo + ''
  END
  IF @AllocatedPlateNoCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PlateNumberData LIKE ''' + @AllocatedPlateNo + '%'''
  END
  IF @AllocatedPlateNoCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PlateNumberData LIKE ''%' + @AllocatedPlateNo + ''''
  END          
  IF @AllocatedPlateNoCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and PlateNumberData =  ''' + @AllocatedPlateNo + ''''
  END
  IF @AllocatedPlateNoCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and PlateNumberData <>  ''' + @AllocatedPlateNo + ''''
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


IF @CarrierNumber !=''
BEGIN

  IF @CarrierNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CarrierNumberValue LIKE ''%' + @CarrierNumber + '%'''
  END
  IF @CarrierNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CarrierNumberValue NOT LIKE ''%' + @CarrierNumber + '%'''
  END
  IF @CarrierNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CarrierNumberValue LIKE ''' + @CarrierNumber + '%'''
  END
  IF @CarrierNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CarrierNumberValue LIKE ''%' + @CarrierNumber + ''''
  END          
  IF @CarrierNumberCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and CarrierNumberValue =  ''' + @CarrierNumber + ''''
  END
  IF @CarrierNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and CarrierNumberValue <>  ''' + @CarrierNumber + ''''
  END
END



IF @IsRPMPresent !=''
BEGIN
	if(@IsRPMPresent = '1')
	Begin
	SET @whereClause = @whereClause + ' and EnquiryId IN (select EnquiryId from ReturnPakageMaterial )'
	End
	Else
	Begin
	SET @whereClause = @whereClause + ' and EnquiryId NOT IN (select EnquiryId from ReturnPakageMaterial )'
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

SET @whereClause = @whereClause + ' and  SoldTo = ' + CONVERT(NVARCHAR(10), @userId)+''
END


If @roleId = 7
Begin 
	SET @whereClause = @whereClause + 'and CarrierNumber =(' + CONVERT(NVARCHAR(10), @userId)+')'

	IF @OrderType != 'SO'
		Begin 		
			SET @whereClause = @whereClause + 'and OrderType in (''ST'')'
		End
	ELSE
		BEGIN
			SET @whereClause = @whereClause + 'and OrderType in (''SO'')'
		END
End

If (@roleId = 7 Or @roleId = 5 Or @roleId = 6)
BEGIN

SET @whereClause = @whereClause + 'and OrderType not in (''SG'',''S5'',''S6'') and SalesOrderNumber is not null '
--(SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause] (@LoginId,'SSP_OrderGrid_Paging')) +''

	If (@roleId = 7 Or @roleId = 5)
		Begin
		
		if @TruckOutTimeCriteria != '' or @AllocatedPlateNoCriteria != ''
		BEGIN
		
			IF @TruckOutTimeCriteria != 'default' and @AllocatedPlateNoCriteria != 'default'
			BEGIN  
			
			SET @whereClause = @whereClause + 'and Currentstate !=1105'
			END
		END
		ELSE
		BEGIN
		
			SET @whereClause = @whereClause + 'and Currentstate !=1105'
		END
				Declare @settingValue nvarchar(50)
					SET @settingValue=(Select SettingValue from SettingMaster where SettingParameter='OrderShownToCarrier' and IsActive=1)
				If @settingValue=1
					BEGIN
						SET @whereClause = @whereClause + ' and om.PraposedTimeOfAction is not null and PraposedShift is not null'
					END
		End
END





SET @orderBy = 'Convert(date,ExpectedTimeOfAction) desc, ExpectedShift desc'





set @sql='WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((select  ''true'' AS [@json:Array],*,(SELECT Cast ((select ''true'' AS [@json:Array],OrderProductId,OrderId,ProductCode,ProductType,ItemType	,ItemName	,ProductQuantity,	ItemPricesPerUnit,	ItemPrices,
	DepositeAmountPerUnit	,ItemTotalDepositeAmount	,UOM,	ItemTax,	AssociatedOrder	,UsedQuantityInOrder
	,ProductAvailableQuantity,Remarks from OrderProductView  opv where opv.orderid=tmp.OrderId
  FOR XML path(''OrderProductList''),ELEMENTS) AS xml)),
  
     (select cast ((SELECT ''true'' AS [@json:Array], [ReturnPakageMaterialId]
      ,[EnquiryId]
      ,[ProductCode]
      ,[ItemId]
      ,[ItemName]
      ,[PrimaryUnitOfMeasure]
      ,[ProductType]
      ,[ProductQuantity]
      ,[StockInQuantity]
      ,[ItemShortCode]
      ,[ItemType]
  FROM [dbo].[ReturnPakageMaterialView] rpm
   WHERE rpm.EnquiryId = tmp.EnquiryId  
 FOR XML path(''ReturnPakageMaterialList''),ELEMENTS) AS xml)) from 
		(Select ROW_NUMBER() OVER (ORDER BY ISNULL(ExpectedTimeOfAction,ISNULL(ProposedTimeOfAction,ModifiedDate))) as [rownumber] ,* from ((Select 
		(Select Count(OrderId) FROM [dbo].[OrderGridView] txtp WHERE ' + @whereClause +' ) [TotalCount]
	  ,[OrderId]
	  ,[EnquiryId]
      ,[OrderType]
      ,ModifiedDate
      ,[OrderNumber]
      ,[HoldStatus]
      ,[TotalPrice]
      ,[SalesOrderNumber]
      ,[SOGratisNumber]
      ,[PurchaseOrderNumber]
      ,[ProposedShift]
      ,[ProposedTimeOfAction]
      ,[StatusForChangeInPickShift]
      ,[OrderDate]
      ,[DeliveryLocationName]
      ,[DeliveryLocation]
      ,[CompanyName]
      ,[CompanyMnemonic]
      ,[UserName]
      ,[ExpectedTimeOfDelivery]
      ,[RequestDate]
      ,[ReceivedCapacityPalettes]
      ,[Capacity]
      ,[IsRPMPresent]
      ,[EnquiryAutoNumber]
      ,[GratisCode]
      ,[Province]
      ,[OrderedBy]
      ,[Description1]
      ,[Description2]
      ,[CarrierNumberValue]
      ,[Field1]
      ,[Remarks]
      ,[CurrentState]
      ,[Status]
      ,[Class]

      ,[ShipTo]
      ,[SoldTo]
      ,[ReceivedCapacityPalettesCheck]
      ,[PrimaryAddressId]
      ,[SecondaryAddressId]
      ,[PrimaryAddress]
      ,[SecondaryAddress]
      ,[StockLocationId]
      ,[BranchPlantName]
      ,[DeliveryLocationBranchName]
      ,(Select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode=StockLocationId) as DeliveryLocationId
      ,[Empties]
      ,[EmptiesLimit]
      ,[ActualEmpties]
      ,[AssociatedOrder]
      ,[PreviousState]
      ,[TruckSizeId]
      ,[TruckSize]
      ,[Email]
      ,[PlateNumberData]
      ,[PlateNumber]
      ,[PreviousPlateNumber]
      ,[DriverName]
      ,[ProfileId]
      ,[TruckInPlateNumber]
      ,[TruckOutPlateNumber]
      ,[TruckInDateTime]
      ,[TruckOutDateTime]
      ,[CarrierNumber]
      ,[TruckRemark]
      ,[ExpectedShift]
      ,[ExpectedTimeOfAction]
      ,[DeliveryPersonnelId]
	   
  FROM [dbo].[OrderGridViewNew] ))txtp  WHERE ' + @whereClause +' )tmp Where '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'

print @sql
exec (@sql)

--;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) select cast ((SELECT 'true' AS [@json:Array]  , * FROM ( Select OrderId,OrderType,0 as rownumber,0 as TotalCount,OrderNumber,'' as HoldStatus,0 as TotalPrice,SalesOrderNumber,'-' as SOGratisNumber,PurchaseOrderNumber,'-' as ProposedShift,'-' as ProposedTimeOfAction,'-' as StatusForChangeInPickShift,OrderDate,'-' as DeliveryLocationName,'-' as DeliveryLocation,'-' as CompanyName,'-' as CompanyMnemonic,
--'-' as UserName,ExpectedTimeOfDelivery,'' as IsAvailableStock  ,'-' as RequestDate,'-' as ReceivedCapacityPalettes,'-' as Capacity,'-' as IsRPMPresent,'-' as EnquiryAutoNumber,'-' as ProductCode,'-' as ProductName,'-' as ProductQuantity,GratisCode,
--Province,OrderedBy,Description1,Description2,'-' as CarrierNumberValue,Field1,Remarks,CurrentState,'-' as Status,'-' as Class,ShipTo,SoldTo,'-' as ReceivedCapacityPalettesCheck,PrimaryAddressId,
--SecondaryAddressId,PrimaryAddress,SecondaryAddress,'-' as Note,StockLocationId,'-' as BranchPlantName,'-' as DeliveryLocationBranchName,'-' as Empties,
--'-' as EmptiesLimit,'-' as ActualEmpties,'-' as AssociatedOrder,PreviousState,TruckSizeId,'-' as TruckSize,'-' as Email,'-' as PlateNumberData,'-' as PlateNumber,'-' as PreviousPlateNumber,'-' as DriverName,'-' as ProfileId,
--'-' as TruckInPlateNumber,'-' as TruckOutPlateNumber,'-' as TruckInDateTime,'-' as TruckOutDateTime,CarrierNumber,'-' as TruckRemark,'-' as ExpectedShift,'-' as ExpectedTimeOfAction,'-' as DeliveryPersonnelId from [Order]) as tmp
--FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)




END