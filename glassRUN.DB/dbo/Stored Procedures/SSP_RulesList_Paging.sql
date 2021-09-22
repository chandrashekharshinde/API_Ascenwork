CREATE PROCEDURE [dbo].[SSP_RulesList_Paging] --'<Json><ServicesAction>LoadRulesList</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><RuleTypeNot>6</RuleTypeNot><OrderBy></OrderBy><RuleId></RuleId><RuleType></RuleType><RuleText>If ''{Supplier.CompanyMnemonic}'' == ''1111097'' &amp; ''{DeliveryLocation.LocationCode}'' == ''1111097'' &amp;{Order.OrderTime} &gt; 15 Then {Rule.Result} = AddDays(''{Order.OrderDate}''+ ''{3}'' )</RuleText><RuleTextCriteria>contains</RuleTextCriteria><Enable>1</Enable><FromDate></FromDate><FromDateCriteria></FromDateCriteria><ToDate></ToDate><ToDateCriteria></ToDateCriteria><CompanyType></CompanyType><CompanyTypeCriteria></CompanyTypeCriteria></Json>'
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
DECLARE @roleId bigint

Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(100)
Declare @RuleType INT
Declare @RuleTypeNot NVARCHAR(MAX)
declare @Enable nvarchar(2)
Declare @RuleId nvarchar(max)

DECLARE @RuleText nvarchar(max)
DECLARE @RuleTextCriteria nvarchar(50)

DECLARE @CompanyType nvarchar(150)
DECLARE @CompanyTypeCriteria nvarchar(50)

DECLARE @FromDate nvarchar(150)
DECLARE @FromDateCriteria nvarchar(50)

DECLARE @ToDate nvarchar(150)
DECLARE @ToDateCriteria nvarchar(50)

set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 

    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
	@RuleId=tmp.[RuleId],
    @OrderBy = tmp.[OrderBy],
	@RuleType = tmp.[RuleType],
	@RuleText = tmp.[RuleText],
	@RuleTextCriteria = tmp.[RuleTextCriteria],
	@FromDate = tmp.[FromDate],
	@FromDateCriteria = tmp.[FromDateCriteria],
	@ToDate = tmp.[ToDate],
	@ToDateCriteria = tmp.[ToDateCriteria],
	@CompanyType = tmp.[CompanyType],
	@CompanyTypeCriteria = tmp.[CompanyTypeCriteria],
	@Enable=tmp.[Enable],
	@RuleTypeNot=tmp.[RuleTypeNot]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [RuleId] nvarchar(max),
   [OrderBy] nvarchar(2000),
   [RuleText]  nvarchar(150),
   [RuleTextCriteria] nvarchar(50),
   [CompanyType]  nvarchar(150),
   [CompanyTypeCriteria] nvarchar(50),
   [FromDate]  nvarchar(150),
   [FromDateCriteria] nvarchar(50),
   [ToDate]  nvarchar(150),
   [ToDateCriteria] nvarchar(50),
   [Enable] nvarchar(2),
   [RuleType] int,
   [RuleTypeNot] nvarchar(max)
   
           
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @RuleTypeNot !=''
BEGIN
  SET @whereClause = @whereClause + ' and RuleType not in ( ' + @RuleTypeNot + ')'
END



IF @RuleId !=''
BEGIN
  SET @whereClause = @whereClause + ' and RuleId in ( ' + @RuleId + ')'
END

Print @RuleText
IF @RuleText !=''
BEGIN

  IF @RuleTextCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and REPLACE(RuleText, '''''''', '''') LIKE ''%' +  REPLACE(@RuleText, '''', '') + '%'''
  END
  IF @RuleTextCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and REPLACE(RuleText, '''''''', '''') NOT LIKE ''%' + REPLACE(@RuleText, '''''''', '''') + '%'''
  END
  IF @RuleTextCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and REPLACE(RuleText, '''''''', '''') LIKE ''' + REPLACE(@RuleText, '''''''', '''') + '%'''
  END
  IF @RuleTextCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and REPLACE(RuleText, '''''''', '''') LIKE ''%' + REPLACE(@RuleText, '''''''', '''') + ''''
  END          
  IF @RuleTextCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and REPLACE(RuleText, '''''''', '''') =  ''' +REPLACE(@RuleText, '''''''', '''')+ ''''
  END
  IF @RuleTextCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and REPLACE(RuleText, '''''''', '''') <>  ''' +REPLACE(@RuleText, '''''''', '''')+ ''''
  END
END

IF @FromDate !=''
BEGIN

  IF @FromDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and FromDate LIKE ''%' + @FromDate + '%'''
  END
  IF @FromDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and FromDate NOT LIKE ''%' + @FromDate + '%'''
  END
  IF @FromDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and FromDate LIKE ''' + @FromDate + '%'''
  END
  IF @FromDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and FromDate LIKE ''%' + @FromDate + ''''
  END          
  IF @FromDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),FromDate,103) =  ''' + CONVERT(varchar(11),@FromDate,103) + ''''
  END
  IF @FromDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and FromDate <>  ''' + @FromDate + ''''
  END
END


IF @ToDate !=''
BEGIN

  IF @ToDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ToDate LIKE ''%' + @ToDate + '%'''
  END
  IF @ToDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ToDate NOT LIKE ''%' + @ToDate + '%'''
  END
  IF @ToDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ToDate LIKE ''' + @ToDate + '%'''
  END
  IF @ToDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ToDate LIKE ''%' + @ToDate + ''''
  END          
  IF @ToDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),ToDate,103) =  ''' + CONVERT(varchar(11),@ToDate,103) + ''''
  END
  IF @ToDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ToDate <>  ''' + @ToDate + ''''
  END
END


print @RuleType
Print @RuleText

set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
	  	 [RuleId]
	    ,[RuleType]
		,(Select top 1 ISNULL((Select top 1 ResourceValue from Resources where ResourceKey = lo.ResourceKey and CultureId = ''1101''),lo.Name)   from LookUp lo where lo.Code=convert(nvarchar,[RuleType]) and lo.Lookupcategory = 16) as [RuleTypeName]
	    ,[RuleText]
	    ,isnull([RuleName],''-'') as [RuleName]
	    ,[Remarks]
	    ,[SequenceNumber]
	    ,CONVERT(varchar(11),FromDate,103) as FromDate
      ,CONVERT(varchar(11),ToDate,103) as ToDate
	    ,[IsResponseRequired]
	    ,[ResponseProperty]
	    ,[Enable]
	    ,[CreatedBy]
	    ,[CreatedDate]
	    ,[ModifiedBy]
	    ,[ModifiedDate]
	    ,[IsActive]

 from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(ModifiedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
	 [RuleId]
  ,[RuleType]
  ,[RuleText]
  ,[RuleName]
  ,[Remarks]
  ,[SequenceNumber]
  ,[FromDate]
  ,[ToDate]
  ,[IsResponseRequired]
  ,[ResponseProperty]
  ,[Enable]
  ,[CreatedBy]
  ,[CreatedDate]
  ,[ModifiedBy]
  ,[ModifiedDate]
  ,[IsActive]
	  from Rules
 where  (RuleType = '+ CONVERT(NVARCHAR(20), @RuleType) +' or '+ CONVERT(NVARCHAR(20), @RuleType) +'=0) and Isnull([Enable],0) ='+@Enable+' and IsActive = 1 and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''RuleList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   EXEC sp_executesql @sql
END