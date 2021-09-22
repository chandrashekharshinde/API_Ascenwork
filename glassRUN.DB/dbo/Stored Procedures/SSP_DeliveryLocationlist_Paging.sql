CREATE PROCEDURE [dbo].[SSP_DeliveryLocationlist_Paging] --'<Json><ServicesAction>GetAllDeliveryLocationListPagging</ServicesAction><PageIndex>0</PageIndex><PageSize>10</PageSize><CompanyId>0</CompanyId><OrderBy></OrderBy><ShipTo></ShipTo><ShipToCriteria></ShipToCriteria></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)
Declare @companyId INT

DECLARE @ShipTo nvarchar(150)
DECLARE @ShipToCriteria nvarchar(50)
DECLARE @DeliveryLocationName nvarchar(150)
DECLARE @DeliveryLocationNameCriteria nvarchar(50)


set  @whereClause =''




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ShipTo = tmp.[ShipTo],
    @ShipToCriteria = tmp.[ShipToCriteria],
	@DeliveryLocationName = tmp.[DeliveryLocationName],
	@DeliveryLocationNameCriteria = tmp.[DeliveryLocationNameCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@companyId=tmp.CompanyId
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [ShipTo] nvarchar(150),
   [ShipToCriteria] nvarchar(50),
     [DeliveryLocationName] nvarchar(150),
   [DeliveryLocationNameCriteria] nvarchar(50),
   CompanyId int
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'DeliveryLocationId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

IF @ShipTo !=''
BEGIN

  IF @ShipToCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''%' + @ShipTo + '%'''
  END
  IF @ShipToCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode NOT LIKE ''%' + @ShipTo + '%'''
  END
  IF @ShipToCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''' + @ShipTo + '%'''
  END
  IF @ShipToCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''%' + @ShipTo + ''''
  END          
  IF @ShipToCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationCode =  ''' +@ShipTo+ ''''
  END
  IF @ShipToCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationCode <>  ''' +@ShipTo+ ''''
  END
END

IF @DeliveryLocationName !=''
BEGIN

  IF @DeliveryLocationNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName LIKE ''%' + @DeliveryLocationName + '%'''
  END
  IF @DeliveryLocationNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName NOT LIKE ''%' + @DeliveryLocationName + '%'''
  END
  IF @DeliveryLocationNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName LIKE ''' + @DeliveryLocationName + '%'''
  END
  IF @DeliveryLocationNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName LIKE ''%' + @DeliveryLocationName + ''''
  END          
  IF @DeliveryLocationNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationName =  ''' +@DeliveryLocationName+ ''''
  END
  IF @DeliveryLocationNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationName <>  ''' +@DeliveryLocationName+ ''''
  END
END




 SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((SELECT  ''true'' AS 
       [@json:Array] , 
	   * FROM (select ROW_NUMBER() OVER (ORDER BY [DeliveryLocationId] desc) as rownumber , COUNT(*) OVER () as TotalCount, * from (select
	   [DeliveryLocationId]
      ,[DeliveryLocationName] 
      ,[DeliveryLocationCode]
      ,[CompanyID]
	  ,[Area]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[AddressLine4]
      ,[City]
      ,[State]
      ,[Pincode]
      ,[Country]
      ,[Email]
      ,[Parentid]
      ,isnull([Capacity],0) as[Capacity]
      ,[Safefill]
      ,[ProductCode]
      ,[Description]
      ,[Remarks]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
    FROM [DeliveryLocation]    
    WHERE  IsActive = 1  and ' + @whereClause + ' )
	as d where ' + @whereClause +' ) tmp
	WHERE  '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+' FOR XML path(''DeliveryLocationList''),ELEMENTS,ROOT(''Json'')) AS XML)'


 PRINT @sql
 
 EXEC sp_executesql @sql

END
