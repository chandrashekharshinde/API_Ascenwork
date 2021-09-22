
CREATE PROCEDURE [dbo].[SSP_OrderGridByCustomerPaymentDetail_Paging]--'<Json><ServicesAction>LoadCustomerServiceEnquiryDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>10</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria><CompanyNameValue></CompanyNameValue><CompanyNameValueCriteria></CompanyNameValueCriteria><SoldToCode></SoldToCode><SoldToCodeCriteria></SoldToCodeCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><Area></Area><AreaCriteria></AreaCriteria><DeliveryLocation></DeliveryLocation><DeliveryLocationCriteria></DeliveryLocationCriteria><Gratis></Gratis><GratisCriteria></GratisCriteria><EnquiryDate></EnquiryDate><EnquiryDateCriteria></EnquiryDateCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><PromisedDate></PromisedDate><PromisedDateCriteria></PromisedDateCriteria><Status></Status><StatusCriteria></StatusCriteria><TotalPriceCriteria>&lt;</TotalPriceCriteria><TotalPrice>124300</TotalPrice><Empties></Empties><EmptiesCriteria></EmptiesCriteria><IsAvailableStock></IsAvailableStock><AvailableStockCriteria></AvailableStockCriteria><AvailableCredit></AvailableCredit><AvailableCreditCriteria></AvailableCreditCriteria><ReceivedCapacityPalates></ReceivedCapacityPalates><ReceivedCapacityPalatesCriteria></ReceivedCapacityPalatesCriteria><CurrentState>1,7</CurrentState><IsExportToExcel>0</IsExportToExcel><RoleMasterId>3</RoleMasterId><LoginId>8</LoginId><CultureId>1101</CultureId><ProductCode></ProductCode></Json>'
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


Declare @SalesOrderNumber NVARCHAR(250)
Declare @SalesOrderNumberCriteria NVARCHAR(250)


Declare @SoldToName NVARCHAR(250)
Declare @SoldToNameCriteria NVARCHAR(250)


Declare @SoldToCode NVARCHAR(250)
Declare @SoldToCodeCriteria NVARCHAR(250)


Declare @ShipToName NVARCHAR(250)
Declare @ShipToNameCriteria NVARCHAR(250)


Declare @ShipToCode  NVARCHAR(250)
Declare @ShipToCodeCriteria NVARCHAR(250)



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
    @SalesOrderNumber = tmp.[SalesOrderNumber],
	@SalesOrderNumberCriteria = tmp.[SalesOrderNumberCriteria],
	  @SoldToName = tmp.[SoldToName],
	@SoldToNameCriteria = tmp.[SoldToNameCriteria],
	  @SoldToCode = tmp.[SoldToCode],
	@SoldToCodeCriteria = tmp.[SoldToCodeCriteria],
	  @ShipToCode = tmp.[ShipToCode],
	@ShipToCodeCriteria = tmp.[ShipToCodeCriteria],
	  @ShipToName = tmp.[ShipToName],
	@ShipToNameCriteria = tmp.[ShipToNameCriteria],
	@roleId = tmp.[RoleMasterId],
	@CultureId = [CultureId],
 
   @LoginId = tmp.[LoginId],
   @IsExportToExcel = tmp.[IsExportToExcel]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [OrderByCriteria] nvarchar(2000),
   [SalesOrderNumber] nvarchar(2000),
   [SalesOrderNumberCriteria] nvarchar(2000),
   [SoldToName] nvarchar(2000),
   [SoldToNameCriteria] nvarchar(2000),
   [SoldToCode] nvarchar(2000),
   [SoldToCodeCriteria] nvarchar(2000),
   [ShipToCode] nvarchar(2000),
   [ShipToCodeCriteria] nvarchar(2000),
   [ShipToName] nvarchar(2000),
   [ShipToNameCriteria] nvarchar(2000),
  [RoleMasterId] bigint,
  [CultureId] bigint,
  [LoginId] bigint,
            [IsExportToExcel] bit
   )tmp
   
IF(RTRIM(@OrderBy) = '') BEGIN SET @OrderByClause = ' ISNULL(CreatedDate,ModifiedDate ) desc' END
Else BEGIN set @OrderByClause = ''+@OrderBy+' '+@OrderByCriteria END

print @OrderByClause


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END


IF @SalesOrderNumber !=''
BEGIN

  IF @SalesOrderNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SalesOrderNumber LIKE ''%' + @SalesOrderNumber + '%'''
  END
  IF @SalesOrderNumberCriteria = 'notcontains'
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
  IF @SalesOrderNumberCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and SalesOrderNumber =  ''' +@SalesOrderNumber+ ''''
  END
  IF @SalesOrderNumberCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and SalesOrderNumber <>  ''' +@SalesOrderNumber+ ''''
  END
END






IF @SoldToName !=''
BEGIN

  IF @SoldToNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SoldToName LIKE ''%' + @SoldToName + '%'''
  END
  IF @SoldToNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SoldToName NOT LIKE ''%' + @SoldToName + '%'''
  END
  IF @SoldToNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SoldToName LIKE ''' + @SoldToName + '%'''
  END
  IF @SoldToNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SoldToName LIKE ''%' + @SoldToName + ''''
  END          
  IF @SoldToNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and SoldToName =  ''' +@SoldToName+ ''''
  END
  IF @SoldToNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and SoldToName <>  ''' +@SoldToName+ ''''
  END
END







IF @SoldToCode !=''
BEGIN

  IF @SoldToCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SoldToCode LIKE ''%' + @SoldToCode + '%'''
  END
  IF @SoldToCodeCriteria = 'notcontains'
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
  IF @SoldToCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and SoldToCode =  ''' +@SoldToCode+ ''''
  END
  IF @SoldToCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and SoldToCode <>  ''' +@SoldToCode+ ''''
  END
END





IF @ShipToName !=''
BEGIN

  IF @ShipToNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipToName LIKE ''%' + @ShipToName + '%'''
  END
  IF @ShipToNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipToName NOT LIKE ''%' + @ShipToName + '%'''
  END
  IF @ShipToNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipToName LIKE ''' + @ShipToName + '%'''
  END
  IF @ShipToNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ShipToName LIKE ''%' + @ShipToName + ''''
  END          
  IF @ShipToNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ShipToName =  ''' +@ShipToName+ ''''
  END
  IF @ShipToNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ShipToName <>  ''' +@ShipToName+ ''''
  END
END





IF @ShipToCode !=''
BEGIN

  IF @ShipToCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  ShipToCode LIKE ''%' + @ShipToCode + '%'''
  END
  IF @ShipToCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  ShipToCode NOT LIKE ''%' + @ShipToCode + '%'''
  END
  IF @ShipToCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  ShipToCode LIKE ''' + @ShipToCode + '%'''
  END
  IF @ShipToCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  ShipToCode LIKE ''%' + @ShipToCode + ''''
  END          
  IF @ShipToCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and  ShipToCode =  ''' +@ShipToCode+ ''''
  END
  IF @ShipToCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and  ShipToCode <>  ''' +@ShipToCode+ ''''
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


set @sql1='WITH  XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  ,Order_CTE 
AS
-- Define the CTE query.
(
   select  o.OrderId  ,
o.OrderNumber,
o.OrderType,
o.EnquiryId ,
o.ExpectedTimeOfDelivery,
o.OrderDate,
o.SoldToCode,
o.SoldToName,
o.ShipToCode,
o.ShipToName,
o.PurchaseOrderNumber,
o.CurrentState , 
o.CreatedBy,
o.CarrierNumber,
e.EnquiryAutoNumber
,
c.CompanyMnemonic  as ''CarrierCode'',
c.CompanyName as  ''CarrierName'',
o.Isactive,
o.CreatedDate,
o.ModifiedDate,
o.SalesOrderNumber,
o.StockLocationId    as StockLocationCode ,
l.LocationName  as StockLocationName,
otc.TripCost,
otc.TripRevenue
 
   From  [order] o  left join Enquiry  e on o.EnquiryId  = e.EnquiryId  
  left join  Company  c  on c.CompanyId= o.CarrierNumber 
  left join   Location  l  on l.LocationCode = o.StockLocationId  
    left join  OrderTripCost  otc  on otc.OrderId = o.OrderId
  
)'


SET @sql = 'select cast ((SELECT  ''true'' AS [@json:Array]  ,
rownumber,
 TotalCount,
 tmp.SalesOrderNumber,
 tmp.SoldToCode,
 tmp.SoldToName,
 tmp.ShipToCode,
 tmp.ShipToName,
  tmp.PurchaseOrderNumber,
   tmp.StockLocationName,
   Convert(decimal(18,2), tmp.TotalTripCost) as TotalTripCost,
   Convert(decimal(18,2), tmp.TotalTripRevenue) as TotalTripRevenue,
    (case when (select  count(* )From  [order]  iorder where iorder.SalesOrderNumber=tmp.SalesOrderNumber
and iorder.CurrentState !=103
)=0 then 1 else 0 end ) as IsDeliveredALL,
 (    select   count(*)    From  salesOrderBilling       where SalesOrderNumber=tmp.SalesOrderNumber) as IsBilled ,
 (case when (select  count(*)    From  SalesOrderPayment       where SalesOrderNumber=tmp.SalesOrderNumber) >0 then 1 else 0 end ) as IsPaid 

 from (SELECT  ROW_NUMBER() OVER (ORDER BY SalesOrderNumber ) as rownumber , COUNT(*) OVER () as TotalCount,
  SalesOrderNumber,
  SoldToCode,
  SoldToName,
  ShipToCode,
  ShipToName ,PurchaseOrderNumber,StockLocationName ,StockLocationCode  ,
  sum(isnull(TripCost,0)) as ''TotalTripCost'' ,  sum(isnull(TripRevenue,0)) as ''TotalTripRevenue'' from  Order_CTE  where Isactive=1  and ' + @whereClause +' 
   group by SalesOrderNumber  , SoldToCode ,SoldToName  , ShipToCode , ShipToName,StockLocationName ,StockLocationCode,PurchaseOrderNumber) as tmp  where ' + @PaginationClause +' 
	FOR XML PATH(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  --WHERE ' + @whereClause + ' and tmp.rownumber between ' + CONVERT(NVARCHAR(10), @PageIndex) + ' and ' + CONVERT(NVARCHAR(10), @PageSize) + 'ORDER BY '+@orderBy+'   FOR XML path(''EnquiryList''),ELEMENTS,ROOT(''Json'')) AS XML)'
     PRINT @sql1
   PRINT @sql
 
   execute (@sql1+ @sql)

 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 --EXEC sp_executesql @sql

END
