


Create PROCEDURE [dbo].[SSP_PageRuleEvent_Paging] --'<Json><ServicesAction>LookupGridLoadPagging</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><FinancerId>0</FinancerId><IsExportToExcel>0</IsExportToExcel><RoleMasterId>1</RoleMasterId><LoginId>409</LoginId><CultureId>1101</CultureId><Name></Name><LookupNameCriteria></LookupNameCriteria><LookupType></LookupType><LookupTypeCriteria></LookupTypeCriteria><Code>Checkbox</Code><LookupCodeCriteria>=</LookupCodeCriteria><Description></Description><DescriptionCriteria></DescriptionCriteria><SortOrder></SortOrder><SortOrderCriteria></SortOrderCriteria><IsActive></IsActive><IsActiveCriteria></IsActiveCriteria></Json>'
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


DECLARE @Name nvarchar(150)
DECLARE @LookupNameCriteria nvarchar(50)

DECLARE @LookupType nvarchar(150)
DECLARE @LookupTypeCriteria nvarchar(50)

DECLARE @Code nvarchar(150)
DECLARE @LookupCodeCriteria nvarchar(50)

DECLARE @Description nvarchar(150)
DECLARE @DescriptionCriteria nvarchar(50)

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
	@Name = tmp.[Name],
    @LookupNameCriteria = tmp.[LookupNameCriteria],
		@LookupType = tmp.[LookupType],
    @LookupTypeCriteria = tmp.[LookupTypeCriteria],
	@Code = tmp.[Code],
    @LookupCodeCriteria = tmp.[LookupCodeCriteria],
		@Description = tmp.[Description],
    @DescriptionCriteria = tmp.[DescriptionCriteria]
	


FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
	[PageIndex] bigint,
	[PageSize] bigint,
	[OrderBy] nvarchar(2000),
	[FinancerId] NVARCHAR(100),
	[Name] nvarchar(500),
	[LookupNameCriteria] nvarchar(50),
	[LookupType] nvarchar(500),
	[LookupTypeCriteria] nvarchar(50),
	[Code] nvarchar(150),
	[LookupCodeCriteria] nvarchar(50),
	[Description] nvarchar(500),
	[DescriptionCriteria] nvarchar(50)

   )tmp

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END
IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @Name !=''
BEGIN

  IF @LookupNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Name LIKE ''%' + @Name + '%'''
  END
  IF @LookupNameCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Name NOT LIKE ''%' + @Name + '%'''
  END
  IF @LookupNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Name LIKE ''' + @Name + '%'''
  END
  IF @LookupNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Name LIKE ''%' + @Name + ''''
  END          
  IF @LookupNameCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Name =  ''' +@Name+ ''''
  END
  IF @LookupNameCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Name <>  ''' +@Name+ ''''
  END
END


IF @LookupType !=''
BEGIN

  IF @LookupTypeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select Name from LookupCategory where LookupCategory.LookUpCategoryId= Lookup.LookupCategory) LIKE ''%' + @LookupType + '%'''
  END
  IF @LookupTypeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select Name from LookupCategory where LookupCategory.LookUpCategoryId= Lookup.LookupCategory) NOT LIKE ''%' + @LookupType + '%'''
  END
  IF @LookupTypeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select Name from LookupCategory where LookupCategory.LookUpCategoryId= Lookup.LookupCategory) LIKE ''' + @LookupType + '%'''
  END
  IF @LookupTypeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select Name from LookupCategory where LookupCategory.LookUpCategoryId= Lookup.LookupCategory) LIKE ''%' + @LookupType + ''''
  END          
  IF @LookupTypeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and (Select Name from LookupCategory where LookupCategory.LookUpCategoryId= Lookup.LookupCategory) =  ''' +@LookupType+ ''''
  END
  IF @LookupTypeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select Name from LookupCategory where LookupCategory.LookUpCategoryId= Lookup.LookupCategory) <>  ''' +@LookupType+ ''''
  END
END

IF @Code !=''
BEGIN

  IF @LookupCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(Code,'''') LIKE ''%' + @Code + '%'''
  END
  IF @LookupCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(Code,'''') NOT LIKE ''%' + @Code + '%'''
  END
  IF @LookupCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(Code,'''') LIKE ''' + @Code + '%'''
  END
  IF @LookupCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL(Code,'''') LIKE ''%' + @Code + ''''
  END          
  IF @LookupCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ISNULL(Code,'''')=  ''' +@Code+ ''''
  END
  IF @LookupCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ISNULL(Code,'''') <>  ''' +@Code+ ''''
  END
END



print 'p'
print @PageIndex


set @sql=
			'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
			SELECT CAST((Select ''true'' AS [@json:Array] 
			,rownumber
			,TotalCount
			,[PageRuleEventId]
      ,[PageId]
      ,[PageName]
      ,[PageEvent]
	  ,RuleTypeValue
      ,[RuleType]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
			from (
			SELECT  ROW_NUMBER() OVER (ORDER BY CreatedDate desc) as rownumber , COUNT(*) OVER () as TotalCount
			,[PageRuleEventId]
      ,[PageId]
      ,[PageName]
      ,[PageEvent]
	  ,(Select RuleType from PageRule where PageRuleId= PageRuleEvent.RuleType) as RuleTypeValue
      ,[RuleType]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      
      
			FROM [dbo].[PageRuleEvent] where IsActive = 1
							   and  ' + @whereClause +' )as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
  FOR XML path(''PageRuleEventList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   execute (@sql)
END