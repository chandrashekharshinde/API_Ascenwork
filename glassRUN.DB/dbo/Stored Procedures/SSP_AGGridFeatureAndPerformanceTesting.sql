
Create PROCEDURE [dbo].[SSP_AGGridFeatureAndPerformanceTesting] --'<Json><ServicesAction>AGGridFeaturesAndPerformance</ServicesAction><PageIndex>1</PageIndex><PageSize>100</PageSize><OrderBy></OrderBy><RoleMasterId>3</RoleMasterId><LoginId>20</LoginId><UserId>20</UserId><CultureId>1101</CultureId><columnValue></columnValue><columnFilterType></columnFilterType><sortingColumnName>EnquiryAutoNumber</sortingColumnName><columnSortingType>asc</columnSortingType></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(max)
Declare @sql nvarchar(max)
Declare @sql1 nvarchar(max)
Declare @sql2 nvarchar(max)
Declare @sql3 nvarchar(max)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
DECLARE @roleId bigint
Declare @userId bigint
Declare @LoginId bigint
Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(150)
Declare @PaginationClause nvarchar(max)
DECLARE @OrderType nvarchar(150)


DECLARE @sortingColumnName nvarchar(50)
DECLARE @columnSortingType nvarchar(50)

DECLARE @columnValue nvarchar(150)
DECLARE @columnFilterType nvarchar(150)




set  @whereClause =''




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	 @LoginId = [LoginId],
	    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@columnValue = [columnValue],
   @columnFilterType = [columnFilterType],
   @sortingColumnName = [sortingColumnName],
   @columnSortingType = [columnSortingType],
		
	     @userId = tmp.[UserId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [columnValue] nvarchar(150),
   [columnFilterType] nvarchar(150),
   [sortingColumnName] nvarchar(150),
   [columnSortingType] nvarchar(150),
   [UserId] bigint,
   [LoginId] bigint
           
   )tmp

   IF @sortingColumnName !=''
   begin
		IF(RTRIM(@orderBy) = '') 
			BEGIN SET @orderBy = ' '+ @sortingColumnName +' '+ @columnSortingType  END
		else 
			BEGIN SET @orderBy = @orderBy + ' '+ @sortingColumnName +' '+ @columnSortingType  END
		end
		else
			begin
				BEGIN SET @orderBy = 'EnquiryId desc'  END
			end


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


SET @PageIndex = (CONVERT(bigint,@PageIndex))

IF @columnValue !=''
BEGIN

  IF @columnFilterType = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''%' + @columnValue + '%'''
  END
  IF @columnFilterType = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber NOT LIKE ''%' + @columnValue + '%'''
  END
  IF @columnFilterType = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''' + @columnValue + '%'''
  END
  IF @columnFilterType = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''%' + @columnValue + ''''
  END          
  IF @columnFilterType = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and EnquiryAutoNumber =  ''' +@columnValue+ ''''
  END
  IF @columnFilterType = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EnquiryAutoNumber <>  ''' +@columnValue+ ''''
  END
END



SET @PaginationClause = [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)


 SET @sql = ' WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((select  ''true'' AS [@json:Array],
 rownumber,TotalCount, tmp.EnquiryAutoNumber,EnquiryType,tmp.EnquiryId,tmp.EnquiryDate,RequestDate,SoldTo,ShipTo,
 EnquiryGroupNumber,CurrentState,DeliveryLocationName,DeliveryLocationCode,CompanyMnemonic
 ,CompanyName,StausName
	  	  from (SELECT ROW_NUMBER() OVER (ORDER BY EnquiryId asc) as rownumber , COUNT(*) OVER () as TotalCount,
  o.EnquiryAutoNumber,o.EnquiryType ,o.EnquiryId,CONVERT(varchar(11),o.EnquiryDate,103) as EnquiryDate,
  CONVERT(varchar(11),o.RequestDate,103) as RequestDate,
  o.SoldTo,o.ShipTo,EnquiryGroupNumber,CurrentState,d.DeliveryLocationName,d.DeliveryLocationCode
  ,c.CompanyMnemonic,c.CompanyName,l.Name as StausName
      from [dbo].[Enquiry] o left join  DeliveryLocation d on o.shipto = d.DeliveryLocationId
    left join Company c on c.CompanyId = d.CompanyId
    left join LookUp l on l.LookUpId = o.CurrentState
    left join TruckSize ts on ts.TruckSizeId = o.TruckSizeId
	
    WHERE o.IsActive = 1  and ' + @whereClause +' ) as tmp where 
    '+ @PaginationClause + ' ORDER BY '+@orderBy+'  FOR XML path(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	
	 PRINT (@sql)
 
exec (@sql)




END
