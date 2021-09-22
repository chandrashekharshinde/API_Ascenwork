Create PROCEDURE [dbo].[SSP_AllEmailEvent_pagging] --'<Json><ServicesAction>LoadEmailContentDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><Subject></Subject><SubjectCriteria></SubjectCriteria></Json>'
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

DECLARE @eventName nvarchar(150)
DECLARE @eventNameCriteria nvarchar(50)
DECLARE @eventCode nvarchar(150)
DECLARE @eventCodeCriteria nvarchar(50)


set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	@eventName=tmp.[EventName],
	@eventNameCriteria=tmp.[EventNameCriteria],
	@eventCode=tmp.[EventCode],
	@eventCodeCriteria=tmp.[EventCodeCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
	
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),  
   [EventCode] nvarchar(150),
   [EventCodeCriteria] nvarchar(50),
   [EventName] nvarchar(150),
    [EventNameCriteria] nvarchar(150),
   UserId bigint
           
   )tmp


   IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'EmailConfigurationId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @eventCode !=''
BEGIN

  IF @eventCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''%' + @eventCode + '%'''
  END
  IF @eventCodeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode NOT LIKE ''%' + @eventCode + '%'''
  END
  IF @eventCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''' + @eventCode + '%'''
  END
  IF @eventCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventCode LIKE ''%' + @eventCode + ''''
  END          
  IF @eventCodeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventCode =  ''' +@eventCode+ ''''
  END
  IF @eventCodeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventCode <>  ''' +@eventCode+ ''''
  END
END

IF @eventName !=''
BEGIN

  IF @eventNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventName LIKE ''%' + @eventName + '%'''
  END
  IF @eventNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventName NOT LIKE ''%' + @eventName + '%'''
  END
  IF @eventNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventName LIKE ''' + @eventName + '%'''
  END
  IF @eventNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EventName LIKE ''%' + @eventName + ''''
  END          
  IF @eventNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventName =  ''' +@eventName+ ''''
  END
  IF @eventNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EventName <>  ''' +@eventName+ ''''
  END
END


set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
 [EmailEventId]
      ,[SupplierId]
      ,[EventName]
      ,[EventCode]
      ,[Description]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]

 from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(UpdatedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
[EmailEventId]
      ,[SupplierId]
      ,[EventName]
      ,[EventCode]
      ,[Description]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
 FROM [EmailEvent]
	  WHERE IsActive = 1 and ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''EmailEventList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	   PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
