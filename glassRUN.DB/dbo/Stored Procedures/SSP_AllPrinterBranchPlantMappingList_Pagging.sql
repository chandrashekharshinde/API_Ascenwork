CREATE PROCEDURE [dbo].[SSP_AllPrinterBranchPlantMappingList_Pagging]-- '<Json><ServicesAction>LoadPrinterBranchPlantMapping</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><PrinterName></PrinterName><PrinterNameCriteria></PrinterNameCriteria></Json>'
(@xmlDoc XML)
AS
BEGIN

Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(50)

DECLARE @BranchPlantCode nvarchar(150)
DECLARE @BranchPlantCodeCriteria nvarchar(50)
DECLARE @PrinterName nvarchar(150)
DECLARE @PrinterNameCriteria nvarchar(50)

set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	@PrinterName=tmp.[PrinterName],
	@PrinterNameCriteria=tmp.[PrinterNameCriteria],
	@BranchPlantCode=tmp.[BranchPlantCode],
	@BranchPlantCodeCriteria=tmp.[BranchPlantCodeCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),  
   [PrinterName] nvarchar(150),
   [PrinterNameCriteria] nvarchar(50),
    [BranchPlantCode] nvarchar(150),
   [BranchPlantCodeCriteria] nvarchar(50)
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'PrinterBranchPlantMappingId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @PrinterName !=''
BEGIN

  IF @PrinterNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PrinterName LIKE ''%' + @PrinterName + '%'''
  END
  IF @PrinterNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PrinterName NOT LIKE ''%' + @PrinterName + '%'''
  END
  IF @PrinterNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PrinterName LIKE ''' + @PrinterName + '%'''
  END
  IF @PrinterNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and PrinterName LIKE ''%' + @PrinterName + ''''
  END          
  IF @PrinterNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and PrinterName =  ''' +@PrinterName+ ''''
  END
  IF @PrinterNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and PrinterName <>  ''' +@PrinterName+ ''''
  END
END


IF @BranchPlantCode !=''
BEGIN

  IF @BranchPlantCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlantCode LIKE ''%' + @BranchPlantCode + '%'''
  END
  IF @BranchPlantCodeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlantCode NOT LIKE ''%' + @BranchPlantCode + '%'''
  END
  IF @BranchPlantCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlantCode LIKE ''' + @BranchPlantCode + '%'''
  END
  IF @BranchPlantCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and BranchPlantCode LIKE ''%' + @BranchPlantCode + ''''
  END          
  IF @BranchPlantCodeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and BranchPlantCode =  ''' +@BranchPlantCode+ ''''
  END
  IF @BranchPlantCodeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and BranchPlantCode <>  ''' +@BranchPlantCode+ ''''
  END
END


set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
[PrinterBranchPlantMappingId]
      ,[BranchPlantCode]
      ,[DocumentType]
      ,[PrinterName]
      ,[PrinterPath]
      ,[NumberOfCopies]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]

 from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(ModifiedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
[PrinterBranchPlantMappingId]
      ,[BranchPlantCode]
      ,[DocumentType]
      ,[PrinterName]
      ,[PrinterPath]
      ,[NumberOfCopies]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]

 FROM [PrinterBranchPlantMapping]
	  WHERE IsActive = 1  and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''PrinterBranchPlantMappingList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	   PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
