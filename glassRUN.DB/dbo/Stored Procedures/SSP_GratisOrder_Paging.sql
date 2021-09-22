CREATE PROCEDURE [dbo].[SSP_GratisOrder_Paging]-- '<Json><ServicesAction>LoadGratisGrid</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy>DeliveryInstruction2</OrderBy><OrderByCriteria>asc</OrderByCriteria><OrderNumber>19164504</OrderNumber><OrderNumberCriteria>contains</OrderNumberCriteria><SoldToCode></SoldToCode><SoldToCodeCriteria></SoldToCodeCriteria><SoldTo></SoldTo><SoldToCriteria></SoldToCriteria><ShipTo></ShipTo><ShipToCriteria></ShipToCriteria><ShipToCode></ShipToCode><ShipToCodeCriteria></ShipToCodeCriteria><OrderType></OrderType><OrderTypeCriteria></OrderTypeCriteria><GratisCode></GratisCode><GratisCodeCriteria></GratisCodeCriteria><CreatedBy></CreatedBy><CreatedByCriteria></CreatedByCriteria><DeliveryInstruction1></DeliveryInstruction1><DeliveryInstruction1Criteria></DeliveryInstruction1Criteria><DeliveryInstruction2></DeliveryInstruction2><DeliveryInstruction2Criteria></DeliveryInstruction2Criteria><AssociatedSO></AssociatedSO><AssociatedSOCriteria></AssociatedSOCriteria><ShortCompanyName></ShortCompanyName><ShortCompanyNameCriteria></ShortCompanyNameCriteria></Json>'
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

Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(100)

DECLARE @OrderNumber nvarchar(150)
DECLARE @OrderNumberCriteria nvarchar(50)
DECLARE @SoldToCode nvarchar(150)
DECLARE @SoldToCodeCriteria nvarchar(50)
DECLARE @CompanyType nvarchar(150)
DECLARE @CompanyTypeCriteria nvarchar(50)
DECLARE @Companyname nvarchar(150)
DECLARE @CompanynameCriteria nvarchar(50)
DECLARE @ShipTo nvarchar(150)
DECLARE @ShipToCriteria nvarchar(50)
DECLARE @ShipToCode nvarchar(150)
DECLARE @ShipToCodeCriteria nvarchar(50)
DECLARE @OrderType nvarchar(150)
DECLARE @OrderTypeCriteria nvarchar(50)
DECLARE @GratisCode nvarchar(150)
DECLARE @GratisCodeCriteria nvarchar(50)
DECLARE @CreatedBy nvarchar(150)
DECLARE @CreatedByCriteria nvarchar(50)
DECLARE @DeliveryInstruction1 nvarchar(150)
DECLARE @DeliveryInstruction1Criteria nvarchar(50)
DECLARE @DeliveryInstruction2 nvarchar(150)
DECLARE @DeliveryInstruction2Criteria nvarchar(50)
DECLARE @AssociatedSO nvarchar(150)
DECLARE @AssociatedSOCriteria nvarchar(50)
DECLARE @ShortCompanyName nvarchar(150)
DECLARE @ShortCompanyNameCriteria nvarchar(50)
DECLARE @ZoneCode nvarchar(150)
DECLARE @ZoneCodeCriteria nvarchar(50)
DECLARE @SearchType nvarchar(50)








set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @OrderNumber=tmp.[OrderNumber],
	@OrderNumberCriteria=tmp.[OrderNumberCriteria],
	@SoldToCode=tmp.[SoldToCode],
	@SoldToCodeCriteria=tmp.[SoldToCodeCriteria],
	@CompanyName=tmp.[Companyname],
	@CompanynameCriteria=tmp.[CompanynameCriteria],
	@ShipTo=tmp.[ShipTo],
	@ShipToCriteria=tmp.[ShipToCriteria],
	@ShipToCode=tmp.[ShipToCode],
	@ShipToCodeCriteria=tmp.[ShipToCodeCriteria],
	@OrderType=tmp.[OrderType],
	@OrderTypeCriteria=tmp.[OrderTypeCriteria],
	@GratisCode=tmp.[GratisCode],
	@GratisCodeCriteria=tmp.[GratisCodeCriteria],
	@CreatedBy=tmp.[CreatedBy],
	@CreatedByCriteria=tmp.[CreatedByCriteria],
	@DeliveryInstruction1=tmp.[DeliveryInstruction1],
	@DeliveryInstruction1Criteria=tmp.[DeliveryInstruction1Criteria],
	@DeliveryInstruction2=tmp.[DeliveryInstruction2],
	@DeliveryInstruction2Criteria=tmp.[DeliveryInstruction2Criteria],
	@AssociatedSO=tmp.[AssociatedSO],
	@AssociatedSOCriteria=tmp.[AssociatedSOCriteria],
	@ShortCompanyName=tmp.[ShortCompanyName],
	@ShortCompanyNameCriteria=tmp.[ShortCompanyNameCriteria],
	@SearchType=tmp.[SearchType],
	@PageSize = tmp.[PageSize],
	@PageIndex = tmp.[PageIndex],
	@OrderBy = tmp.[OrderBy]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
		[PageIndex] int,
		[PageSize] int,
		[OrderBy] nvarchar(2000),
		[OrderNumber] nvarchar(150),
		[OrderNumberCriteria] nvarchar(50),
		[SoldToCode] nvarchar(150),
		[SoldToCodeCriteria] nvarchar(50),
		[CompanyName] nvarchar(150),
		[CompanyNameCriteria] nvarchar(50),
		[ShipTo] nvarchar(150),
		[ShipToCriteria] nvarchar(150),
		[ShipToCode] nvarchar(150),
		[ShipToCodeCriteria] nvarchar(150),
		[OrderType] nvarchar(150),
		[OrderTypeCriteria] nvarchar(150),
		[GratisCode] nvarchar(150),
		[GratisCodeCriteria] nvarchar(150),
		[CreatedBy] nvarchar(150),
		[CreatedByCriteria] nvarchar(150),
		[DeliveryInstruction1] nvarchar(150),
		[DeliveryInstruction1Criteria] nvarchar(150),
		[DeliveryInstruction2] nvarchar(150),
		[DeliveryInstruction2Criteria] nvarchar(150),
		[AssociatedSO] nvarchar(150),
		[AssociatedSOCriteria] nvarchar(150),
		[ShortCompanyName] nvarchar(150),
		[ShortCompanyNameCriteria] nvarchar(150),
		[SearchType]nvarchar(150)
 
           
   )tmp

   
IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'ModifiedDate' END

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1);


--IF @SearchType='0'
--	 BEGIN
--		 SET @whereClause = @whereClause + 'and companytype not in (28,29)'
--	 END
--	 ELSE
--	 BEGIN
--	  SET @whereClause = @whereClause + 'and companytype= '+@SearchType
--	 END

IF @OrderNumber !=''
BEGIN

  IF @OrderNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.OrderNumber LIKE ''%' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.OrderNumber NOT LIKE ''%' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.OrderNumber LIKE ''' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.OrderNumber LIKE ''%' + @OrderNumber + ''''
  END          
  IF @OrderNumberCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.OrderNumber =  ''' +@OrderNumber+ ''''
  END
  IF @OrderNumberCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.OrderNumber <>  ''' +@OrderNumber+ ''''
  END
END

IF @SoldToCode !=''
BEGIN

  IF @SoldToCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and `Gratisorder.SoldToCode LIKE ''%' + @SoldToCode + '%'''
  END
  IF @SoldToCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.SoldToCode NOT LIKE ''%' + @SoldToCode + '%'''
  END
  IF @SoldToCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.SoldToCode LIKE ''' + @SoldToCode + '%'''
  END
  IF @SoldToCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.SoldToCode LIKE ''%' + @SoldToCode + ''''
  END          
  IF @SoldToCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.SoldToCode =  ''' +@SoldToCode+ ''''
  END
  IF @SoldToCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.SoldToCode <>  ''' +@SoldToCode+ ''''
  END
END


IF @CompanyName !=''
BEGIN

  IF @CompanyNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 cp.CompanyName  from Company cp where cp.CompanyMnemonic= Gratisorder.SoldToCode ) LIKE ''%' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and(Select top 1 cp.CompanyName  from Company cp where cp.CompanyMnemonic= Gratisorder.SoldToCode ) NOT LIKE ''%' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and(Select top 1 cp.CompanyName  from Company cp where cp.CompanyMnemonic= Gratisorder.SoldToCode ) LIKE ''' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 cp.CompanyName  from Company cp where cp.CompanyMnemonic= Gratisorder.SoldToCode ) LIKE ''%' + @CompanyName + ''''
  END          
  IF @CompanyNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 cp.CompanyName  from Company cp where cp.CompanyMnemonic= Gratisorder.SoldToCode ) =  ''' +@CompanyName+ ''''
  END
  IF @CompanyNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 cp.CompanyName  from Company cp where cp.CompanyMnemonic= Gratisorder.SoldToCode ) <>  ''' +@CompanyName+ ''''
  END
END

IF @ShipTo !=''
BEGIN

  IF @ShipToCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.ShipTo LIKE ''%' + @ShipTo + '%'''
  END
  IF @ShipToCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.ShipTo NOT LIKE ''%' + @ShipTo + '%'''
  END
  IF @ShipToCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.ShipTo LIKE ''' + @ShipTo + '%'''
  END
  IF @ShipToCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.ShipTo LIKE ''%' + @ShipTo + ''''
  END          
  IF @ShipToCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.ShipTo =  ''' +@ShipTo+ ''''
  END
  IF @ShipToCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.ShipTo <>  ''' +@ShipTo+ ''''
  END
END

IF @ShipToCode !=''
BEGIN

  IF @ShipToCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.ShipToCode LIKE ''%' + @ShipToCode + '%'''
  END
  IF @ShipToCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.ShipToCode NOT LIKE ''%' + @ShipToCode + '%'''
  END
  IF @ShipToCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.ShipToCode LIKE ''' + @ShipToCode + '%'''
  END
  IF @ShipToCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.ShipToCode LIKE ''%' + @ShipToCode + ''''
  END          
  IF @ShipToCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.ShipToCode =  ''' +@ShipToCode+ ''''
  END
  IF @ShipToCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.ShipToCode <>  ''' +@ShipToCode+ ''''
  END
END

IF @OrderType !=''
BEGIN

  IF @OrderTypeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.OrderType LIKE ''%' + @OrderType + '%'''
  END
  IF @OrderTypeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.OrderType NOT LIKE ''%' + @OrderType + '%'''
  END
  IF @OrderTypeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.OrderType LIKE ''' + @OrderType + '%'''
  END
  IF @OrderTypeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.OrderType LIKE ''%' + @OrderType + ''''
  END          
  IF @OrderTypeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.OrderType =  ''' +@OrderType+ ''''
  END
  IF @OrderTypeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.OrderType <>  ''' +@OrderType+ ''''
  END
END

IF @GratisCode !=''
BEGIN

  IF @GratisCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.GratisCode LIKE ''%' + @GratisCode + '%'''
  END
  IF @GratisCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  Gratisorder.GratisCode NOT LIKE ''%' + @GratisCode + '%'''
  END
  IF @GratisCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  Gratisorder.GratisCode LIKE ''' + @GratisCode + '%'''
  END
  IF @GratisCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.GratisCode LIKE ''%' + @GratisCode + ''''
  END          
  IF @GratisCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and  Gratisorder.GratisCode =  ''' +@GratisCode+ ''''
  END
  IF @GratisCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and  Gratisorder.GratisCode <>  ''' +@GratisCode+ ''''
  END
END

IF @CreatedBy !=''
BEGIN

  IF @CreatedByCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and  Gratisorder.CreatedBy LIKE ''%' + @CreatedBy + '%'''
  END
  IF @CreatedByCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.CreatedBy NOT LIKE ''%' + @CreatedBy + '%'''
  END
  IF @CreatedByCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.CreatedBy LIKE ''' + @CreatedBy + '%'''
  END
  IF @CreatedByCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.CreatedBy LIKE ''%' + @CreatedBy + ''''
  END          
  IF @CreatedByCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.CreatedBy =  ''' +@CreatedBy+ ''''
  END
  IF @CreatedByCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.CreatedBy <>  ''' +@CreatedBy+ ''''
  END
END

IF @DeliveryInstruction1 !=''
BEGIN

  IF @DeliveryInstruction1Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.Description1 LIKE ''%' + @DeliveryInstruction1 + '%'''
  END
  IF @DeliveryInstruction1Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.Description1 NOT LIKE ''%' + @DeliveryInstruction1 + '%'''
  END
  IF @DeliveryInstruction1Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.Description1 LIKE ''' + @DeliveryInstruction1 + '%'''
  END
  IF @DeliveryInstruction1Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.Description1 LIKE ''%' + @DeliveryInstruction1 + ''''
  END          
  IF @DeliveryInstruction1Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.Description1 =  ''' +@DeliveryInstruction1+ ''''
  END
  IF @DeliveryInstruction1Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.Description1 <>  ''' +@DeliveryInstruction1+ ''''
  END
END

IF @DeliveryInstruction2 !=''
BEGIN

  IF @DeliveryInstruction2Criteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.Description2 LIKE ''%' + @DeliveryInstruction2 + '%'''
  END
  IF @DeliveryInstruction2Criteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.Description2 NOT LIKE ''%' + @DeliveryInstruction2 + '%'''
  END
  IF @DeliveryInstruction2Criteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.Description2 LIKE ''' + @DeliveryInstruction2 + '%'''
  END
  IF @DeliveryInstruction2Criteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Gratisorder.Description2 LIKE ''%' + @DeliveryInstruction2 + ''''
  END          
  IF @DeliveryInstruction2Criteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.Description2 =  ''' +@DeliveryInstruction2+ ''''
  END
  IF @DeliveryInstruction2Criteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Gratisorder.Description2 <>  ''' +@DeliveryInstruction2+ ''''
  END
END

IF  @AssociatedSO !=''
BEGIN

  IF  @AssociatedSOCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 o.ordernumber from [orderproduct] oa inner join [order] o on oa.orderid=o.OrderId  where oa.AssociatedOrder=Gratisorder.OrderId) LIKE ''%' +  @AssociatedSO + '%'''
  END
  IF  @AssociatedSOCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 o.ordernumber from [orderproduct] oa inner join [order] o on oa.orderid=o.OrderId  where oa.AssociatedOrder=Gratisorder.OrderId) NOT LIKE ''%' +  @AssociatedSO + '%'''
  END
  IF  @AssociatedSOCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 o.ordernumber from [orderproduct] oa inner join [order] o on oa.orderid=o.OrderId  where oa.AssociatedOrder=Gratisorder.OrderId) LIKE ''' +  @AssociatedSO + '%'''
  END
  IF  @AssociatedSOCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 o.ordernumber from [orderproduct] oa inner join [order] o on oa.orderid=o.OrderId  where oa.AssociatedOrder=Gratisorder.OrderId) LIKE ''%' +  @AssociatedSO + ''''
  END          
  IF  @AssociatedSOCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 o.ordernumber from [orderproduct] oa inner join [order] o on oa.orderid=o.OrderId  where oa.AssociatedOrder=Gratisorder.OrderId) =  ''' + @AssociatedSO+ ''''
  END
  IF  @AssociatedSOCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 o.ordernumber from [orderproduct] oa inner join [order] o on oa.orderid=o.OrderId  where oa.AssociatedOrder=Gratisorder.OrderId) <>  ''' + @AssociatedSO+ ''''
  END
END

IF  @ShortCompanyName !=''
BEGIN

  IF  @ShortCompanyNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (SUBSTRING((Select top 1 CompanyName from Company where companyid= Gratisorder.SoldTo), 0, 5)) LIKE ''%' +  @ShortCompanyName + '%'''
  END
  IF  @ShortCompanyNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (SUBSTRING((Select top 1 CompanyName from Company where companyid= Gratisorder.SoldTo), 0, 5)) NOT LIKE ''%' +  @ShortCompanyName + '%'''
  END
  IF  @ShortCompanyNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (SUBSTRING((Select top 1 CompanyName from Company where companyid= Gratisorder.SoldTo), 0, 5)) LIKE ''' +  @ShortCompanyName + '%'''
  END
  IF  @ShortCompanyNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (SUBSTRING((Select top 1 CompanyName from Company where companyid= Gratisorder.SoldTo), 0, 5)) LIKE ''%' +  @ShortCompanyName + ''''
  END          
  IF  @ShortCompanyNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (SUBSTRING((Select top 1 CompanyName from Company where companyid= Gratisorder.SoldTo), 0, 5)) =  ''' + @ShortCompanyName+ ''''
  END
  IF  @ShortCompanyNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and (SUBSTRING((Select top 1 CompanyName from Company where companyid= Gratisorder.SoldTo), 0, 5)) <>  ''' + @ShortCompanyName+ ''''
  END
END


set @sql=			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			SoldToCode,
			CompanyName,
			--ShipTo,
			ShipToCode,
			OrderType,
			GratisCode,
			CreatedBy,
			DeliveryInstruction1,
			DeliveryInstruction2,
			OrderNumber,
			Isnull(AssociatedSO,''-'')AssociatedSO,
			orderid,ShortCompanyName
			 from (
			SELECT  distinct ROW_NUMBER() OVER (ORDER BY   ISNULL(Gratisorder.ModifiedDate,Gratisorder.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
			Gratisorder.orderid,Gratisorder.OrderNumber ,Gratisorder.SoldToCode,Gratisorder.SoldTo,
			Gratisorder.ShipTo,Gratisorder.ShipToCode,Gratisorder.OrderType,Gratisorder.GratisCode,
			(Select top 1 cp.CompanyName  from Company cp where cp.CompanyMnemonic= Gratisorder.SoldToCode )CompanyName,
			(select top 1 UserName from Login where LoginId= Gratisorder.CreatedBy) CreatedBy,Gratisorder.Description1 as DeliveryInstruction1,
			Gratisorder.Description2 as DeliveryInstruction2,Gratisorder.ModifiedDate,
			(SUBSTRING((Select top 1 CompanyName from Company where companyid= Gratisorder.SoldTo), 0, 5)) AS ShortCompanyName
			,(Select top 1 o.ordernumber from [orderproduct] oa inner join [order] o on oa.orderid=o.OrderId  where oa.AssociatedOrder=Gratisorder.OrderId) as AssociatedSO
			from [Order] Gratisorder
			left join [order] o on o.orderid = Gratisorder.orderid 
			where o.IsActive=1 and Gratisorder.IsActive=1 and  Gratisorder.OrderType not in  (''SO'',''ST'') 
     and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+'
  FOR XML path(''GratisOrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql;
  PRINT @sql1;
  execute (@sql)
END

