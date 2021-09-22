Create PROCEDURE [dbo].[SSP_EmailContent_pagging] --'<Json><ServicesAction>LoadEmailContentDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><Subject>h</Subject><SubjectCriteria>eq</SubjectCriteria><EmailHeader></EmailHeader><EmailHeaderCriteria></EmailHeaderCriteria><EmailFooter></EmailFooter><EmailFooterCriteria></EmailFooterCriteria></Json>'
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

DECLARE @subject nvarchar(150)
DECLARE @subjectCriteria nvarchar(50)
DECLARE @emailHeader nvarchar(150)
DECLARE @emailHeaderCriteria nvarchar(50)



set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	@subject=tmp.[Subject],
	@subjectCriteria=tmp.SubjectCriteria,
	@emailHeader=tmp.EmailHeader,
	@emailHeaderCriteria=tmp.EmailHeaderCriteria,
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy]
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),  
   [Subject] nvarchar(150),
   SubjectCriteria nvarchar(50),
    EmailHeader nvarchar(150),
   EmailHeaderCriteria nvarchar(50)
           
   )tmp


   IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'EmailContentId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

IF @subject !=''
BEGIN

  IF @subjectCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Subject LIKE ''%' + @subject + '%'''
  END
  IF @subjectCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Subject NOT LIKE ''%' + @subject + '%'''
  END
  IF @subjectCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Subject LIKE ''' + @subject + '%'''
  END
  IF @subjectCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Subject LIKE ''%' + @subject + ''''
  END          
  IF @subjectCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and Subject =  ''' +@subject+ ''''
  END
  IF @subjectCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Subject <>  ''' +@subject+ ''''
  END
END


IF @emailHeader !=''
BEGIN

  IF @emailHeaderCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmailHeader LIKE ''%' + @emailHeader + '%'''
  END
  IF @emailHeaderCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmailHeader NOT LIKE ''%' + @emailHeader + '%'''
  END
  IF @emailHeaderCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmailHeader LIKE ''' + @emailHeader + '%'''
  END
  IF @emailHeaderCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EmailHeader LIKE ''%' + @emailHeader + ''''
  END          
  IF @emailHeaderCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and EmailHeader =  ''' +@emailHeader+ ''''
  END
  IF @emailHeaderCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EmailHeader <>  ''' +@emailHeader+ ''''
  END
END



SET @sql = '
 WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((SELECT ''true'' AS [@json:Array],
rownumber,
TotalCount,
	[EmailContentId]
      ,[SupplierId]
      ,[CompanyId]
      ,[EmailEventId]
      ,[Subject]
      ,[EmailHeader]
      ,[EmailBody]
      ,[EmailFooter]
      ,[CCEmailAddress]
      ,[UserProfileId]
   
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
	  from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(UpdatedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
[EmailContentId]
      ,[SupplierId]
      ,[CompanyId]
      ,[EmailEventId]
      ,[Subject]
      ,[EmailHeader]
      ,[EmailBody]
      ,[EmailFooter]
      ,[CCEmailAddress]
      ,[UserProfileId]   
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
  FROM [dbo].[EmailContent] WHERE IsActive=1 and ' + @whereClause + ') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '

  FOR XML path(''EmailContentList''),ELEMENTS,ROOT(''Json'')) AS XML)'
  	   PRINT @sql
 EXEC sp_executesql @sql
END
