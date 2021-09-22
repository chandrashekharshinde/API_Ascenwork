CREATE PROCEDURE [dbo].[SSP_CFRDashboarReporting_Paging] --'<Json><ServicesAction>GetAllCFRDashboarReportingDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><FromDate></FromDate><ToDate></ToDate><SalesOrderNumber></SalesOrderNumber><SalesOrderNumberCriteria></SalesOrderNumberCriteria><Carrier></Carrier><CarrierCriteria></CarrierCriteria><Customer></Customer><CustomerCriteria></CustomerCriteria><BranchPlant></BranchPlant><BranchPlantCriteria></BranchPlantCriteria><Area></Area><AreaCriteria></AreaCriteria><ItemName></ItemName><ItemNameCriteria></ItemNameCriteria><Driver></Driver><DriverCriteria></DriverCriteria></Json>'
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

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'SalesOrderNumber desc' END


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
  
  SET @whereClause = @whereClause + ' and Carrier LIKE ''%' + @Carrier + '%'''
  END
  IF @CarrierCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Carrier NOT LIKE ''%' + @Carrier + '%'''
  END
  IF @CarrierCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Carrier LIKE ''' + @Carrier + '%'''
  END
  IF @CarrierCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Carrier LIKE ''%' + @Carrier + ''''
  END          
  IF @CarrierCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and Carrier =  ''' +@Carrier+ ''''
  END
  IF @CarrierCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Carrier <>  ''' +@Carrier+ ''''
  END
END


IF @Customer !=''
BEGIN

  IF @CustomerCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Customer LIKE ''%' + @Customer + '%'''
  END
  IF @CustomerCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Customer NOT LIKE ''%' + @Customer + '%'''
  END
  IF @CustomerCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Customer LIKE ''' + @Customer + '%'''
  END
  IF @CustomerCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Customer LIKE ''%' + @Customer + ''''
  END          
  IF @CustomerCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and Customer =  ''' +@Customer+ ''''
  END
  IF @CustomerCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Customer <>  ''' +@Customer+ ''''
  END
END


IF @BranchPlant !=''
BEGIN

  IF @BranchPlantCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant NOT LIKE ''%' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant LIKE ''' + @BranchPlant + '%'''
  END
  IF @BranchPlantCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlant LIKE ''%' + @BranchPlant + ''''
  END          
  IF @BranchPlantCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and BranchPlant =  ''' +@BranchPlant+ ''''
  END
  IF @BranchPlantCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and BranchPlant <>  ''' +@BranchPlant+ ''''
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

IF @ItemName !=''
BEGIN

  IF @ItemNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemName LIKE ''%' + @ItemName + '%'''
  END
  IF @ItemNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemName NOT LIKE ''%' + @ItemName + '%'''
  END
  IF @ItemNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemName LIKE ''' + @ItemName + '%'''
  END
  IF @ItemNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemName LIKE ''%' + @ItemName + ''''
  END          
  IF @ItemNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ItemName =  ''' +@ItemName+ ''''
  END
  IF @ItemNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ItemName <>  ''' +@ItemName+ ''''
  END
END


SET @orderBy = 'SalesOrderNumber desc'




SET @sql = ' WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((Select  ''true'' AS [@json:Array] 
		, * from ( select ROW_NUMBER() OVER (ORDER BY SalesOrderNumber desc) as rownumber , COUNT(*) OVER () as TotalCount
		,[Date]
      ,[Month]
      ,[Week]
      ,[BranchPlant]
      ,[Area]
      ,[Customer]
      ,[Carrier]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[Remarks]
      ,[ItemCode]
      ,[ItemName]
      ,[ProductQuantity]
      ,[RevisedQuantity]
      ,[CasesNotAvailable]
      ,[PA_Percentage]
      ,[ReasonCodePreferToCSPortal]
      ,[CasesNotDeliverInFull]
      ,[ReasonCodePreferToCustomerFeedback]
      ,[IF_Percentage]
      ,[OrderDate]
      ,[ApprovalDate]
      ,[RequestDate]
      ,[PromisedDate]
      ,[ReasonCodeWarehousePortal]
      ,[ETD]
      ,[ActualDeliveryDate]
      ,[ETA]
      ,[CasesNotDeliveryOnTime]
      ,[OT_Percentage]
      ,[ReasonCode]
      ,[ActualReceiveDate]
      ,[CFR_Percentage]
      ,[ConfirmedTruckPlate]
      ,[ConfirmedDriver]
      ,[TruckInTruckOutPlateNumber]
      ,[TruckInTruckOutDriver]
      ,[TruckInDataTime]
      ,[TruckOutDataTime]
  FROM [glassRUN-VBL_CFR]..CFRReport where
  convert(datetime,ApprovalDate,103) between  convert(datetime,'''+@fromDate+''',103) 
  and convert(datetime,'''+@toDate+''',103)  and ' + @whereClause +'  )as tmp
   where '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'


   --WHERE ' + @whereClause + ' and tmp.rownumber between ' + CONVERT(NVARCHAR(10), @PageIndex) + ' and ' + CONVERT(NVARCHAR(10), @PageSize) + 'ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'
   

 PRINT (@sql)
 
 

--SELECT @sql
 EXEC sp_executesql @sql
--exec (@sql+@sql1)







END
