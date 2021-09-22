
CREATE PROCEDURE [dbo].[SSP_FinanceDashboard_Paging]-- '<Json><ServicesAction>LoadFinanceDashboardDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><FinancerId>1363</FinancerId><IsExportToExcel>0</IsExportToExcel><RoleMasterId>14</RoleMasterId><LoginId>412</LoginId><CultureId>1101</CultureId><CarrierName>pri</CarrierName><CarrierNameCriteria>contains</CarrierNameCriteria></Json>'
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


DECLARE @CarrierName nvarchar(150)
DECLARE @CarrierNameCriteria nvarchar(50)


set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@FinancerId = tmp.[FinancerId],
	@CarrierName = tmp.[CarrierName],
    @CarrierNameCriteria = tmp.[CarrierNameCriteria]


FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
	[PageIndex] bigint,
	[PageSize] bigint,
	[OrderBy] nvarchar(2000),
	[FinancerId] NVARCHAR(100),
	[CarrierName] nvarchar(500),
	[CarrierNameCriteria] nvarchar(50)
   )tmp

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END
IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @CarrierName !=''
BEGIN

  IF @CarrierNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and cc.CompanyName LIKE ''%' + @CarrierName + '%'''
  END
  IF @CarrierNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and cc.CompanyName NOT LIKE ''%' + @CarrierName + '%'''
  END
  IF @CarrierNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and cc.CompanyName LIKE ''' + @CarrierName + '%'''
  END
  IF @CarrierNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and cc.CompanyName LIKE ''%' + @CarrierName + ''''
  END          
  IF @CarrierNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and cc.CompanyName =  ''' +@CarrierName+ ''''
  END
  IF @CarrierNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and cc.CompanyName <>  ''' +@CarrierName+ ''''
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
			[CompanyName] as Carrier,
			[LoanAmount] as LoanLimit,
			[DisbursementAmount] as DisbursementAmount,
			[CostToRecover] as CostToRecover,
			[RevenueToRecover] as RevenueToRecover

			 from (
			SELECT  ROW_NUMBER() OVER (ORDER BY o.CarrierNumber desc) as rownumber , COUNT(*) OVER () as TotalCount,
			
			 o.CarrierNumber,cc.CompanyName,SUM(ftm.Amount) as LoanAmount,SUM(ISNULL(pr.Amount,0)) as DisbursementAmount,

SUM(otc.TripCost) as	CostToRecover, SUM(otc.TripRevenue) as RevenueToRecover
			from dbo.[Order] o INNER JOIN
              dbo.FinanceTransporterMapping ftm ON o.CarrierNumber = ftm.TransporterId INNER JOIN
              dbo.OrderTripCost otc ON o.OrderId = otc.OrderId INNER JOIN
              dbo.PaymentRequest pr ON otc.OrderId = pr.OrderId and pr.[Status] = 2202	
			  join Company cc on o.CarrierNumber = cc.CompanyId
			where o.SalesOrderNumber NOT IN 
                             (SELECT SalesOrderNumber
                               FROM  dbo.SalesOrderPayment where SalesOrderNumber is not null)  and ftm.FinancePartnerId = '+@FinancerId+'
							   and  ' + @whereClause +' GROUP BY o.CarrierNumber,cc.CompanyName) as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
  FOR XML path(''FinanceDashboardList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END