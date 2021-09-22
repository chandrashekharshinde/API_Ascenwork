CREATE PROCEDURE [dbo].[SSP_CustomerServiceAllGrtaisOrder_Paging] --'<Json><ServicesAction>LoadCustomerServiceGratisOrderDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><SalesOrderNumber></SalesOrderNumber><SalesOrderNumberCriteria></SalesOrderNumberCriteria><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><DeliveryLocation></DeliveryLocation><DeliveryLocationCriteria></DeliveryLocationCriteria><Gratis></Gratis><GratisCriteria></GratisCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><Description1></Description1><Description1Criteria></Description1Criteria><Description2></Description2><Description2Criteria></Description2Criteria><Province></Province><ProvinceCriteria></ProvinceCriteria><OrderedBy></OrderedBy><OrderedByCriteria></OrderedByCriteria><Status></Status><StatusCriteria></StatusCriteria><OrderType></OrderType><CompanyNameValue></CompanyNameValue><CompanyNameValueCriteria></CompanyNameValueCriteria><PurchaseOrderNumber></PurchaseOrderNumber><PurchaseOrderNumberCriteria></PurchaseOrderNumberCriteria><TruckSize></TruckSize><TruckSizeCriteria></TruckSizeCriteria><ProductCode></ProductCode><ProductCodeCriteria></ProductCodeCriteria><ProductQuantity></ProductQuantity><ProductQuantityCriteria></ProductQuantityCriteria><AssociatedOrder></AssociatedOrder><AssociatedOrderCriteria></AssociatedOrderCriteria><RoleMasterId>4</RoleMasterId><CultureId>1101</CultureId><UserName></UserName><UserNameCriteria></UserNameCriteria><UserId>592</UserId></Json>'
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
Declare @roleId bigint
Declare @userId bigint

Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)

DECLARE @SalesOrderNumber nvarchar(150)
DECLARE @SalesOrderNumberCriteria nvarchar(50)

DECLARE @EnquiryAutoNumber nvarchar(150)
DECLARE @EnquiryAutoNumberCriteria nvarchar(50)


DECLARE @PurchaseOrderNumber nvarchar(150)
DECLARE @PurchaseOrderNumberCriteria nvarchar(50)

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

DECLARE @CompanyNameValue nvarchar(150)
DECLARE @CompanyNameValueCriteria nvarchar(50)

DECLARE @Description1 nvarchar(150)
DECLARE @Description1Criteria nvarchar(50)


DECLARE @Description2 nvarchar(150)
DECLARE @Description2Criteria nvarchar(50)

DECLARE @Province nvarchar(150)
DECLARE @ProvinceCriteria nvarchar(50)

DECLARE @OrderedBy nvarchar(150)
DECLARE @OrderedByCriteria nvarchar(50)

DECLARE @TruckSize nvarchar(150)
DECLARE @TruckSizeCriteria nvarchar(50)

DECLARE @ProductCode nvarchar(150)
DECLARE @ProductCodeCriteria nvarchar(50)

DECLARE @ProductQuantity nvarchar(150)
DECLARE @ProductQuantityCriteria nvarchar(50)

Declare @CultureId bigint

DECLARE @AssociatedOrder nvarchar(150)
DECLARE @AssociatedOrderCriteria nvarchar(50)

DECLARE @UserName nvarchar(150)
DECLARE @UserNameCriteria nvarchar(50)


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
	@CompanyNameValue = tmp.[CompanyNameValue],
	@CompanyNameValueCriteria = tmp.[CompanyNameValueCriteria],
	@Description1 = tmp.[Description1],
    @Description1Criteria = tmp.[Description1Criteria],
    @Description2 = tmp.[Description2],
    @Description2Criteria = tmp.[Description2Criteria],
    @Province = tmp.[Province],
    @ProvinceCriteria = tmp.[ProvinceCriteria],
	@OrderedBy = tmp.[OrderedBy],
    @OrderedByCriteria = tmp.[OrderedByCriteria],
	@TruckSize = tmp.[TruckSize],
    @TruckSizeCriteria = tmp.[TruckSizeCriteria],
	@ProductCode = tmp.[ProductCode],
    @ProductCodeCriteria = tmp.[ProductCodeCriteria],
	@ProductQuantity = tmp.[ProductQuantity],
    @ProductQuantityCriteria = tmp.[ProductQuantityCriteria],

		@AssociatedOrder = tmp.[AssociatedOrder],
    @AssociatedOrderCriteria = tmp.[AssociatedOrderCriteria],

	@OrderType = tmp.[OrderType],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@roleId = tmp.[RoleMasterId],
	@CultureId = [CultureId],
	    @UserName = [UserName],
   @UserNameCriteria = [UserNameCriteria],
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
			Description1 nvarchar(50),
   Description1Criteria nvarchar(50),
   Description2 nvarchar(50),
   Description2Criteria nvarchar(50),
   [Province] nvarchar(150),
            [ProvinceCriteria] nvarchar(50),
			[OrderedBy] nvarchar(150),
            [OrderedByCriteria] nvarchar(50),
			[TruckSize] nvarchar(150),
            [TruckSizeCriteria] nvarchar(50),
			[ProductCode] nvarchar(150),
            [ProductCodeCriteria] nvarchar(50),
			[ProductQuantity] nvarchar(150),
            [ProductQuantityCriteria] nvarchar(50),

			[AssociatedOrder] nvarchar(150),
            [AssociatedOrderCriteria] nvarchar(50),

			[Gratis] nvarchar(150),
            [GratisCriteria] nvarchar(50),
			[CompanyNameValue]  nvarchar(150),
            [CompanyNameValueCriteria] nvarchar(50),
			[Status] nvarchar(150),
            [StatusCriteria] nvarchar(50),
			[RoleMasterId] bigint,
			[CultureId] bigint,
			[UserName] nvarchar(150),
            [UserNameCriteria] nvarchar(50),
			[UserId] bigint
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'OrderId' END


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
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''%' + @EnquiryAutoNumber + '%'''
  END
  IF @EnquiryAutoNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber NOT LIKE ''%' + @EnquiryAutoNumber + '%'''
  END
  IF @EnquiryAutoNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''' + @EnquiryAutoNumber + '%'''
  END
  IF @EnquiryAutoNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''%' + @EnquiryAutoNumber + ''''
  END          
  IF @EnquiryAutoNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and EnquiryAutoNumber =  ''' +@EnquiryAutoNumber+ ''''
  END
  IF @EnquiryAutoNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EnquiryAutoNumber <>  ''' +@EnquiryAutoNumber+ ''''
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

 SET @whereClause = @whereClause + ' and o.StockLocationId <>  ''' +@BranchPlant+ ''''
  END
END


IF @DeliveryLocation !=''
BEGIN

  IF @DeliveryLocationCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end LIKE ''%' + @DeliveryLocation + '%'''
  END
  IF @DeliveryLocationCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end NOT LIKE ''%' + @DeliveryLocation + '%'''
  END
  IF @DeliveryLocationCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end LIKE ''' + @DeliveryLocation + '%'''
  END
  IF @DeliveryLocationCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end LIKE ''%' + @DeliveryLocation + ''''
  END          
  IF @DeliveryLocationCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end =  ''' + @DeliveryLocation + ''''
  END
  IF @DeliveryLocationCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end <>  ''' + @DeliveryLocation + ''''
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


IF @AssociatedOrder !=''
BEGIN

  IF @AssociatedOrderCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AssociatedOrder LIKE ''%' + @AssociatedOrder + '%'''
  END
  IF @AssociatedOrderCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AssociatedOrder NOT LIKE ''%' + @AssociatedOrder + '%'''
  END
  IF @AssociatedOrderCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AssociatedOrder LIKE ''' + @AssociatedOrder + '%'''
  END
  IF @AssociatedOrderCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and AssociatedOrder LIKE ''%' + @AssociatedOrder + ''''
  END          
  IF @AssociatedOrderCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and AssociatedOrder =  ''' + @AssociatedOrder + ''''
  END
  IF @AssociatedOrderCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and AssociatedOrder <>  ''' + @AssociatedOrder + ''''
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


IF @ProductCode !=''
BEGIN

  IF @ProductCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductCode LIKE ''%' + @ProductCode + '%'''
  END
  IF @ProductCodeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductCode NOT LIKE ''%' + @ProductCode + '%'''
  END
  IF @ProductCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductCode LIKE ''' + @ProductCode + '%'''
  END
  IF @ProductCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ProductCode LIKE ''%' + @ProductCode + ''''
  END          
  IF @ProductCodeCriteria = 'eq'
 BEGIN

 SET @whereClause =  @whereClause + ' and ProductCode =  ''' + @ProductCode + ''''
  END
  IF @ProductCodeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ProductCode <>  ''' + @ProductCode + ''''
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


if @roleId=4
BEGIN
Print @roleId
SET @whereClause = @whereClause + ' and  o.SoldTo = ' + CONVERT(NVARCHAR(10), @userId)+''
END




SET @orderBy = 'ModifiedDate desc'



 SET @sql = ' WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT ''true'' AS [@json:Array],  tmp.rownumber,tmp.TotalCount,tmp.OrderId,tmp.OrderType,
tmp.OrderNumber,
  tmp.SalesOrderNumber,
  PurchaseOrderNumber,
  OrderDate,
  DeliveryLocationName,
  case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end as DeliveryLocation ,
  CompanyName,
  UserName,
CONVERT(varchar(11),tmp.ExpectedTimeOfDelivery,103) as ExpectedTimeOfDelivery,
 --ISNULL((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ExpectedTimeOfDelivery,ShipTo,SoldTo)),0) as ReceivedCapacityPalettes,
   (SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ExpectedTimeOfDelivery,ShipTo,SoldTo,ISNULL(CONVERT(bigint,Capacity),0))) as ReceivedCapacityPalettes,
     ISNULL(CONVERT(bigint,Capacity),0) as Capacity,
--ISNULL((select top 1 SalesOrderNumber  from [Order] where OrderId in (select top 1 OrderId from OrderProduct 
--where AssociatedOrder in (select top 1 OrderId from [Order] where OrderId  = tmp.OrderId and IsActive = 1) and IsActive = 1) ),''-'') as AssociatedOrder  ,
AssociatedOrder,
EnquiryAutoNumber,
  Remarks,
  CurrentState,
  Status,
  Class,
  CONVERT(XML,enquiryProduct) ,
  ShipTo,
  Province,
  OrderedBy,
  SoldTo,  
  Description1,
  Description2,
   GratisCode,
  PrimaryAddressId
    ,[SecondaryAddressId]
     ,[PrimaryAddress]
      ,[SecondaryAddress]  
	  ,CONVERT(decimal(18,0),ProductQuantity) as ProductQuantity
	    ,ProductCode
     ,StockLocationId,
	 BranchPlantName,
	 EmptiesLimit,
  ActualEmpties
	 ,AssociatedOrder
      ,[PreviousState]
      ,[TruckSizeId],
	  [TruckSize] from (SELECT ROW_NUMBER() OVER (ORDER BY ISNULL(o.ModifiedDate,o.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount, o.OrderId,o.OrderType,
  o.OrderNumber,  
  o.OrderDate , 
   ISNULL(o.ModifiedDate,o.CreatedDate) as ModifiedDate,
  d.DeliveryLocationName,
  d.DeliveryLocationCode,
  case when SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0))='''' then SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5) else isnull(SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0)),SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5)) end as CompanyName,
   (select top 1 UserName from Login where LoginId = o.CreatedBy) as UserName,
  o.ExpectedTimeOfDelivery,
  IsNULl( o.SalesOrderNumber,''-'') as SalesOrderNumber  ,  
  IsNULl(o.PurchaseOrderNumber,''-'') as PurchaseOrderNumber  , 
   	 d.Capacity,
  o.Remarks,
  o.CurrentState,
  --(SELECT [dbo].[fn_LookupValueById] (o.CurrentState)) AS Status,
   (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',o.CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) AS ''Status'',
  (SELECT [dbo].[fn_RoleWiseClass] (' + CONVERT(NVARCHAR(10), @roleId)+',o.CurrentState)) AS ''Class'',
  ISNULL((select EnquiryAutoNumber from Enquiry where EnquiryId = o.EnquiryId),''-'') as EnquiryAutoNumber,
  --l.Name as Status,
  o.ShipTo ,
   o.Province ,
   o.OrderedBy,
     o.SoldTo,  
		 o.Description1,
		 o.Description2,
		 '
		 set @sql1=' o.GratisCode,
         o.PrimaryAddressId,
  [SecondaryAddressId],
      [PrimaryAddress],
      [SecondaryAddress] ,
	  (select top 1 ProductCode from OrderProduct where OrderId =  o.OrderId) as ProductCode,
	  (select top 1 ProductQuantity from OrderProduct where OrderId =  o.OrderId) as ProductQuantity,
     (Select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode=o.StockLocationId) as StockLocationId ,
	 (select top 1 DeliveryLocationCode from DeliveryLocation dl where DeliveryLocationCode = o.StockLocationId) as BranchPlantName,
	 (select top 1 EmptiesLimit from Company where companyid = o.SoldTo) as EmptiesLimit,
(select top 1 ActualEmpties from Company where companyid = o.SoldTo) as ActualEmpties,

	  (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]   where IsActive=1 and orderId in ( select AssociatedOrder from [OrderProduct] op where OrderId = o.OrderId and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) as AssociatedOrder,
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
            
    WHERE o.IsActive = 1 and  o.OrderType in (''SG'',''S5'',''S6'') and '  + @whereClause +'  ) as tmp where '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'


   --WHERE ' + @whereClause + ' and tmp.rownumber between ' + CONVERT(NVARCHAR(10), @PageIndex) + ' and ' + CONVERT(NVARCHAR(10), @PageSize) + 'ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'
   
   --erro
     execute (@sql+@sql1)
 PRINT @sql
 Print @sql1


END
