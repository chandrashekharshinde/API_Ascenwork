
CREATE PROCEDURE [dbo].[SSP_PaymentRequestDetails_Paging]--'<Json><ServicesAction>LoadPaymentRequestList</ServicesAction><PageIndex>0</PageIndex><PageSize>21</PageSize><OrderBy>SalesOrderNumber</OrderBy><OrderByCriteria>asc</OrderByCriteria><OrderNumber></OrderNumber><OrderNumberCriteria></OrderNumberCriteria><SoldToName></SoldToName><SoldToNameCriteria></SoldToNameCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><SlabName></SlabName><SlabNameCriteria></SlabNameCriteria><CarrierName></CarrierName><CarrierNameCriteria></CarrierNameCriteria><BankName></BankName><BankNameCriteria></BankNameCriteria><AccountNumber></AccountNumber><AccountNumberCriteria></AccountNumberCriteria><IsExportToExcel>0</IsExportToExcel><RoleMasterId>9</RoleMasterId><LoginId>404</LoginId><CultureId>1101</CultureId><CollectedDate>31/01/2019</CollectedDate><CollectedDateCriteria>&gt;=</CollectedDateCriteria><DeliveredDate></DeliveredDate><DeliveredDateCriteria></DeliveredDateCriteria><DriverName></DriverName><DriverNameCriteria></DriverNameCriteria><TruckPlateNumber></TruckPlateNumber><TruckPlateNumberCriteria></TruckPlateNumberCriteria></Json>'
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

Declare @OrderByClause NVARCHAR(500)
Declare @OrderBy NVARCHAR(100)
Declare @OrderByCriteria NVARCHAR(100)


Declare @OrderNumber NVARCHAR(250)
Declare @OrderNumberCriteria NVARCHAR(250)


Declare @SoldToName NVARCHAR(250)
Declare @SoldToNameCriteria NVARCHAR(250)


Declare @RequestDate NVARCHAR(250)
Declare @RequestDateCriteria NVARCHAR(250)


Declare @SlabName NVARCHAR(250)
Declare @SlabNameCriteria NVARCHAR(250)


Declare @BankName  NVARCHAR(250)
Declare @BankNameCriteria NVARCHAR(250)


Declare @CarrierName NVARCHAR(250)
Declare @CarrierNameCriteria NVARCHAR(250)


Declare @AccountNumber NVARCHAR(250)
Declare @AccountNumberCriteria NVARCHAR(250)



Declare @CollectedDate NVARCHAR(250)
Declare @CollectedDateCriteria NVARCHAR(250)


Declare @DeliveredDate NVARCHAR(250)
Declare @DeliveredDateCriteria NVARCHAR(250)


Declare @DriverName NVARCHAR(250)
Declare @DriverNameCriteria NVARCHAR(250)



Declare @TruckPlateNumber NVARCHAR(250)
Declare @TruckPlateNumberCriteria NVARCHAR(250)


DECLARE @Status nvarchar(150)
DECLARE @StatusCriteria nvarchar(50)


declare @LoginId bigint

Declare @CultureId bigint

Declare @IsExportToExcel nvarchar(2) ='0'
Declare @PaginationClause nvarchar(max)
set  @PaginationClause =''

set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
	   @Orderby = tmp.[Orderby],
	@OrderbyCriteria = tmp.[OrderbyCriteria],
    @OrderNumber = tmp.[OrderNumber],
	@OrderNumberCriteria = tmp.[OrderNumberCriteria],
	  @SoldToName = tmp.[SoldToName],
	@SoldToNameCriteria = tmp.[SoldToNameCriteria],
	  @RequestDate = tmp.[RequestDate],
	@RequestDateCriteria = tmp.[RequestDateCriteria],
	  @SlabName = tmp.[SlabName],
	@SlabNameCriteria = tmp.[SlabNameCriteria],
	  @CarrierName = tmp.[CarrierName],
	@CarrierNameCriteria = tmp.[CarrierNameCriteria],
	  @BankName = tmp.[BankName],
	@BankNameCriteria = tmp.[BankNameCriteria],
	  @AccountNumber= tmp.[AccountNumber],
	@AccountNumberCriteria = tmp.[AccountNumberCriteria],
	@roleId = tmp.[RoleMasterId],
	@CultureId = [CultureId],
 
   @LoginId = tmp.[LoginId],
   @IsExportToExcel = tmp.[IsExportToExcel],
     @CollectedDate= tmp.[CollectedDate],
	@CollectedDateCriteria = tmp.[CollectedDateCriteria],
	  @DeliveredDate = tmp.[DeliveredDate],
	@DeliveredDateCriteria = tmp.[DeliveredDateCriteria],
	  @DriverName = tmp.[DriverName],
	@DriverNameCriteria = tmp.[DriverNameCriteria],
	  @TruckPlateNumber = tmp.[TruckPlateNumber],
	@TruckPlateNumberCriteria = tmp.[TruckPlateNumberCriteria],
	 @Status = tmp.[Status],
	   @StatusCriteria = tmp.[StatusCriteria]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [OrderByCriteria] nvarchar(2000),
   [OrderNumber] nvarchar(2000),
   [OrderNumberCriteria] nvarchar(2000),
   [SoldToName] nvarchar(2000),
   [SoldToNameCriteria] nvarchar(2000),
   [RequestDate] nvarchar(2000),
   [RequestDateCriteria] nvarchar(2000),
   [SlabName] nvarchar(2000),
   [SlabNameCriteria] nvarchar(2000),
   [CarrierName] nvarchar(2000),
   [CarrierNameCriteria] nvarchar(2000),
   [BankName] nvarchar(2000),
   [BankNameCriteria] nvarchar(2000),
   [AccountNumber] nvarchar(2000),
   [AccountNumberCriteria] nvarchar(2000),
  
  [RoleMasterId] bigint,
  [CultureId] bigint,
  [LoginId] bigint,
    [IsExportToExcel] bit,
 [CollectedDate] nvarchar(2000),
 [CollectedDateCriteria] nvarchar(2000),
   [DeliveredDate] nvarchar(2000),
	    [DeliveredDateCriteria] nvarchar(2000),
	 [DriverName] nvarchar(2000),
  [DriverNameCriteria] nvarchar(2000),
 [TruckPlateNumber] nvarchar(2000),
  [TruckPlateNumberCriteria] nvarchar(2000),
  [Status] nvarchar(150),
            [StatusCriteria] nvarchar(50)
   )tmp
   
IF(RTRIM(@OrderBy) = '') BEGIN
 SET @OrderByClause = ' ISNULL(pr.UpdatedDate,pr.CreatedDate) desc' END
Else BEGIN set @OrderByClause = ''+@OrderBy+' '+@OrderByCriteria END

print @OrderByClause

SET @OrderByClause = ' pr.RequestDate desc'


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END


IF @OrderNumber !=''
BEGIN

  IF @OrderNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.OrderNumber LIKE ''%' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.OrderNumber NOT LIKE ''%' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.OrderNumber LIKE ''' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.OrderNumber LIKE ''%' + @OrderNumber + ''''
  END          
  IF @OrderNumberCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and o.OrderNumber =  ''' +@OrderNumber+ ''''
  END
  IF @OrderNumberCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and o.OrderNumber <>  ''' +@OrderNumber+ ''''
  END
END






IF @SoldToName !=''
BEGIN

  IF @SoldToNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.SoldToName LIKE ''%' + @SoldToName + '%'''
  END
  IF @SoldToNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.SoldToName NOT LIKE ''%' + @SoldToName + '%'''
  END
  IF @SoldToNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.SoldToName LIKE ''' + @SoldToName + '%'''
  END
  IF @SoldToNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.SoldToName LIKE ''%' + @SoldToName + ''''
  END          
  IF @SoldToNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and o.SoldToName =  ''' +@SoldToName+ ''''
  END
  IF @SoldToNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and o.SoldToName <>  ''' +@SoldToName+ ''''
  END
END







IF @SlabName !=''
BEGIN

  IF @SlabNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pr.SlabName LIKE ''%' + @SlabName + '%'''
  END
  IF @SlabNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pr.SlabName NOT LIKE ''%' + @SlabName + '%'''
  END
  IF @SlabNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pr.SlabName LIKE ''' + @SlabName + '%'''
  END
  IF @SlabNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pr.SlabName LIKE ''%' + @SlabName + ''''
  END          
  IF @SlabNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and pr.SlabName =  ''' +@SlabName+ ''''
  END
  IF @SlabNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and pr.SlabName <>  ''' +@SlabName+ ''''
  END
END





IF @CarrierName !=''
BEGIN

  IF @CarrierNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''%' + @CarrierName + '%'''
  END
  IF @CarrierNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyName NOT LIKE ''%' + @CarrierName + '%'''
  END
  IF @CarrierNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''' + @CarrierName + '%'''
  END
  IF @CarrierNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and c.CompanyName LIKE ''%' + @CarrierName + ''''
  END          
  IF @CarrierNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and c.CompanyName =  ''' +@CarrierName+ ''''
  END
  IF @CarrierNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and c.CompanyName <>  ''' +@CarrierName+ ''''
  END
END





IF @BankName !=''
BEGIN

  IF @BankNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  tad.BankName LIKE ''%' + @BankName + '%'''
  END
  IF @BankNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  tad.BankName NOT LIKE ''%' + @BankName + '%'''
  END
  IF @BankNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  tad.BankName LIKE ''' + @BankName + '%'''
  END
  IF @BankNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  tad.BankName LIKE ''%' + @BankName + ''''
  END          
  IF @BankNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and  tad.BankName =  ''' +@BankName+ ''''
  END
  IF @BankNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and  tad.BankName <>  ''' +@BankName+ ''''
  END
END





IF @AccountNumber !=''
BEGIN

  IF @AccountNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  tad.AccountNumber LIKE ''%' + @AccountNumber + '%'''
  END
  IF @AccountNumberCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  tad.AccountNumber NOT LIKE ''%' + @AccountNumber + '%'''
  END
  IF @AccountNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  tad.AccountNumber LIKE ''' + @AccountNumber + '%'''
  END
  IF @AccountNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  tad.AccountNumber LIKE ''%' + @AccountNumber + ''''
  END          
  IF @AccountNumberCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and tad.AccountNumber =  ''' +@AccountNumber+ ''''
  END
  IF @AccountNumberCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and  tad.AccountNumber <>  ''' +@AccountNumber+ ''''
  END
END




IF @RequestDate !=''
BEGIN
	IF @RequestDateCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,pr.RequestDate,103) = CONVERT(date,'''+@RequestDate+''',103)'
		END
	Else IF @RequestDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,pr.RequestDate,103) >= CONVERT(date,'''+@RequestDate+''',103)'
		END
	Else IF @RequestDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,pr.RequestDate,103) < CONVERT(date,'''+@RequestDate+''',103)'
		END
END



IF @CollectedDate !=''
BEGIN
	IF @CollectedDateCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,(select ISNULL(om.ActualTimeOfAction, om.ExpectedTimeOfAction)  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  ) ,103) = CONVERT(date,'''+@CollectedDate+''',103)'
		END
	Else IF @CollectedDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,(select ISNULL(om.ActualTimeOfAction, om.ExpectedTimeOfAction)  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  ) ,103) >= CONVERT(date,'''+@CollectedDate+''',103)'
		END
	Else IF @CollectedDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,(select ISNULL(om.ActualTimeOfAction, om.ExpectedTimeOfAction)  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  ) ,103) < CONVERT(date,'''+@CollectedDate+''',103)'
		END
END





IF @DeliveredDate !=''
BEGIN
	IF @DeliveredDateCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,(select ISNULL(om.ActualTimeOfAction, om.ExpectedTimeOfAction)  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=2  ),103) = CONVERT(date,'''+@DeliveredDate+''',103)'
		END
	Else IF @DeliveredDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,(select ISNULL(om.ActualTimeOfAction, om.ExpectedTimeOfAction)  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=2  ),103) >= CONVERT(date,'''+@DeliveredDate+''',103)'
		END
	Else IF @DeliveredDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,(select ISNULL(om.ActualTimeOfAction, om.ExpectedTimeOfAction)  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=2  ),103) < CONVERT(date,'''+@DeliveredDate+''',103)'
		END
END





IF @DriverName !=''
BEGIN

  IF @DriverNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (select   UserName   From Login  where loginid  in (select DeliveryPersonnelId  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  )) LIKE ''%' + @DriverName + '%'''
  END
  IF @DriverNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (select   UserName   From Login  where loginid  in (select DeliveryPersonnelId  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  )) NOT LIKE ''%' + @DriverName + '%'''
  END
  IF @DriverNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (select   UserName   From Login  where loginid  in (select DeliveryPersonnelId  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  )) LIKE ''' + @DriverName + '%'''
  END
  IF @DriverNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (select   UserName   From Login  where loginid  in (select DeliveryPersonnelId  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  )) LIKE ''%' + @DriverName + ''''
  END          
  IF @DriverNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (select   UserName   From Login  where loginid  in (select DeliveryPersonnelId  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  )) =  ''' +@DriverName+ ''''
  END
  IF @DriverNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and  (select   UserName   From Login  where loginid  in (select DeliveryPersonnelId  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  )) <>  ''' +@DriverName+ ''''
  END
END




IF @TruckPlateNumber !=''
BEGIN

  IF @TruckPlateNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (select   TOP 1 TruckPlateNumber FROM  OrderLogistics  WHERE   OrderMovementId  IN (SELECT OrderMovementId fROM  OrderMovement om WHERE om.ORDERID=OrderId) ) LIKE ''%' + @TruckPlateNumber + '%'''
  END
  IF @TruckPlateNumberCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (select   TOP 1 TruckPlateNumber FROM  OrderLogistics  WHERE   OrderMovementId  IN (SELECT OrderMovementId fROM  OrderMovement om WHERE om.ORDERID=OrderId) ) NOT LIKE ''%' + @TruckPlateNumber + '%'''
  END
  IF @TruckPlateNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (select   TOP 1 TruckPlateNumber FROM  OrderLogistics  WHERE   OrderMovementId  IN (SELECT OrderMovementId fROM  OrderMovement om WHERE om.ORDERID=OrderId) ) LIKE ''' + @TruckPlateNumber + '%'''
  END
  IF @TruckPlateNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  (select   TOP 1 TruckPlateNumber FROM  OrderLogistics  WHERE   OrderMovementId  IN (SELECT OrderMovementId fROM  OrderMovement om WHERE om.ORDERID=OrderId) ) LIKE ''%' + @TruckPlateNumber + ''''
  END          
  IF @TruckPlateNumberCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (select   TOP 1 TruckPlateNumber FROM  OrderLogistics  WHERE   OrderMovementId  IN (SELECT OrderMovementId fROM  OrderMovement om WHERE om.ORDERID=OrderId) ) =  ''' +@TruckPlateNumber+ ''''
  END
  IF @TruckPlateNumberCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and  (select   TOP 1 TruckPlateNumber FROM  OrderLogistics  WHERE   OrderMovementId  IN (SELECT OrderMovementId fROM  OrderMovement om WHERE om.ORDERID=OrderId) ) <>  ''' +@TruckPlateNumber+ ''''
  END
END



IF @Status !=''
BEGIN
          
  IF @StatusCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Pr.Status in (select Statusid from RoleWiseStatus where resourcekey= (select top 1 resourcekey from resources where resourceValue=N''' + @Status + ''' and PageName=''status'') and Roleid=' + CONVERT(NVARCHAR(10), @roleId)+')'

  END
  
END


SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)



If @IsExportToExcel != '0'
Begin
	print 'true'		
		
	SET @PaginationClause = '1=1'
End
Else
			Begin
		print 'false'
			SET @PaginationClause = '('+CONVERT(NVARCHAR(10), @PageSize)+' = 0 OR tmp.[rownumber] BETWEEN ('+CONVERT(NVARCHAR(10), @PageIndex)+')  AND ('+CONVERT(NVARCHAR(10), @PageSize)+'))'
		ENd

		print @PaginationClause
		
--SET @whereClause = @whereClause + ''+ (SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause] (@LoginId,'SSP_CustomerServiceInquiryDetails_Paging')) +''
print '1'

print '@OrderByClause' +  @OrderByClause;
print '@@whereClause' +  @whereClause;
print '@@PaginationClause' +  @PaginationClause;


 SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT  ''true'' AS [@json:Array]  ,rownumber ,TotalCount ,
 PaymentRequestId, OrderNumber ,SalesOrderNumber, PurchaseOrderNumber,
 SoldToName,
 SoldToCode,
 SlabName , 
 SlabReason , Amount , Status ,RequestDate , ApprovalDate ,ApproveBy,
 CompanyId,
 CarrrierCode,
 CarrierName,
 CarrierNumber,
 OrderId,
 BankName,
 AccountNumber,
 TripCost,
 TripRevenue,
 StatusDescription,
 Class,
 CollectedDate,
 DeliveredDate,
 DriverName,
 TruckPlateNumber
 from (SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderByClause+') as rownumber , COUNT(*) OVER () as TotalCount,PaymentRequestId, o.OrderNumber ,o.SalesOrderNumber, o.PurchaseOrderNumber, o.SoldToName, o.SoldToCode,
 SlabName , SlabReason ,Amount , Status , RequestDate ,ApprovalDate ,  ApproveBy , c.CompanyId, c.CompanyMnemonic  as ''CarrrierCode''  ,  c.CompanyName    as ''CarrierName''  , tad.BankName , 
 tad.AccountNumber ,o.CarrierNumber,o.OrderId,
Isnull(otc.[TripCost],0) as [TripCost],
Isnull(otc.[TripRevenue],0) as [TripRevenue],
(SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',Pr.Status,'+ CONVERT(NVARCHAR(10), @CultureId) +')) AS [StatusDescription],
  (SELECT [dbo].[fn_RoleWiseClass] (' + CONVERT(NVARCHAR(10), @roleId)+',Pr.Status)) AS Class,

  (select ISNULL(om.ActualTimeOfAction, om.ExpectedTimeOfAction)  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  ) as ''CollectedDate'',

 (select   UserName   From Login  where loginid  in (select DeliveryPersonnelId  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=1  )) as ''DriverName'',
  
  (select ISNULL(om.ActualTimeOfAction, om.ExpectedTimeOfAction)  From OrderMovement  om where om.OrderId =o.orderid     and LocationType=2  ) as ''DeliveredDate'',
  (select TOP 1 TruckPlateNumber FROM  OrderLogistics  WHERE   OrderMovementId  IN (SELECT top 1 OrderMovementId fROM  OrderMovement om WHERE om.ORDERID=o.OrderId) and isactive = 1 ) AS ''TruckPlateNumber''
  
 
 from    (select  PaymentRequestId ,  orderid,  SlabId,   slabname,Amount   ,Status   ,TransporterAccountDetailId , RequestDate  , SlabReason , ApprovalDate ,ApproveBy  ,IsActive From PaymentRequest   
union
select  PaymentRequestId ,  orderid,  SlabId,   slabname,Amount   ,Status   ,TransporterAccountDetailId , RequestDate  , SlabReason , ApprovalDate ,ApproveBy ,IsActive From PaymentRequestHistory  
 )  Pr  join  [order] o  on   pr.orderid=o.OrderId and Status in (2201,2202,2203)
 
 left join  Company   c  on c.CompanyId =o.CarrierNumber
 left join  TransporterAccountDetail  TAD  on TAD.TransporterAccountDetailId = pr.TransporterAccountDetailId 
 left join OrderTripCost  otc on otc.OrderId  = o.OrderId


    WHERE pr.IsActive = 1   and ' + @whereClause +'  ) as tmp where ' + @PaginationClause +' 
	FOR XML PATH(''PaymentRequestList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  --WHERE ' + @whereClause + ' and tmp.rownumber between ' + CONVERT(NVARCHAR(10), @PageIndex) + ' and ' + CONVERT(NVARCHAR(10), @PageSize) + 'ORDER BY '+@orderBy+'   FOR XML path(''EnquiryList''),ELEMENTS,ROOT(''Json'')) AS XML)'
    PRINT @sql
 
   execute (@sql)

 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 --EXEC sp_executesql @sql

END