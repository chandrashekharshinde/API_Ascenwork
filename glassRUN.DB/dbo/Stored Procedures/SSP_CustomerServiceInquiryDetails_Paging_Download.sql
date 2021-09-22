Create PROCEDURE [dbo].[SSP_CustomerServiceInquiryDetails_Paging_Download] --'<Json><ServicesAction>GetAllEnquiryDetailsForExportforOM</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><CurrentState>1,7</CurrentState><RoleMasterId>3</RoleMasterId><CultureId>1101</CultureId><ProductCode></ProductCode><ProductSearchCriteria></ProductSearchCriteria></Json>'
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
DECLARE @whereClauseIcon NVARCHAR(max)
DECLARE @roleId bigint

Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(100)

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

DECLARE @EnquiryDate nvarchar(150)
DECLARE @EnquiryDateCriteria nvarchar(50)

DECLARE @SchedulingDate nvarchar(150)
DECLARE @SchedulingDateCriteria nvarchar(50)

DECLARE @SoldToCode  nvarchar(150)
DECLARE @SoldToCodeCriteria nvarchar(50)
DECLARE @CompanyNameValue nvarchar(150)
DECLARE @CompanyNameValueCriteria nvarchar(50)

DECLARE @Area nvarchar(150)
DECLARE @AreaCriteria nvarchar(50)

DECLARE @Empties nvarchar(150)
DECLARE @EmptiesCriteria nvarchar(50)

DECLARE @ReceivedCapacityPalates nvarchar(150)
DECLARE @ReceivedCapacityPalatesCriteria nvarchar(50)

DECLARE @IsAvailableStock nvarchar(150)
DECLARE @AvailableStockCriteria nvarchar(50)

DECLARE @ProductCode nvarchar(max)

DECLARE @ProductSearchCriteria nvarchar(100)

Declare @CultureId bigint


set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EnquiryAutoNumber = tmp.[EnquiryAutoNumber],
    @EnquiryAutoNumberCriteria = tmp.[EnquiryAutoNumberCriteria],
	@BranchPlant = tmp.[BranchPlant],
    @BranchPlantCriteria = tmp.[BranchPlantCriteria],
	@DeliveryLocation = tmp.[DeliveryLocation],
	@DeliveryLocationCriteria = tmp.[DeliveryLocationCriteria],
	@Gratis = tmp.[Gratis],
	@GratisCriteria = tmp.[GratisCriteria],
	@EnquiryDate = tmp.[EnquiryDate],
	@EnquiryDateCriteria = tmp.[EnquiryDateCriteria],

	@CompanyNameValue = tmp.[CompanyNameValue],
	@CompanyNameValueCriteria = tmp.[CompanyNameValueCriteria],

	@SoldToCode = tmp.[SoldToCode],
	@SoldToCodeCriteria = tmp.[SoldToCodeCriteria],

	@Area = tmp.[Area],
	@AreaCriteria = tmp.[AreaCriteria],

	@SchedulingDate = tmp.[SchedulingDate],
	@SchedulingDateCriteria = tmp.[SchedulingDateCriteria],
	@Status = tmp.[Status],
	@StatusCriteria = tmp.[StatusCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@roleId = tmp.[RoleMasterId],
	@Empties=tmp.[Empties],
   	@EmptiesCriteria=tmp.[EmptiesCriteria],
	@ReceivedCapacityPalates=tmp.[ReceivedCapacityPalates],
   	@ReceivedCapacityPalatesCriteria=tmp.[ReceivedCapacityPalatesCriteria],
	@IsAvailableStock=tmp.[IsAvailableStock],
   	@AvailableStockCriteria=tmp.[AvailableStockCriteria],
	@CultureId = [CultureId],
   @ProductCode = [ProductCode],
   @ProductSearchCriteria = [ProductSearchCriteria]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [EnquiryAutoNumber] nvarchar(150),
   [EnquiryAutoNumberCriteria] nvarchar(50),
   [BranchPlant]  nvarchar(150),
   [BranchPlantCriteria] nvarchar(50),

   [Area]  nvarchar(150),
   [AreaCriteria] nvarchar(50),

   [SoldToCode]  nvarchar(150),
   [SoldToCodeCriteria] nvarchar(50),
   [CompanyNameValue]  nvarchar(150),
   [CompanyNameValueCriteria] nvarchar(50),

   [DeliveryLocation] nvarchar(150),
  [DeliveryLocationCriteria] nvarchar(50),
	[Gratis] nvarchar(150),
  [GratisCriteria] nvarchar(50),
	[EnquiryDate] nvarchar(150),
  [EnquiryDateCriteria] nvarchar(50),
	[SchedulingDate] nvarchar(150),
  [SchedulingDateCriteria] nvarchar(50),
	[Status] nvarchar(150),
	[Empties] nvarchar(150),
	[EmptiesCriteria] nvarchar(150),
	[ReceivedCapacityPalates] nvarchar(150),
	[ReceivedCapacityPalatesCriteria] nvarchar(150),
		[IsAvailableStock] nvarchar(150),
	[AvailableStockCriteria] nvarchar(150),
  [StatusCriteria] nvarchar(50),
  [RoleMasterId] bigint,
  [CultureId] bigint,
   [ProductCode] nvarchar(500),
   [ProductSearchCriteria] nvarchar(100)
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'ModifiedDate  desc' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END

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


IF @BranchPlant !=''
BEGIN

  IF @BranchPlantCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and t.StockLocationId LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and t.StockLocationId NOT LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and t.StockLocationId LIKE ''' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and t.StockLocationId LIKE ''%' + @BranchPlant + ''''
  END          
  IF @BranchPlantCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and t.StockLocationId =  ''' +@BranchPlant+ ''''
  END
  IF @BranchPlantCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and t.StockLocationId <>  ''' +@BranchPlant+ ''''
  END
END


IF @CompanyNameValue !=''
BEGIN

  IF @CompanyNameValueCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,5) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,5)) end LIKE ''%' + @CompanyNameValue + '%'''
  END
  IF @CompanyNameValueCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,5) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,5)) end NOT LIKE ''%' + @CompanyNameValue + '%'''
  END
  IF @CompanyNameValueCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,5) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,5)) end LIKE ''' + @CompanyNameValue + '%'''
  END
  IF @CompanyNameValueCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,5) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,5)) end LIKE ''%' + @CompanyNameValue + ''''
  END          
  IF @CompanyNameValueCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,5) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,5)) end =  ''' +@CompanyNameValue+ ''''
  END
  IF @CompanyNameValueCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,5) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,5)) end <>  ''' +@CompanyNameValue+ ''''
  END
END


IF @SoldToCode !=''
BEGIN

  IF @SoldToCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SoldToCode LIKE ''%' + @SoldToCode + '%'''
  END
  IF @SoldToCodeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SoldToCode NOT LIKE ''%' + @SoldToCode + '%'''
  END
  IF @SoldToCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SoldToCode LIKE ''' + @SoldToCode + '%'''
  END
  IF @SoldToCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SoldToCode LIKE ''%' + @SoldToCode + ''''
  END          
  IF @SoldToCodeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and SoldToCode =  ''' +@SoldToCode+ ''''
  END
  IF @SoldToCodeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and SoldToCode <>  ''' +@SoldToCode+ ''''
  END
END



IF @Area !=''
BEGIN

  IF @AreaCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Area LIKE ''%' + @Area + '%'''
  END
  IF @AreaCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Area NOT LIKE ''%' + @Area + '%'''
  END
  IF @AreaCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Area LIKE ''' + @Area + '%'''
  END
  IF @AreaCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Area LIKE ''%' + @Area + ''''
  END          
  IF @AreaCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and Area =  ''' +@Area+ ''''
  END
  IF @AreaCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Area <>  ''' +@Area+ ''''
  END
END


IF @Empties !=''
BEGIN
 SET @whereClause = @whereClause + ' and (case when (c.ActualEmpties < 0) then ''C'' else ''W'' end) =  ''' +@Empties+ ''''
END


IF @IsAvailableStock !=''
BEGIN
 SET @whereClause = @whereClause + ' and (select [dbo].[fn_CheckStockValidation](t.EnquiryId)) =  ''' +@IsAvailableStock+ ''''
END


IF @ReceivedCapacityPalates !=''
BEGIN
 SET @whereClause = @whereClause + ' and (case when ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ISNULL(RequestDate,OrderProposedETD),t.ShipTo,t.SoldTo,ISNULL(CONVERT(bigint,Capacity),0))) < 0) then ''0'' else ''1'' end) =  ''' +@ReceivedCapacityPalates+ ''''
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

 SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',t.CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) =  N''' + @Status + ''''
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

IF @EnquiryDate !=''
BEGIN

  IF @EnquiryDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryDate LIKE ''%' + @EnquiryDate + '%'''
  END
  IF @EnquiryDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryDate NOT LIKE ''%' + @EnquiryDate + '%'''
  END
  IF @EnquiryDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryDate LIKE ''' + @EnquiryDate + '%'''
  END
  IF @EnquiryDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryDate LIKE ''%' + @EnquiryDate + ''''
  END          
  IF @EnquiryDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),EnquiryDate,103) =  ''' + CONVERT(varchar(11),@EnquiryDate,103) + ''''
  END
  IF @EnquiryDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EnquiryDate <>  ''' + @EnquiryDate + ''''
  END
END


IF @SchedulingDate !=''
BEGIN

  IF @SchedulingDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderProposedETD LIKE ''%' + @SchedulingDate + '%'''
  END
  IF @SchedulingDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderProposedETD NOT LIKE ''%' + @SchedulingDate + '%'''
  END
  IF @SchedulingDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderProposedETD LIKE ''' + @SchedulingDate + '%'''
  END
  IF @SchedulingDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderProposedETD LIKE ''%' + @SchedulingDate + ''''
  END          
  IF @SchedulingDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),OrderProposedETD,103) =  ''' + CONVERT(varchar(11),@SchedulingDate,103) + ''''
  END
  IF @SchedulingDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and OrderProposedETD <>  ''' + @SchedulingDate + ''''
  END
END


IF @ProductCode != ''
Begin 
	if @ProductSearchCriteria = 'Include'
		Begin
			SET @whereClause = @whereClause + 'and t.EnquiryId in (SELECT EnquiryId FROM EnquiryProduct WHERE ProductCode IN (SELECT * FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')) GROUP BY EnquiryId HAVING COUNT(*) >= (SELECT COUNT(*) FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')))'
		ENd
	Else
		Begin
			SET @whereClause = @whereClause + 'and t.EnquiryId not in (SELECT EnquiryId FROM EnquiryProduct WHERE ProductCode IN (SELECT * FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')) GROUP BY EnquiryId HAVING COUNT(*) >= (SELECT COUNT(*) FROM [dbo].[fnSplitValues] ('''+ CONVERT(NVARCHAR(500),@ProductCode) +''')))'
		ENd
End


 SET @sql = 'SELECT  [EnquiryId],
  rownumber,TotalCount,[EnquiryAutoNumber],[EnquiryType],
  DeliveryLocationName,
  case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end as DeliveryLocation ,
  DeliveryLocationCode,
  ModifiedDate,
  Area,
  CompanyName,
  CONVERT(varchar(11),RequestDate,103) as RequestDate,
  OrderProposedETD as OrderProposedETD,
  OrderProposedETD as OrderProposedETDDate,
  EnquiryDate as EnquiryDate, 
 ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ISNULL(RequestDate,OrderProposedETD),ShipTo,SoldTo,ISNULL(CONVERT(bigint,Capacity),0)))) as ReceivedCapacityPalettes,
       CONVERT(bigint,ISNULL(Capacity,0)) as Capacity,
  AssociatedOrder,
  CurrentState,
  Status,
  Class,
  ISNULL(TotalPrice,0) as TotalPrice,
  branchPlant,
  BranchPlantName,
  EmptiesLimit,
  ActualEmpties,
  Empties,
   ReceivedCapacityPalettesCheck,
  IsAvailableStock,
  NumberOfPalettes,
  TruckWeight,
  IsRecievingLocationCapacityExceed,
  CONVERT(XML,enquiryProduct) ,
  CONVERT(XML,CarrierList),
  ShipTo,
  CarrierNumber,
  SoldTo    
,[PreviousState]
      ,[TruckSizeId],
	  [TruckSize],
	  [SequenceNo],
	       	 ShipToCode,
		 SoldToCode,
 IsSelfCollectEnquiry,
 BranchPlantCode,
 CONVERT(varchar(11),PromisedDate,103) as PromisedDate from (SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(t.ModifiedDate,t.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,t.[EnquiryId],
  t.[EnquiryAutoNumber], 
  t.[EnquiryType] ,
  d.DeliveryLocationName,
  d.DeliveryLocationCode,
  ISNULL(t.ModifiedDate,t.CreatedDate) as ModifiedDate,
   ISNULL(d.Area,''-'') as Area,
     	 d.Capacity,
  case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,5) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,5)) end as CompanyName,
  t.RequestDate,
  t.OrderProposedETD,
  t.EnquiryDate,  
 (SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep where EnquiryId = t.EnquiryId and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) as AssociatedOrder,


  t.CurrentState,
   (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',t.CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) AS [Status],
  (SELECT [dbo].[fn_RoleWiseClass] (' + CONVERT(NVARCHAR(10), @roleId)+',t.CurrentState)) AS Class,
  (SELECT [dbo].[fn_GetTotalAmount] (t.EnquiryId,0)) AS TotalPrice,
  (select top 1 DeliveryLocationId from DeliveryLocation dl where DeliveryLocationCode = t.StockLocationId) as branchPlant,
   t.StockLocationId  as BranchPlantName,
 c.EmptiesLimit as EmptiesLimit,
  c.ActualEmpties as ActualEmpties,
  case when (c.ActualEmpties < 0) then ''C'' else ''W'' end as Empties,
  case when ((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ISNULL(RequestDate,OrderProposedETD),t.ShipTo,t.SoldTo,ISNULL(CONVERT(bigint,Capacity),0)))) < 0  then ''0'' else ''1'' end  as ReceivedCapacityPalettesCheck,
    (select [dbo].[fn_CheckStockValidation](t.EnquiryId)) as IsAvailableStock,
   t.NumberOfPalettes,
	  t.TruckWeight,
	   ISNULL(t.IsRecievingLocationCapacityExceed, 0) as IsRecievingLocationCapacityExceed,
   t.ShipTo ,
  (Select CompanyMnemonic from Company  where CompanyId in (select CarrierNumber from Route where DestinationId=t.ShipTo and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode in (t.StockLocationId)and TruckSizeId= t.TruckSizeId)) and CompanyType=28) as CarrierNumber,
     t.SoldTo,   
     '
	 set @sql1=' [PreviousState],
      t.[TruckSizeId],
	    ts.TruckSize +''''+  '' ('' + Convert(nvarchar(500),ISNULL(t.TruckWeight,0)) + '' / '' + Convert(nvarchar(500),ISNULL(ts.TruckCapacityWeight,0)) + '')''  as TruckSize,
	  t.[SequenceNo],
     	     d.DeliveryLocationCode as  ShipToCode,
			
	   c.CompanyMnemonic as SoldToCode,
	   ISNULL(c.Field1,'''') as IsSelfCollectEnquiry,
	   t.StockLocationId  as BranchPlantCode,
	   t.PromisedDate,
  (SELECT Cast ((SELECT  EnquiryProductId,EnquiryId
  ,ProductCode
  ,ProductType
  ,ProductQuantity  
  ,Price as UnitPrice
  ,DepositeAmount
  ,(ep.DepositeAmount * ep.ProductQuantity) as ItemTotalDepositeAmount
  ,[SequenceNo],
    ISNULL(ep.AssociatedOrder,0) as GratisOrderId,
     (SELECT ISNULL([dbo].[fn_UsedEnquiryQuantity] (ep.ProductCode,t.StockLocationId,t.CreatedDate),0))  as UsedQuantityInEnquiry,
	 0 as UsedQuantityInOrder,
	 (SELECT ISNULL([dbo].[fn_AvailableProductQuantity] (ep.ProductCode,t.StockLocationId),0)) as ProductAvailableQuantity
	 	  ,(Select top 1 ItemShortCode from Item where ItemCode=ep.ProductCode) as ItemShortCode
		  ,ep.ItemType
   FROM dbo.EnquiryProduct ep
  WHERE ep.IsActive=1 AND t.EnquiryId=ep.EnquiryId 
  FOR XML path(''EnquiryProductList''),ELEMENTS) AS xml)) AS enquiryProduct ,
  
  ( Select CAST((Select [CompanyId]
      ,[CompanyName]
      ,[CompanyMnemonic]
      ,[CompanyType]
      ,[ParentCompany]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId] 
	  From Company  where CompanyId in (select CarrierNumber from Route where DestinationId=t.ShipTo 
	  and OriginId=(select top 1 DeliveryLocationId from DeliveryLocation where DeliveryLocationCode in (t.StockLocationId)and TruckSizeId= t.TruckSizeId)) and CompanyType=28
	  
    
	 FOR XML path(''CarrierList''),ELEMENTS) AS xml)) AS CarrierList
   
    from [Enquiry] t left join  DeliveryLocation d 
    on t.shipto = d.DeliveryLocationId
    left join Company c on c.CompanyId = d.CompanyId
    left join LookUp l on l.LookUpId = t.CurrentState
    left join TruckSize ts on ts.TruckSizeId = t.TruckSizeId    
    WHERE t.IsActive = 1 and t.CurrentState in (1,7) and ' + @whereClause +'  ) as tmp where '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ''

  --WHERE ' + @whereClause + ' and tmp.rownumber between ' + CONVERT(NVARCHAR(10), @PageIndex) + ' and ' + CONVERT(NVARCHAR(10), @PageSize) + 'ORDER BY '+@orderBy+'   FOR XML path(''EnquiryList''),ELEMENTS,ROOT(''Json'')) AS XML)'
    PRINT @sql
  PRINT @sql1
   execute (@sql+@sql1)

 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 --EXEC sp_executesql @sql

END
