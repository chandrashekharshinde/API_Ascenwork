CREATE PROCEDURE [dbo].[SSP_AllTruckList]-- '<Json><ServicesAction>LoadTruckDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>10</PageSize><OrderBy></OrderBy><TruckSize></TruckSize><TruckSizeCriteria></TruckSizeCriteria></Json>'
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

DECLARE @TruckType nvarchar(150)
DECLARE @TruckTypeCriteria nvarchar(50)
DECLARE @TruckSize nvarchar(150)
DECLARE @TruckSizeCriteria nvarchar(50)

set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	@TruckSize=tmp.[TruckSize],
	@TruckSizeCriteria=tmp.[TruckSizeCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),  
   TruckSize nvarchar(150),
   TruckSizeCriteria nvarchar(50)
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'TruckSizeId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END



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

 SET @whereClause = @whereClause + ' and TruckSize =  ''' +@TruckSize+ ''''
  END
  IF @TruckSizeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckSize <>  ''' +@TruckSize+ ''''
  END
END


 SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((SELECT ''true'' AS [@json:Array] ,COUNT(TruckSizeId) OVER () as TotalCount,[TruckSizeId]
,(Select Name from LookUp where LookUpId=[TruckSize].VehicleType) as TruckType
				  ,[TruckSize]
				  ,[TruckCapacityPalettes]
				  ,[TruckCapacityWeight]
				  ,[IsActive]
				   FROM [TruckSize]  
	  WHERE IsActive = 1 and ' + @whereClause + ' ORDER BY '+@orderBy+' OFFSET ((' + CONVERT(NVARCHAR(10), @PageIndex) + ' * ' + CONVERT(NVARCHAR(10), @PageSize) + ')) ROWS FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY  FOR XML path(''TruckList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	   PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
