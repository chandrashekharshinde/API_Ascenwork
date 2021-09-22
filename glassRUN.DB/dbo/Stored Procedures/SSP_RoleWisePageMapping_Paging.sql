
CREATE PROCEDURE [dbo].[SSP_RoleWisePageMapping_Paging] --'<Json><ServicesAction>UserPagewiseconfiguration</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><FinancerId>0</FinancerId><IsExportToExcel>0</IsExportToExcel><RoleMasterId>1</RoleMasterId><LoginId>409</LoginId><CultureId /><PageName></PageName><PageNameCriteria></PageNameCriteria><RoleName></RoleName><RoleNameCriteria></RoleNameCriteria><UserName></UserName><UserNameCriteria></UserNameCriteria><ControlName></ControlName><ControlNameCriteria></ControlNameCriteria></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(max)
Declare @sql nvarchar(max)
Declare @sql1 nvarchar(max)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
DECLARE @whereClauseIcon NVARCHAR(max)

Declare @PageSize bigint
Declare @PageIndex bigint
Declare @OrderBy NVARCHAR(100)
DECLARE @FinancerId NVARCHAR(100)


DECLARE @pageName nvarchar(150)
DECLARE @pageNameCriteria nvarchar(50)

DECLARE @userName nvarchar(150)
DECLARE @userNameCriteria nvarchar(50)

DECLARE @roleName nvarchar(150)
DECLARE @roleNameCriteria nvarchar(50)

DECLARE @controlName nvarchar(150)
DECLARE @controlNameCriteria nvarchar(50)

DECLARE @dimensionValue nvarchar(150)
DECLARE @dimensionValueCriteria nvarchar(50)	


set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@FinancerId = tmp.[FinancerId],
	@pageName = tmp.[PageName],
    @pageNameCriteria = tmp.[PageNameCriteria],
		@roleName = tmp.[RoleName],
    @roleNameCriteria = tmp.[RoleNameCriteria],
		@userName = tmp.[UserName],
    @userNameCriteria = tmp.[UserNameCriteria],
		@controlName = tmp.[ControlName],
    @controlNameCriteria = tmp.[ControlNameCriteria]


FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
	[PageIndex] bigint,
	[PageSize] bigint,
	[OrderBy] nvarchar(2000),
	[FinancerId] NVARCHAR(100),
	[PageName] nvarchar(500),
	[PageNameCriteria] nvarchar(50),
	[RoleName] nvarchar(500),
	[RoleNameCriteria] nvarchar(50),
	[UserName] nvarchar(500),
	[UserNameCriteria] nvarchar(50),
	[ControlName] nvarchar(500),
	[ControlNameCriteria] nvarchar(50)
   )tmp

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END
IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @pageName !=''
BEGIN

  IF @pageNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and udm.[PageName] LIKE ''%' + @pageName + '%'''
  END
  IF @pageNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and udm.[PageName] NOT LIKE ''%' + @pageName + '%'''
  END
  IF @pageNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and udm.[PageName] LIKE ''' + @pageName + '%'''
  END
  IF @pageNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and udm.[PageName] LIKE ''%' + @pageName + ''''
  END          
  IF @pageNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and udm.[PageName] =  ''' +@pageName+ ''''
  END
  IF @pageNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and udm.[PageName] <>  ''' +@pageName+ ''''
  END
END

IF @userName !=''
BEGIN

  IF @userNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(l.Name,'''') LIKE ''%' + @userName + '%'''
  END
  IF @userNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(l.Name,'''') NOT LIKE ''%' + @userName + '%'''
  END
  IF @userNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(l.Name,'''') LIKE ''' + @userName + '%'''
  END
  IF @userNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(l.Name,'''') LIKE ''%' + @userName + ''''
  END          
  IF @userNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ISNULL(l.Name,'''')=  ''' +@userName+ ''''
  END
  IF @userNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ISNULL(l.Name,'''') <>  ''' +@userName+ ''''
  END
END


IF @roleName !=''
BEGIN

  IF @roleNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(rm.RoleName,'''') LIKE ''%' + @roleName + '%'''
  END
  IF @roleNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(rm.RoleName,'''') NOT LIKE ''%' + @roleName + '%'''
  END
  IF @roleNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(rm.RoleName,'''') LIKE ''' + @roleName + '%'''
  END
  IF @roleNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(rm.RoleName,'''') LIKE ''%' + @roleName + ''''
  END          
  IF @roleNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ISNULL(rm.RoleName,'''') =  ''' +@roleName+ ''''
  END
  IF @roleNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ISNULL(rm.RoleName,'''') <>  ''' +@roleName+ ''''
  END
END


IF @controlName !=''
BEGIN

  IF @controlNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select ControlName from pagecontrol  where pagecontrol.PageControlId=udm.ControlId) LIKE ''%' + @controlName + '%'''
  END
  IF @controlNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select ControlName from pagecontrol  where pagecontrol.PageControlId=udm.ControlId) NOT LIKE ''%' + @controlName + '%'''
  END
  IF @controlNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select ControlName from pagecontrol  where pagecontrol.PageControlId=udm.ControlId) LIKE ''' + @controlName + '%'''
  END
  IF @controlNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select ControlName from pagecontrol  where pagecontrol.PageControlId=udm.ControlId) LIKE ''%' + @controlName + ''''
  END          
  IF @controlNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (Select ControlName from pagecontrol  where pagecontrol.PageControlId=udm.ControlId) =  ''' +@controlName+ ''''
  END
  IF @controlNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select ControlName from pagecontrol  where pagecontrol.PageControlId=udm.ControlId) <>  ''' +@controlName+ ''''
  END
END


print 'p'
print @PageIndex


set @sql=
			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			
			[PageId]
	  ,RoleId
      ,UserId
	  
	  , RoleName
	  , Name
	  , PageName
						 from (
			SELECT  ROW_NUMBER() OVER (ORDER BY PageId) as rownumber , COUNT(*) OVER () as TotalCount
			,[PageId]
      ,[RoleId]
	  ,[UserId]   
	  
	  ,(Select RoleName from RoleMaster where RoleMasterId = [PageWiseConfiguration].RoleId) as RoleName
	  ,(Select Name from Login where LoginId = [PageWiseConfiguration].UserId) as Name
	  ,(Select PageName from Pages where PageId = [PageWiseConfiguration].PageId) as PageName
     
      
  FROM [dbo].[PageWiseConfiguration] 
  
  where IsActive = 1 
							   and  ' + @whereClause +'  group by PageId,RoleId,UserId)as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
  FOR XML path(''UserDimensionList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END