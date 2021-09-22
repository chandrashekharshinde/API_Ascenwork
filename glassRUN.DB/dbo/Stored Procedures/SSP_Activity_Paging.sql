
CREATE PROCEDURE [dbo].[SSP_Activity_Paging] --'<Json><ServicesAction>LoadActivityGrid</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><FinancerId>0</FinancerId><IsExportToExcel>0</IsExportToExcel><RoleMasterId>3</RoleMasterId><LoginId>8</LoginId><CultureId>1101</CultureId><PageName></PageName><PageNameCriteria></PageNameCriteria><RoleName></RoleName><RoleNameCriteria></RoleNameCriteria><UserName></UserName><UserNameCriteria></UserNameCriteria><ControlName></ControlName><ControlNameCriteria></ControlNameCriteria></Json>'
(
@xmlDoc XML
)
AS
BEGIN
		
	DECLARE @intPointer INT;	
	EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

	Declare @sqlTotalCount nvarchar(max)
	Declare @sql nvarchar(max)
	Declare @sql1 nvarchar(max)
	DECLARE @whereClause NVARCHAR(max)
	--DECLARE @whereClauseIcon NVARCHAR(max)
	
	Declare @PageSize bigint
	Declare @PageIndex bigint
	Declare @OrderBy NVARCHAR(100)
	DECLARE @FinancerId NVARCHAR(100)
	
	
	DECLARE @StatusCode nvarchar(150)
	DECLARE @StatusCodeCriteria nvarchar(50)
	
	DECLARE @Header nvarchar(150)
	DECLARE @HeaderCriteria nvarchar(50)
	
	DECLARE @ActivityName nvarchar(150)
	DECLARE @ActivityNameCriteria nvarchar(50)
	
	DECLARE @dimensionName nvarchar(150)
	DECLARE @dimensionNameCriteria nvarchar(50)
	
	DECLARE @dimensionValue nvarchar(150)
	DECLARE @dimensionValueCriteria nvarchar(50)	
	
	
	SET  @whereClause =''
	--SET @whereClauseIcon=''
	

	SELECT 
		
	    @PageSize = tmp.[PageSize],
	    @PageIndex = tmp.[PageIndex],
	    @OrderBy = tmp.[OrderBy],
		@FinancerId = tmp.[FinancerId],
		@StatusCode=tmp.[StatusCode],
	    @StatusCodeCriteria = tmp.[StatusCodeCriteria],
		@Header=tmp.[Header],
	    @HeaderCriteria = tmp.[HeaderCriteria],
		@ActivityName=tmp.[ActivityName],
	    @ActivityNameCriteria = tmp.[ActivityNameCriteria]	
	FROM OPENXML(@intpointer,'Json',2)
	WITH
	(
		[PageIndex] bigint,
		[PageSize] bigint,
		[OrderBy] nvarchar(2000),
		[FinancerId] NVARCHAR(100),
		[PageName] nvarchar(500),
		[PageNameCriteria] nvarchar(50),
		[StatusCode] NVARCHAR(100),
		[StatusCodeCriteria] NVARCHAR(100),
		[Header] NVARCHAR(100),
		[HeaderCriteria] NVARCHAR(100),
		[ActivityName] NVARCHAR(100),
		[ActivityNameCriteria] NVARCHAR(100)
	)tmp


	IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END
	--IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END

	SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


	IF @StatusCode !=''
		BEGIN
			IF @StatusCodeCriteria = '='
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(StatusCode,0)) =  CONVERT(float,'''+@StatusCode+''')'
				END
			Else IF @StatusCodeCriteria = '>'
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(StatusCode,0)) >  CONVERT(float,'''+@StatusCode+''')'
				END
			Else IF @StatusCodeCriteria = '<'
				BEGIN
					SET @whereClause = @whereClause + ' and CONVERT(float,ISNULL(StatusCode,0)) <  CONVERT(float,'''+@StatusCode+''')'
				END
		END

	IF @Header !=''
		BEGIN
		
		  IF @HeaderCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and Header LIKE ''%' + @Header + '%'''
		  END
		  IF @HeaderCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and Header NOT LIKE ''%' + @Header + '%'''
		  END
		  IF @HeaderCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and Header LIKE ''' + @Header + '%'''
		  END
		  IF @HeaderCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and Header LIKE ''%' + @Header + ''''
		  END          
		  IF @HeaderCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and Header =  ''' +@Header+ ''''
		  END
		  IF @HeaderCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and Header <>  ''' +@Header+ ''''
		  END
		END

	IF @ActivityName !=''
		BEGIN
		
		  IF @ActivityNameCriteria = 'contains'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and ActivityName LIKE ''%' + @ActivityName + '%'''
		  END
		  IF @ActivityNameCriteria = 'doesnotcontain'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and ActivityName NOT LIKE ''%' + @ActivityName + '%'''
		  END
		  IF @ActivityNameCriteria = 'startswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and ActivityName LIKE ''' + @ActivityName + '%'''
		  END
		  IF @ActivityNameCriteria = 'endswith'
		  BEGIN
		  
		  SET @whereClause = @whereClause + ' and ActivityName LIKE ''%' + @ActivityName + ''''
		  END          
		  IF @ActivityNameCriteria = '='
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and ActivityName =  ''' +@ActivityName+ ''''
		  END
		  IF @ActivityNameCriteria = '<>'
		 BEGIN
		
		 SET @whereClause = @whereClause + ' and ActivityName <>  ''' +@ActivityName+ ''''
		  END
		END


	--print 'p'
	--print @PageIndex


	SET @sql='
				WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
				SELECT CAST((
					Select 
						''true'' AS [@json:Array] ,
						rownumber,
						TotalCount,
						ActivityId,
						ActivityName,
						Header,
						StatusCode,
						IsSystemDefined,
						IsActivityUsedInWorkflow
					From (
							SELECT  
								ROW_NUMBER() OVER (ORDER BY ActivityId desc) as rownumber , 
								COUNT(*) OVER () as TotalCount,
								ActivityId,
								ActivityName,
								Header,
								StatusCode,
								IsSystemDefined,
								(
									CASE WHEN (select COUNT(WorkFlowStepId) from WorkFlowStep where StatusCode = Activity.StatusCode)  > 0 THEN 1 ELSE 0 END
								) as IsActivityUsedInWorkflow 
							FROM Activity
							Where  ' + @whereClause +'
						) as tmp 
					Where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
				FOR XML path(''ActivityList''),ELEMENTS,ROOT(''Json'')) AS XML)'

	PRINT @sql
	execute (@sql)
END