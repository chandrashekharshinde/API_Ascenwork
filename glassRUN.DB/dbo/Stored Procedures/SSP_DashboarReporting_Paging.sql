CREATE PROCEDURE [dbo].[SSP_DashboarReporting_Paging] --'<Json><ServicesAction>GetAllDashboarReportingDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><FromDate>24/06/2018</FromDate><ToDate>28/06/2018</ToDate><ShipTo></ShipTo></Json>'
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


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(50)

DECLARE @SalesOrderNumber nvarchar(150)
DECLARE @SalesOrderNumberCriteria nvarchar(50)

DECLARE @Carrier nvarchar(150)
DECLARE @CarrierCriteria nvarchar(50)

DECLARE @Customer nvarchar(150)
DECLARE @CustomerCriteria nvarchar(50)

DECLARE @BranchPlant nvarchar(150)
DECLARE @BranchPlantCriteria nvarchar(50)


DECLARE @Area nvarchar(150)
DECLARE @AreaCriteria nvarchar(50)

DECLARE @ItemName nvarchar(150)
DECLARE @ItemNameCriteria nvarchar(50)

DECLARE @DriverName nvarchar(150)
DECLARE @DriverNameCriteria nvarchar(50)

DECLARE @fromDate nvarchar(50)
DECLARE @toDate nvarchar(50)
Declare @ShipTo nvarchar(500)


set  @whereClause =''




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @SalesOrderNumber = tmp.[SalesOrderNumber],
    @SalesOrderNumberCriteria = tmp.[SalesOrderNumberCriteria],
	@Carrier = tmp.[Carrier],
    @CarrierCriteria = tmp.[CarrierCriteria],
	@Customer = tmp.[Customer],
    @CustomerCriteria = tmp.[CustomerCriteria],
	@BranchPlant = tmp.[BranchPlant],
    @BranchPlantCriteria = tmp.[BranchPlantCriteria],
	@Area = tmp.[Area],
    @AreaCriteria = tmp.[AreaCriteria],
	@ItemName = tmp.[ItemName],
    @ItemNameCriteria = tmp.[ItemNameCriteria],
	@DriverName = tmp.[DriverName],
    @DriverNameCriteria = tmp.[DriverNameCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@fromDate=tmp.FromDate,
	@toDate=tmp.ToDate,
	@ShipTo=tmp.ShipTo


  

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [SalesOrderNumber] nvarchar(150),
   [SalesOrderNumberCriteria] nvarchar(50),
     [Carrier] nvarchar(150),
   [CarrierCriteria] nvarchar(50),
     [Customer] nvarchar(150),
   [CustomerCriteria] nvarchar(50),
     [BranchPlant] nvarchar(150),
   [BranchPlantCriteria] nvarchar(50),
       [Area] nvarchar(150),
   [AreaCriteria] nvarchar(50),
     [ItemName] nvarchar(150),
   [ItemNameCriteria] nvarchar(50),
    [DriverName] nvarchar(150),
   [DriverNameCriteria] nvarchar(50),
   FromDate nvarchar(50),
   ToDate nvarchar(50),
   ShipTo nvarchar(500)
	
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'PraposedTimeOfAction desc' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

Set @fromDate=isnull(@fromDate,'')
if @fromDate=''
Begin
Print '1'
Set @fromDate='1900-01-01'
End

Set @ToDate=isnull(@ToDate,'')
if @ToDate=''
Print '2'
Begin
Set @ToDate=getdate()
End

if @fromDate = @ToDate
begin
set @ToDate = DATEADD(day, 1, @ToDate);
Print '3'
end


if @ShipTo is null
Begin
	SET @ShipTo=''
	Print 'fdsf'
End


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


IF @Carrier !=''
BEGIN

  IF @CarrierCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select CompanyMnemonic from Company where CompanyId=o.CarrierNumber) LIKE ''%' + @Carrier + '%'''
  END
  IF @CarrierCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select CompanyMnemonic from Company where CompanyId=o.CarrierNumber) NOT LIKE ''%' + @Carrier + '%'''
  END
  IF @CarrierCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select CompanyMnemonic from Company where CompanyId=o.CarrierNumber) LIKE ''' + @Carrier + '%'''
  END
  IF @CarrierCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select CompanyMnemonic from Company where CompanyId=o.CarrierNumber) LIKE ''%' + @Carrier + ''''
  END          
  IF @CarrierCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select CompanyMnemonic from Company where CompanyId=o.CarrierNumber) =  ''' +@Carrier+ ''''
  END
  IF @CarrierCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select CompanyMnemonic from Company where CompanyId=o.CarrierNumber) <>  ''' +@Carrier+ ''''
  END
END


IF @Customer !=''
BEGIN

  IF @CustomerCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select CompanyName from Company where CompanyId=o.SoldTo) LIKE ''%' + @Customer + '%'''
  END
  IF @CustomerCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select CompanyName from Company where CompanyId=o.SoldTo) NOT LIKE ''%' + @Customer + '%'''
  END
  IF @CustomerCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select CompanyName from Company where CompanyId=o.SoldTo) LIKE ''' + @Customer + '%'''
  END
  IF @CustomerCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select CompanyName from Company where CompanyId=o.SoldTo) LIKE ''%' + @Customer + ''''
  END          
  IF @CustomerCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select CompanyName from Company where CompanyId=o.SoldTo) =  ''' +@Customer+ ''''
  END
  IF @CustomerCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select CompanyName from Company where CompanyId=o.SoldTo) <>  ''' +@Customer+ ''''
  END
END


IF @BranchPlant !=''
BEGIN

  IF @BranchPlantCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select DeliveryLocationName from deliverylocation where deliverylocationcode=o.StockLocationId) LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select DeliveryLocationName from deliverylocation where deliverylocationcode=o.StockLocationId) NOT LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select DeliveryLocationName from deliverylocation where deliverylocationcode=o.StockLocationId) LIKE ''' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select DeliveryLocationName from deliverylocation where deliverylocationcode=o.StockLocationId) LIKE ''%' + @BranchPlant + ''''
  END          
  IF @BranchPlantCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select DeliveryLocationName from deliverylocation where deliverylocationcode=o.StockLocationId) =  ''' +@BranchPlant+ ''''
  END
  IF @BranchPlantCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select DeliveryLocationName from deliverylocation where deliverylocationcode=o.StockLocationId) <>  ''' +@BranchPlant+ ''''
  END
END


IF @Area !=''
BEGIN

  IF @AreaCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select Area from DeliveryLocation where DeliveryLocationId=o.ShipTo) LIKE ''%' + @Area + '%'''
  END
  IF @AreaCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select Area from DeliveryLocation where DeliveryLocationId=o.ShipTo) NOT LIKE ''%' + @Area + '%'''
  END
  IF @AreaCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select Area from DeliveryLocation where DeliveryLocationId=o.ShipTo) LIKE ''' + @Area + '%'''
  END
  IF @AreaCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select Area from DeliveryLocation where DeliveryLocationId=o.ShipTo) LIKE ''%' + @Area + ''''
  END          
  IF @AreaCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select Area from DeliveryLocation where DeliveryLocationId=o.ShipTo) =  ''' +@Area+ ''''
  END
  IF @AreaCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select Area from DeliveryLocation where DeliveryLocationId=o.ShipTo) <>  ''' +@Area+ ''''
  END
END

IF @ItemName !=''
BEGIN

  IF @ItemNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select ItemName from Item where ItemCode=op.ProductCode) LIKE ''%' + @ItemName + '%'''
  END
  IF @ItemNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select ItemName from Item where ItemCode=op.ProductCode) NOT LIKE ''%' + @ItemName + '%'''
  END
  IF @ItemNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select ItemName from Item where ItemCode=op.ProductCode) LIKE ''' + @ItemName + '%'''
  END
  IF @ItemNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select ItemName from Item where ItemCode=op.ProductCode) LIKE ''%' + @ItemName + ''''
  END          
  IF @ItemNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select ItemName from Item where ItemCode=op.ProductCode) =  ''' +@ItemName+ ''''
  END
  IF @ItemNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select ItemName from Item where ItemCode=op.ProductCode) <>  ''' +@ItemName+ ''''
  END
END


SET @orderBy = 'OrderId desc'




SET @sql = ' WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((Select  ''true'' AS [@json:Array],rownumber,TotalCount, OrderId, SalesOrderNumber,ItemName,ProductCode,ProductQuantity,RevisedQuantity,(ProductQuantity-RevisedQuantity) as CasesnotAvailable,OrderDate
,BranchPlant,Customer,Carrier,RequestDate,PromiseDate,PickupDate,ActualDeliveryDate,DriverName,Feedback,Area from 
(select ROW_NUMBER() OVER (ORDER BY ISNULL(o.ModifiedDate,o.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,o.OrderId,o.SalesOrderNumber,
(select ItemName from Item where ItemCode=op.ProductCode) as ItemName,op.ProductCode
,op.ProductQuantity,(select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc)
as RevisedQuantity,o.OrderDate,(select DeliveryLocationName from deliverylocation where deliverylocationcode=o.StockLocationId) as BranchPlant
,(select CompanyName from Company where CompanyId=o.SoldTo) as Customer
,(select CompanyMnemonic from Company where CompanyId=o.CarrierNumber) as Carrier,
(select RequestDate from Enquiry where EnquiryId=o.EnquiryId) as PromiseDate,
(select OrderProposedETD from Enquiry where EnquiryId=o.EnquiryId) as RequestDate,
(select PraposedTimeOfAction  from OrderMovement where OrderId=o.OrderId) as PickupDate
,(Select top 1 TruckOutTime from OrderLogistics where OrderMovementId in (select top 1 OrderMovementId from OrderMovement where OrderId=o.OrderId)) as ActualDeliveryDate
,(Select Name from Profile where ProfileId in (select top 1 DeliveryPersonnelId from OrderMovement where OrderId=o.OrderId and LocationType=2)) as DriverName,
(select top 1 Comment from OrderFeedback where OrderproductId=op.OrderProductId) as Feedback
,(select Area from DeliveryLocation where DeliveryLocationId=o.ShipTo) as Area
 from OrderProduct op join [Order] o on o.OrderId=op.OrderId
where op.ProductCode<>(select SettingValue from SettingMaster where SettingParameter=''WoodenPalletCode'')
 and op.ProductCode<>65999001 and op.ItemType<>31 and (o.ShipTO in ('''+@ShipTo+''') or '''+@ShipTo+'''='''') 
  and  convert(datetime,o.OrderDate,103) between  convert(datetime,'''+@fromDate+''',103) 
  and convert(datetime,'''+@toDate+''',103)  and ' + @whereClause +' )as tmp
where  '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'


   --WHERE ' + @whereClause + ' and tmp.rownumber between ' + CONVERT(NVARCHAR(10), @PageIndex) + ' and ' + CONVERT(NVARCHAR(10), @PageSize) + 'ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'
   

 PRINT (@sql)
 
 

--SELECT @sql
 EXEC sp_executesql @sql
--exec (@sql+@sql1)







END
