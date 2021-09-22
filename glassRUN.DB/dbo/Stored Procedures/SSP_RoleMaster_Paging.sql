
CREATE PROCEDURE [dbo].[SSP_RoleMaster_Paging] --'<Json><ServicesAction>LoadRoleMasterGrid</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><RoleName></RoleName><Description></Description><RoleNameCriteria></RoleNameCriteria><DescriptionCriteria></DescriptionCriteria></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(max)
Declare @sql nvarchar(max)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT

DECLARE @RoleName nvarchar(150)
DECLARE @Description nvarchar(50)


DECLARE @RoleNameCriteria nvarchar(50)
DECLARE @DescriptionCriteria nvarchar(50)

declare @orderBy nvarchar(50)



set  @whereClause =''

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @RoleName = tmp.[RoleName],
	   @RoleNameCriteria = tmp.[RoleNameCriteria],
	   @Description = tmp.[Description],
	   @DescriptionCriteria = tmp.[DescriptionCriteria],
	   @PageSize = tmp.[PageSize],
	   @PageIndex = tmp.[PageIndex],
	   @OrderBy = tmp.[OrderBy]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[RoleName] nvarchar(150),
            [Description] nvarchar(50),
			[RoleNameCriteria] nvarchar(50),
            [DescriptionCriteria] nvarchar(50),
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000)
           
			)tmp

			print @orderBy
IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'RoleName' END
IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

IF @RoleName !=''
BEGIN

  IF @RoleNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RoleName LIKE ''%' + @RoleName + '%'''
  END
  IF @RoleNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RoleName NOT LIKE ''%' + @RoleName + '%'''
  END
  IF @RoleNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RoleName LIKE ''' + @RoleName + '%'''
  END
  IF @RoleNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RoleName LIKE ''%' + @RoleName + ''''
  END          
  IF @RoleNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and RoleName =  ''' +@RoleName+ ''''
  END
  IF @RoleNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and RoleName <>  ''' +@RoleName+ ''''
  END
END

IF @Description !=''
BEGIN

  IF @DescriptionCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description LIKE ''%' + @Description + '%'''
  END
  IF @DescriptionCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description NOT LIKE ''%' + @Description + '%'''
  END
  IF @DescriptionCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description LIKE ''' + @Description + '%'''
  END
  IF @DescriptionCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Description LIKE ''%' + @Description + ''''
  END          
  IF @DescriptionCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and Description =  ''' +@Description+ ''''
  END
  IF @DescriptionCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Description <>  ''' +@Description+ ''''
  END
END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


     SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT  ''true'' AS [@json:Array]  ,[RoleMasterId],
  rownumber,TotalCount,
  [RoleName],
		[Description],
		[PolicyName],
		ISNULL([RoleParentId],0) as [RoleParentId],
        [IsActive],
        [CreatedBy],
        [CreatedDate],      
		[CreatedFromIPAddress]
	  
      from 
      (SELECT  ROW_NUMBER() OVER (ORDER BY RoleName) as rownumber , COUNT(*) OVER () as TotalCount, [RoleMasterId],
		[RoleName],
		[Description],
		[PolicyName],
		[RoleParentId],
        [IsActive],
        [CreatedBy],
        [CreatedDate],      
		[CreatedFromIPAddress]
		from [RoleMaster] 
		
		WHERE IsActive = 1 and ' + @whereClause +'  ) as tmp where '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+'
	FOR XML PATH(''RoleMasterList''),ELEMENTS,ROOT(''Json'')) AS XML)'



	PRINT @sql

	EXEC sp_executesql @sql

END