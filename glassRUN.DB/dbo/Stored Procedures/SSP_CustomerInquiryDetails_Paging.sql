CREATE PROCEDURE [dbo].[SSP_CustomerInquiryDetails_Paging] --'<Json><ServicesAction>LoadEnquiryDetails</ServicesAction><UserId>12</UserId><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><EnquiryAutoNumber></EnquiryAutoNumber><EnquiryAutoNumberCriteria></EnquiryAutoNumberCriteria><PurchaseOrderNumber></PurchaseOrderNumber><PurchaseOrderNumberCriteria></PurchaseOrderNumberCriteria><SONumber></SONumber><SONumberCriteria></SONumberCriteria><DeliveryLocation></DeliveryLocation><DeliveryLocationCriteria></DeliveryLocationCriteria><Status></Status><StatusCriteria></StatusCriteria><TruckSize></TruckSize><TruckSizeCriteria></TruckSizeCriteria><Gratis></Gratis><GratisCriteria></GratisCriteria><CreatedDate>22/01/2018</CreatedDate><CreatedDateCriteria>eq</CreatedDateCriteria><OrderProposedETD></OrderProposedETD><OrderProposedETDCriteria></OrderProposedETDCriteria><RequestDate></RequestDate><RequestDateCriteria></RequestDateCriteria><OrderDate>22/01/2018</OrderDate><OrderDateCriteria>eq</OrderDateCriteria><RoleMasterId>4</RoleMasterId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(max)
Declare @sql nvarchar(max)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)
Declare @userId bigint
Declare @roleId bigint
DECLARE @EnquiryAutoNumber nvarchar(150)
DECLARE @EnquiryAutoNumberCriteria nvarchar(50)

DECLARE @SONumber nvarchar(150)
DECLARE @SONumberCriteria nvarchar(50)

DECLARE @PurchaseOrderNumber nvarchar(150)
DECLARE @PurchaseOrderNumberCriteria nvarchar(50)

DECLARE @DeliveryLocation nvarchar(150)
DECLARE @DeliveryLocationCriteria nvarchar(50)

DECLARE @Status nvarchar(150)
DECLARE @StatusCriteria nvarchar(50)

DECLARE @TruckSize nvarchar(150)
DECLARE @TruckSizeCriteria nvarchar(50)

DECLARE @Gratis nvarchar(150)
DECLARE @GratisCriteria nvarchar(50)

DECLARE @Empties nvarchar(150)
DECLARE @EmptiesCriteria nvarchar(50)

DECLARE @CreatedDate nvarchar(150)
DECLARE @CreatedDateCriteria nvarchar(50)

DECLARE @OrderProposedETD nvarchar(150)
DECLARE @OrderProposedETDCriteria nvarchar(50)

DECLARE @RequestDate nvarchar(150)
DECLARE @RequestDateCriteria nvarchar(50)

DECLARE @ProductCode nvarchar(max)
DECLARE @ProductSearchCriteria nvarchar(100)

Declare @CultureId bigint

Declare @IsExportToExcel bit = 0
Declare @PaginationClause nvarchar(max) = ''

set  @whereClause =''




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EnquiryAutoNumber = tmp.[EnquiryAutoNumber],
	   @EnquiryAutoNumberCriteria = tmp.[EnquiryAutoNumberCriteria],
	   @SONumber = tmp.[SONumber],
	   @SONumberCriteria = tmp.[SONumberCriteria],
	   	@PurchaseOrderNumber = tmp.[PurchaseOrderNumber],
	@PurchaseOrderNumberCriteria = tmp.[PurchaseOrderNumberCriteria],
	   @DeliveryLocation = tmp.[DeliveryLocation],
	   @DeliveryLocationCriteria = tmp.[DeliveryLocationCriteria],
	   @Status = tmp.[Status],
	   @StatusCriteria = tmp.[StatusCriteria],
	   @TruckSize = tmp.[TruckSize],
	   @TruckSizeCriteria = tmp.[TruckSizeCriteria],
	   	   @Gratis = tmp.[Gratis],
	   @GratisCriteria = tmp.[GratisCriteria],
	   @CreatedDate = tmp.[CreatedDate],
	   @CreatedDateCriteria = tmp.[CreatedDateCriteria],

	   @OrderProposedETD = tmp.[OrderProposedETD],
	   @OrderProposedETDCriteria = tmp.[OrderProposedETDCriteria],
	    	@Empties=tmp.[Empties],
   	@EmptiesCriteria=tmp.[EmptiesCriteria],
	   @RequestDate = tmp.[RequestDate],
	   @RequestDateCriteria = tmp.[RequestDateCriteria],

	 

	   	   @PageSize = tmp.[PageSize],
	   @PageIndex = tmp.[PageIndex],
	   @OrderBy = tmp.[OrderBy],
	   @userId=tmp.[UserId],
	   @roleId=tmp.RoleMasterId,
	   @CultureId = [CultureId],
   @ProductCode = [ProductCode],
   @ProductSearchCriteria = [ProductSearchCriteria],
   @IsExportToExcel = tmp.[IsExportToExcel]
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000),
			[EnquiryAutoNumber] nvarchar(150),
			[EnquiryAutoNumberCriteria] nvarchar(50),
			 [PurchaseOrderNumber] nvarchar(150),
		 [PurchaseOrderNumberCriteria] nvarchar(50),
			[SONumber] nvarchar(150),
            [SONumberCriteria] nvarchar(50),
			[DeliveryLocation] nvarchar(150),
            [DeliveryLocationCriteria] nvarchar(50),
			[Status] nvarchar(150),
            [StatusCriteria] nvarchar(50),
			[TruckSize] nvarchar(150),
            [TruckSizeCriteria] nvarchar(50),
			[Gratis] nvarchar(150),
            [GratisCriteria] nvarchar(50),
			[CreatedDate] nvarchar(150),
            [CreatedDateCriteria] nvarchar(50),
			[Empties] nvarchar(150),
	[EmptiesCriteria] nvarchar(150),
			[OrderProposedETD] nvarchar(150),
            [OrderProposedETDCriteria] nvarchar(50),

			[RequestDate] nvarchar(150),
            [RequestDateCriteria] nvarchar(50),

			

            [UserId] bigint,
			RoleMasterId bigint,
			[CultureId] bigint,
   [ProductCode] nvarchar(500),
   [ProductSearchCriteria] nvarchar(100),
   [IsExportToExcel] bit
			)tmp


		

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'ModifiedDate desc' END


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


IF @Empties !=''
BEGIN
 SET @whereClause = @whereClause + ' and (case when (c.ActualEmpties < 0) then ''C'' else ''W'' end) =  ''' +@Empties+ ''''
END




IF @SONumber !=''
BEGIN

  IF @SONumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL((Select top 1 SalesOrderNumber from [order] where EnquiryId = t.EnquiryId),''-'') LIKE ''%' + @SONumber + '%'''
  END
  IF @SONumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL((Select top 1 SalesOrderNumber from [order] where EnquiryId = t.EnquiryId),''-'') NOT LIKE ''%' + @SONumber + '%'''
  END
  IF @SONumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL((Select top 1 SalesOrderNumber from [order] where EnquiryId = t.EnquiryId),''-'') LIKE ''' + @SONumber + '%'''
  END
  IF @SONumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL((Select top 1 SalesOrderNumber from [order] where EnquiryId = t.EnquiryId),''-'') LIKE ''%' + @SONumber + ''''
  END          
  IF @SONumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ISNULL((Select top 1 SalesOrderNumber from [order] where EnquiryId = t.EnquiryId),''-'') =  ''' + @SONumber + ''''
  END
  IF @SONumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ISNULL((Select top 1 SalesOrderNumber from [order] where EnquiryId = t.EnquiryId),''-'') <>  ''' + @SONumber + ''''
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

 SET @whereClause = @whereClause + ' and (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) =  N''' + @Status + ''''
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

 SET @whereClause = @whereClause + ' and TruckSize =  ''' + @TruckSize + ''''
  END
  IF @TruckSizeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckSize <>  ''' + @TruckSize + ''''
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

IF @CreatedDate !=''
BEGIN

  IF @CreatedDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and t.CreatedDate LIKE ''%' + @CreatedDate + '%'''
  END
  IF @CreatedDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and t.CreatedDate NOT LIKE ''%' + @CreatedDate + '%'''
  END
  IF @CreatedDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and t.CreatedDate LIKE ''' + @CreatedDate + '%'''
  END
  IF @CreatedDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and t.CreatedDate LIKE ''%' + @CreatedDate + ''''
  END          
  IF @CreatedDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),t.CreatedDate,103) =  ''' + CONVERT(varchar(11),@CreatedDate,103) + ''''
  END
  IF @CreatedDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and t.CreatedDate <>  ''' + @CreatedDate + ''''
  END
END

IF @OrderProposedETD !=''
BEGIN

  IF @OrderProposedETDCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderProposedETD LIKE ''%' + @OrderProposedETD + '%'''
  END
  IF @OrderProposedETDCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderProposedETD NOT LIKE ''%' + @OrderProposedETD + '%'''
  END
  IF @OrderProposedETDCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderProposedETD LIKE ''' + @OrderProposedETD + '%'''
  END
  IF @OrderProposedETDCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderProposedETD LIKE ''%' + @OrderProposedETD + ''''
  END          
  IF @OrderProposedETDCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),OrderProposedETD,103) =  ''' + CONVERT(varchar(11),@OrderProposedETD,103) + ''''
  END
  IF @OrderProposedETDCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and OrderProposedETD <>  ''' + @OrderProposedETD + ''''
  END
END

IF @RequestDate !=''
BEGIN

  IF @RequestDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RequestDate LIKE ''%' + @RequestDate + '%'''
  END
  IF @RequestDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RequestDate NOT LIKE ''%' + @RequestDate + '%'''
  END
  IF @RequestDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RequestDate LIKE ''' + @RequestDate + '%'''
  END
  IF @RequestDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RequestDate LIKE ''%' + @RequestDate + ''''
  END          
  IF @RequestDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),RequestDate,103) =  ''' + CONVERT(varchar(11),@RequestDate,103) + ''''
  END
  IF @RequestDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and RequestDate <>  ''' + @RequestDate + ''''
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

If @IsExportToExcel != '0'
	Begin			
		SET @PaginationClause = '1=1'
	End
Else
	Begin
		SET @PaginationClause = [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)
	ENd

	SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((select ''true'' AS [@json:Array]  , * from (select ROW_NUMBER() OVER (ORDER BY ISNULL(t.ModifiedDate,t.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,t.[EnquiryId],
		t.[EnquiryAutoNumber],
		d.DeliveryLocationName,
		d.DeliveryLocationCode,
		case when LEN(d.DeliveryLocationCode)>10 then LEFT(d.DeliveryLocationCode, 10)+ ''...'' else d.DeliveryLocationCode end as DeliveryLocation ,
		c.CompanyName,
		c.EmptiesLimit as EmptiesLimit,
		(select top 1 Note from Notes  where ObjectId = t.EnquiryId and ObjectType = 1220 and RoleId in (select RoleId from NotesRoleWiseConfiguration where ViewNotesByRoleId = ' + CONVERT(NVARCHAR(10), @roleId) + ' and ObjectType = 1220)) as Note,
  c.ActualEmpties as ActualEmpties,
  case when (c.ActualEmpties < 0) then ''C'' else ''W'' end as Empties,
		t.RequestDate as RequestDate,
		t.OrderProposedETD as OrderProposedETD,
				  ISNULL(t.ModifiedDate,t.CreatedDate) as ModifiedDate,
		t.CreatedDate as CreatedDate,
		t.Remarks,
		--(SELECT [dbo].[fn_LookupValueById] (t.CurrentState)) AS ''Status'',
		 (SELECT [dbo].[fn_RoleWiseStatus] (' + CONVERT(NVARCHAR(10), @roleId)+',CurrentState,'+ CONVERT(NVARCHAR(10), @CultureId) +')) AS ''Status'',
		  (SELECT [dbo].[fn_RoleWiseClass] (' + CONVERT(NVARCHAR(10), @roleId)+',CurrentState)) AS ''Class'',
		t.CurrentState,
		ISNULL((Select top 1 SalesOrderNumber from [order] where EnquiryId = t.EnquiryId),''-'') as SalesOrderNumber,
		ISNULL((Select top 1 PurchaseOrderNumber from [order] where EnquiryId = t.EnquiryId),''-'') as PurchaseOrderNumber,

		ISNULL((Select top 1 OrderId from [order] where EnquiryId = t.EnquiryId),''0'') as OrderId,


		(SELECT 
       STUFF((Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep where ep.IsActive = 1 and  EnquiryId = t.EnquiryId and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
),1,1,'''') ) as AssociatedOrder,


		'' ('' + Convert(nvarchar(500),ISNULL(t.TruckWeight,0)) + '' / '' + Convert(nvarchar(500),ISNULL(ts.TruckCapacityWeight,0)) + '')T''  as TruckSize,
		ts.TruckCapacityWeight  as TruckCapacityWeight,
		ISNULL(t.ReturnableItemCheck,0) as ReturnableItemCheck,
		ISNULL(t.ReceivingLocationCapacityCheck,0) as ReceivingLocationCapacityCheck,
		ISNULL(t.StockCheck,0) as StockCheck

		
				from [Enquiry] t left join  DeliveryLocation d 
				on t.shipto = d.DeliveryLocationId
				left join Company c on c.CompanyId = d.CompanyId
				left join LookUp l on l.LookUpId = t.CurrentState
				left join TruckSize ts on ts.TruckSizeId = t.TruckSizeId
            
				WHERE (t.IsActive = 1 and CurrentState in (7,1,8))
				and t.CreatedBy in (' + CONVERT(NVARCHAR(10), @userId)+') and ' + @whereClause +'  )
				as tmp where ' + @PaginationClause +' ORDER BY '+@orderBy+' FOR XML path(''EnquiryList''),ELEMENTS,ROOT(''Json'')) AS XML)'



   

	PRINT @sql
	--SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
	EXEC sp_executesql @sql

END
