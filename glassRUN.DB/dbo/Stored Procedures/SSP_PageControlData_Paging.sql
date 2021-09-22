
CREATE PROCEDURE [dbo].[SSP_PageControlData_Paging]--'<Json><ServicesAction>GetAllPageControlData_Paging</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><ShortCompanyName></ShortCompanyName><ShortCompanyNameCriteria></ShortCompanyNameCriteria><PageId>10042</PageId></Json>'
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

Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(100)

DECLARE @pageNameCriteria nvarchar(50)
DECLARE @pageName nvarchar(50)
DECLARE @ValidationExpression nvarchar(150)
DECLARE @ValidationExpressionCriteria nvarchar(50)
DECLARE @ControlName nvarchar(150)
DECLARE @ControlNameCriteria nvarchar(50)

DECLARE @ControlType nvarchar(150)
DECLARE @ControlTypeCriteria nvarchar(50)
DECLARE @SearchType nvarchar(50)

Declare @PageId nvarchar(50)


set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	@pageName=tmp.[pageName],
	@pageNameCriteria=tmp.[pageNameCriteria],
	@ValidationExpression=tmp.[ValidationExpression],
	@ValidationExpressionCriteria=tmp.[ValidationExpressionCriteria],
	@ControlName=tmp.[ControlName],
	@ControlNameCriteria=tmp.[ControlNameCriteria],
	@ControlType=tmp.[ControlType],
	@ControlTypeCriteria=tmp.[ControlTypeCriteria],
	@SearchType=tmp.[SearchType],
	@PageSize = tmp.[PageSize],
	@PageIndex = tmp.[PageIndex],
	@OrderBy = tmp.[OrderBy],
	@PageId=tmp.[PageId]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
		[PageIndex] int,
		[PageSize] int,
		[OrderBy] nvarchar(2000),
		[pageName] nvarchar(150),
		[pageNameCriteria] nvarchar(150),
		[ValidationExpression] nvarchar(150),
		[ValidationExpressionCriteria] nvarchar(150),
		[ControlName] nvarchar(150),
		[ControlNameCriteria] nvarchar(150),
		[ControlType] nvarchar(150),
		[ControlTypeCriteria] nvarchar(150),
		[SearchType]nvarchar(150),
		[PageId]nvarchar(150)
 
           
   )tmp

   
IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'pageName' END



IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1);


--IF @SearchType='0'
--	 BEGIN
--		 SET @whereClause = @whereClause + 'and companytype not in (28,29)'
--	 END
--	 ELSE
--	 BEGIN
--	  SET @whereClause = @whereClause + 'and companytype= '+@SearchType
--	 END

if(@PageId!='')
begin
set @whereClause=@whereClause + ' and pc.PageId='+@PageId

end

IF  @ControlType !=''
BEGIN

  IF  @ControlTypeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from LookUp where LookUpId=pc.ControlType) LIKE ''%' +  @ControlType + '%'''
  END
  IF  @ControlTypeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from LookUp where LookUpId=pc.ControlType) NOT LIKE ''%' +  @ControlType + '%'''
  END
  IF  @ControlTypeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from LookUp where LookUpId=pc.ControlType) LIKE ''' +  @ControlType + '%'''
  END
  IF  @ControlTypeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (select top 1 Name from LookUp where LookUpId=pc.ControlType) LIKE ''%' +  @ControlType + ''''
  END          
  IF  @ControlTypeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 Name from LookUp where LookUpId=pc.ControlType) =  ''' + @ControlType+ ''''
  END
  IF  @ControlTypeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and (select top 1 Name from LookUp where LookUpId=pc.ControlType) <>  ''' + @ControlType+ ''''
  END
END






IF  @ControlName !=''
BEGIN

  IF  @ControlNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pc.ControlName LIKE ''%' +  @ControlName + '%'''
  END
  IF  @ControlNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pc.ControlName  NOT LIKE ''%' +  @ControlName + '%'''
  END
  IF  @ControlNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pc.ControlName LIKE ''' +  @ControlName + '%'''
  END
  IF  @ControlNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pc.ControlName LIKE ''%' +  @ControlName + ''''
  END          
  IF  @ControlNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and  pc.ControlName =  ''' + @ControlName+ ''''
  END
  IF  @ControlNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and  pc.ControlName <>  ''' + @ControlName+ ''''
  END
END

IF  @pageName !=''
BEGIN

  IF  @pageNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and p.pageName LIKE ''%' +  @pageName + '%'''
  END
  IF  @pageNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and p.pageName NOT LIKE ''%' +  @pageName + '%'''
  END
  IF  @pageNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and p.pageName LIKE ''' +  @pageName + '%'''
  END
  IF  @pageNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and p.pageName LIKE ''%' +  @pageName + ''''
  END          
  IF  @pageNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and p.pageName =  ''' + @pageName+ ''''
  END
  IF  @pageNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and p.pageName <>  ''' + @pageName+ ''''
  END
END

IF  @ValidationExpression !=''
BEGIN

  IF  @ValidationExpressionCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pc.ValidationExpression LIKE ''%' +  @ValidationExpression + '%'''
  END
  IF  @ValidationExpressionCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pc.ValidationExpression NOT LIKE ''%' +  @ValidationExpression + '%'''
  END
  IF  @ValidationExpressionCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pc.ValidationExpression LIKE ''' +  @ValidationExpression + '%'''
  END
  IF  @ValidationExpressionCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and pc.ValidationExpression LIKE ''%' +  @ValidationExpression + ''''
  END          
  IF  @ValidationExpressionCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and pc.ValidationExpression =  ''' + @ValidationExpression+ ''''
  END
  IF  @ValidationExpressionCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and pc.ValidationExpression <>  ''' + @ValidationExpression+ ''''
  END
END


set @sql='WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] ,
			rownumber,
			TotalCount,
			pageName,
			PageControlId,
			PageId,
			ResourceKey,
			ControlType,
			ControlName,
			DataSource,
			DataType,
			DisplayName,
			IsActive,
			IsMandatory,
			ValidationExpression
			 from (
			SELECT  distinct ROW_NUMBER() OVER (ORDER BY   ISNULL(p.pageName,p.pageid) desc) as rownumber , COUNT(*) OVER () as TotalCount,
			 p.pageName,pc.PageControlId,pc.PageId,pc.ResourceKey,(select top 1 Name from LookUp where LookUpId=pc.ControlType)ControlType
			 ,pc.ControlName,pc.DataSource,
            pc.DataType,pc.DisplayName,(case when pc.IsActive=1 then ''true'' else ''false'' end)IsActive ,
			(case when pc.IsMandatory=1 then ''1'' else ''0'' end)IsMandatory,isnull(pc.ValidationExpression,''0'')ValidationExpression
            from PageControl pc inner Join Pages p on p.PageId=pc.PageId where pc.IsActive=1 
     and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + ' ORDER BY '+@orderBy+'
  FOR XML path(''GratisOrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql;
  PRINT @sql1;
  execute (@sql)
END