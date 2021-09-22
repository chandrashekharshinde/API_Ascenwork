CREATE PROCEDURE [dbo].[SSP_ObjectVersion_Paging] --'<ObjectVersion xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ObjectId>0</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>false</IsActive><CreatedBy>0</CreatedBy><ObjectVersionId>0</ObjectVersionId><ObjectName /><VersionNumber /></ObjectVersion>',0,10,''
(
@xmlDoc XML,
@PageIndex INT,
@PageSize INT,
@orderBy nvarchar(2000)
)
AS

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'ObjectVersionId' END

BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause1 NVARCHAR(max)
DECLARE @whereClause NVARCHAR(max)

DECLARE @VersionNumber nvarchar(150)
DECLARE @ObjectName nvarchar(50)


DECLARE @VersionNumberCriteria nvarchar(50)
DECLARE @ObjectNameCriteria nvarchar(50)



SET @whereClause1='';
SET @whereClause='';

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @VersionNumber = tmp.[VersionNumber],
	   @VersionNumberCriteria = tmp.[VersionNumberCriteria],
	   @ObjectName = tmp.[ObjectName],
	   @ObjectNameCriteria = tmp.[ObjectNameCriteria]
	  
	   
FROM OPENXML(@intpointer,'ObjectVersion',2)
			WITH
			(
			[VersionNumber] nvarchar(150),
            [ObjectName] nvarchar(50),
			[VersionNumberCriteria] nvarchar(50),
            [ObjectNameCriteria] nvarchar(50)
           
			)tmp

IF(RTRIM(@whereClause1) = '') BEGIN SET @whereClause1 = '1=1' END
IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

IF @VersionNumber !=''
BEGIN

  IF @VersionNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause1 = @whereClause1 + ' and VersionNumber LIKE ''%' + @VersionNumber + '%'''
  END
  IF @VersionNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause1 = @whereClause1 + ' and VersionNumber NOT LIKE ''%' + @VersionNumber + '%'''
  END
  IF @VersionNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause1 = @whereClause1 + ' and VersionNumber LIKE ''' + @VersionNumber + '%'''
  END
  IF @VersionNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause1 = @whereClause1 + ' and VersionNumber LIKE ''%' + @VersionNumber + ''''
  END          
  IF @VersionNumberCriteria = 'eq'
 BEGIN

 SET @whereClause1 = @whereClause1 + ' and VersionNumber =  ''' +@VersionNumber+ ''''
  END
  IF @VersionNumberCriteria = 'neq'
 BEGIN

 SET @whereClause1 = @whereClause1 + ' and VersionNumber <>  ''' +@VersionNumber+ ''''
  END
END

IF @ObjectName !=''
BEGIN

  IF @ObjectNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause1 = @whereClause1 + ' and ObjectName LIKE ''%' + @ObjectName + '%'''
  END
  IF @ObjectNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause1 = @whereClause1 + ' and ObjectName NOT LIKE ''%' + @ObjectName + '%'''
  END
  IF @ObjectNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause1 = @whereClause1 + ' and ObjectName LIKE ''' + @ObjectName + '%'''
  END
  IF @ObjectNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause1 = @whereClause1 + ' and ObjectName LIKE ''%' + @ObjectName + ''''
  END          
  IF @ObjectNameCriteria = 'eq'
 BEGIN

 SET @whereClause1 = @whereClause1 + ' and ObjectName =  ''' +@ObjectName+ ''''
  END
  IF @ObjectNameCriteria = 'neq'
 BEGIN

 SET @whereClause1 = @whereClause1 + ' and ObjectName <>  ''' +@ObjectName+ ''''
  END
END


	SET @sql = 'select cast ((Select [ObjectVersionId]
      ,[ObjectId]
      ,[ObjectName]
      ,[VersionNumber]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]      
	  ,COUNT(ObjectVersionId) OVER () as TotalCount
	
		from [ObjectVersion] 
		
		WHERE IsActive = 1 and ' + @whereClause + ' ORDER BY '+@orderBy+' OFFSET ((' + CONVERT(NVARCHAR(10), @PageIndex) + ' * ' + CONVERT(NVARCHAR(10), @PageSize) + ')) ROWS FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY  FOR XML RAW(''ObjectVersionList''),ELEMENTS,ROOT(''ObjectVersion'')) AS XML)'

	PRINT @sql

	EXEC sp_executesql @sql

END
