
CREATE PROCEDURE [dbo].[SSP_FinanceDetailDashboard_Paging]-- '<Json><ServicesAction>LoadFinanceDashboardByCarrier</ServicesAction><PageIndex>0</PageIndex><SalesOrderNumberCriteria></SalesOrderNumberCriteria><SalesOrderNumber></SalesOrderNumber><OrderNumberCriteria></OrderNumberCriteria><OrderNumber></OrderNumber><VehicleCriteria></VehicleCriteria><Vehicle></Vehicle><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><FinancerId>1373</FinancerId><CarrierId>1368</CarrierId><IsExportToExcel>0</IsExportToExcel><RoleMasterId>13</RoleMasterId><LoginId>414</LoginId><CultureId>1101</CultureId></Json>'
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

Declare @PageSize bigint
Declare @PageIndex bigint
Declare @OrderBy NVARCHAR(100)

DECLARE @FinancerId NVARCHAR(100)
declare @CarrierId nvarchar(100)

DECLARE @SalesOrderNumber nvarchar(150)
DECLARE @SalesOrderNumberCriteria nvarchar(50)

DECLARE @OrderNumber nvarchar(150)
DECLARE @OrderNumberCriteria nvarchar(50)

DECLARE @Vehicle nvarchar(150)
DECLARE @VehicleCriteria nvarchar(50)

set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@FinancerId = tmp.[FinancerId],
	@CarrierId = tmp.[CarrierId],
	@SalesOrderNumber = tmp.[SalesOrderNumber],
	@SalesOrderNumberCriteria = tmp.[SalesOrderNumberCriteria],
	@OrderNumber = tmp.[OrderNumber],
	@OrderNumberCriteria = tmp.[OrderNumberCriteria],
	@Vehicle = tmp.[Vehicle],
	@VehicleCriteria = tmp.[VehicleCriteria]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
	[PageIndex] bigint,
	[PageSize] bigint,
	[OrderBy] nvarchar(2000),
		[FinancerId] NVARCHAR(100),
		[CarrierId] NVARCHAR(100),
		[SalesOrderNumber] nvarchar(500),
		[SalesOrderNumberCriteria] nvarchar(50),
		[OrderNumber] nvarchar(500),
		[OrderNumberCriteria] nvarchar(50),
		[Vehicle] nvarchar(500),
		[VehicleCriteria] nvarchar(50)
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @SalesOrderNumber !=''
BEGIN

  IF @SalesOrderNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.SalesOrderNumber LIKE ''%' + @SalesOrderNumber + '%'''
  END
  IF @SalesOrderNumberCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.SalesOrderNumber NOT LIKE ''%' + @SalesOrderNumber + '%'''
  END
  IF @SalesOrderNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.SalesOrderNumber LIKE ''' + @SalesOrderNumber + '%'''
  END
  IF @SalesOrderNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and o.SalesOrderNumber LIKE ''%' + @SalesOrderNumber + ''''
  END          
  IF @SalesOrderNumberCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and o.SalesOrderNumber =  ''' +@SalesOrderNumber+ ''''
  END
  IF @SalesOrderNumberCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and o.SalesOrderNumber <>  ''' +@SalesOrderNumber+ ''''
  END
END

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

IF @Vehicle !=''
BEGIN

  IF @VehicleCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ts.TruckSize LIKE ''%' + @Vehicle + '%'''
  END
  IF @VehicleCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ts.TruckSize NOT LIKE ''%' + @Vehicle + '%'''
  END
  IF @VehicleCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ts.TruckSize LIKE ''' + @Vehicle + '%'''
  END
  IF @VehicleCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ts.TruckSize LIKE ''%' + @Vehicle + ''''
  END          
  IF @VehicleCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ts.TruckSize =  ''' +@Vehicle+ ''''
  END
  IF @VehicleCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ts.TruckSize <>  ''' +@Vehicle+ ''''
  END
END


print 'p'
print @PageIndex


set @sql=
			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			[CarrierNumber],
			[OrderNumber] as OrderNumber,
			[SalesOrderNumber] as SalesOrderNumber,
			[LRNO] as LRNo,
			[TruckSize] as Vehicle,
			[TripCost] as TripCost,
			[TripRevenue] as TripRevenue,
			[CompanyName] as Customer,
			[AmountPaidToCarrier] as PaidToCarrier,
			[CostToRecover] as CostToRecover,
			[RevenueToRecover] as RevenueToRecover

			 from (
			SELECT  ROW_NUMBER() OVER (ORDER BY o.CarrierNumber desc) as rownumber , COUNT(*) OVER () as TotalCount,
			 o.CarrierNumber, o.OrderNumber,o.SalesOrderNumber, ''0000'' as LRNO,ts.TruckSize,c.CompanyName, SUM(otc.TripCost) as TripCost, SUM(otc.TripRevenue) as TripRevenue, SUM(ISNULL(pr.Amount,0)) as AmountPaidToCarrier,
SUM(otc.TripCost) as	CostToRecover, SUM(otc.TripRevenue) as RevenueToRecover
			from  dbo.[Order] o INNER JOIN
              dbo.FinanceTransporterMapping ftm ON o.CarrierNumber = ftm.TransporterId INNER JOIN
              dbo.OrderTripCost otc ON o.OrderId = otc.OrderId INNER JOIN
              dbo.PaymentRequest pr ON otc.OrderId = pr.OrderId and pr.[Status] = 2202
			  inner join TruckSize ts on o.TruckSizeId = ts.TruckSizeId 
			  inner join Company c on o.SoldTo = c.CompanyId
			where o.SalesOrderNumber NOT IN 
                             (SELECT SalesOrderNumber
                               FROM  dbo.SalesOrderPayment where SalesOrderNumber is not null)  and ftm.FinancePartnerId = '+@FinancerId+' and o.CarrierNumber = '+@CarrierId+'
							   and  ' + @whereClause +' GROUP BY o.CarrierNumber, o.OrderNumber,o.SalesOrderNumber, ts.TruckSize,c.CompanyName, otc.TripCost, otc.TripRevenue) as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
  FOR XML path(''FinanceDashboardList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END