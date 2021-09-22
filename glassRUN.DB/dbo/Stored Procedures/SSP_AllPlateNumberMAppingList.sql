CREATE PROCEDURE [dbo].[SSP_AllPlateNumberMAppingList] --'<Json><ServicesAction>LoadPrinterBranchPlantMapping</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><PrinterName></PrinterName><PrinterNameCriteria></PrinterNameCriteria></Json>'
(@xmlDoc XML)
AS
BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)

DECLARE @DriverName nvarchar(150)
DECLARE @DriverNameCriteria nvarchar(50)
DECLARE @PlateNumber nvarchar(50)
DECLARE @userId bigint
DECLARE @companyId nvarchar(50)
DECLARE @PlateNumberCriteria nvarchar(150)


set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	@DriverName=tmp.[DriverName],
	@DriverNameCriteria=tmp.[DriverNameCriteria],
	@PlateNumber=tmp.[PlateNumber],
	@PlateNumberCriteria=tmp.[PlateNumberCriteria],	
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@userId=tmp.UserId,
	@companyId=tmp.Carrier
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),  
   [DriverName] nvarchar(150),
   [DriverNameCriteria] nvarchar(50),
   [PlateNumber] nvarchar(150),
   [PlateNumberCriteria] nvarchar(50),
   Carrier nvarchar(50),

   UserId bigint
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'PlateNumberDriverMappingId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)




IF @PlateNumber !=''
BEGIN

  IF @PlateNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PlateNumber LIKE ''%' + @PlateNumber + '%'''
  END
  IF @PlateNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PlateNumber NOT LIKE ''%' + @PlateNumber + '%'''
  END
  IF @PlateNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PlateNumber LIKE ''' + @PlateNumber + '%'''
  END
  IF @PlateNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PlateNumber LIKE ''%' + @PlateNumber + ''''
  END          
  IF @PlateNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and PlateNumber =  ''' +@PlateNumber+ ''''
  END
  IF @PlateNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and PlateNumber <>  ''' +@PlateNumber+ ''''
  END
END

IF @DriverName !=''
BEGIN

  IF @DriverNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from Login where LoginId=[PlateNumberDriverMapping].DriverId) LIKE ''%' + @DriverName + '%'''
  END
  IF @DriverNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from Login where LoginId=[PlateNumberDriverMapping].DriverId) NOT LIKE ''%' + @DriverName + '%'''
  END
  IF @DriverNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from Login where LoginId=[PlateNumberDriverMapping].DriverId) LIKE ''' + @DriverName + '%'''
  END
  IF @DriverNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from Login where LoginId=[PlateNumberDriverMapping].DriverId) LIKE ''%' + @DriverName + ''''
  END          
  IF @DriverNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 Name from Login where LoginId=[PlateNumberDriverMapping].DriverId) =  ''' +@DriverName+ ''''
  END
  IF @DriverNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 Name from Login where LoginId=[PlateNumberDriverMapping].DriverId) <>  ''' +@DriverName+ ''''
  END
END




set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
[PlateNumberDriverMappingId]
      ,[PlateNumber]
      ,[DriverId]   
	  ,DriverName  
	  ,CreatedBy
	  ,CreatedDate
	  ,UpdatedBy
	  ,UpdatedDate
	  ,Active

 from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(UpdatedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
[PlateNumberDriverMappingId]
      ,PlateNumber
      ,DriverId     
	  ,(select top 1 Name from Login where LoginId=[PlateNumberDriverMapping].DriverId) as DriverName
	  ,[CreatedBy]
	  ,[CreatedDate]
	  ,[UpdatedBy]
	  ,[UpdatedDate]
	  ,[Active]
 FROM [PlateNumberDriverMapping] 
 
	  WHERE Active = 1 and PlateNumber in (Select VehicleRegistrationNumber from TransportVehicle where TransporterId in ('+@companyId+'))   and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''PlateNumberDriverMappingList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	   PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
