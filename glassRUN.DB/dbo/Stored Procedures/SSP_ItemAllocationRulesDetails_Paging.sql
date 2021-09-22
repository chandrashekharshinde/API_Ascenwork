CREATE PROCEDURE [dbo].[SSP_ItemAllocationRulesDetails_Paging] --'<Json><ServicesAction>LoadItemAllocationRulesDetailsList_ExportToExcel</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><CompanyType></CompanyType><CompanyTypeCriteria></CompanyTypeCriteria><SKUCode></SKUCode><SKUCodeCriteria></SKUCodeCriteria><Company></Company><CompanyCriteria></CompanyCriteria><Description></Description><DescriptionCriteria></DescriptionCriteria><RemainingQuantity></RemainingQuantity><RemainingQuantityCriteria></RemainingQuantityCriteria><RoleId>3</RoleId><CompanyMnemonic /><AllocatedValue></AllocatedValue><AllocatedValueCriteria></AllocatedValueCriteria><FromDate></FromDate><FromDateCriteria></FromDateCriteria><ToDate></ToDate><ToDateCriteria></ToDateCriteria><IsExportToExcel>true</IsExportToExcel></Json>'
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

--CompanyType
--CompanyTypeCriteria
--SKUCode
--SKUCodeCriteria
--Company
--CompanyCriteria


DECLARE @CompanyType nvarchar(max)
DECLARE @CompanyTypeCriteria nvarchar(max)

DECLARE @SKUCode nvarchar(max)
DECLARE @SKUCodeCriteria nvarchar(max)

DECLARE @RemainingQuantity nvarchar(max)
DECLARE @RemainingQuantityCriteria nvarchar(max)

DECLARE @Company nvarchar(max)
DECLARE @CompanyCriteria nvarchar(max)

DECLARE @Description nvarchar(max)
DECLARE @DescriptionCriteria nvarchar(max)

DECLARE @AllocatedValue nvarchar(max)
DECLARE @AllocatedValueCriteria nvarchar(max)


DECLARE @FromDate nvarchar(150)
DECLARE @FromDateCriteria nvarchar(50)

DECLARE @ToDate nvarchar(150)
DECLARE @ToDateCriteria nvarchar(50)

DECLARE @CompanyMnemonic nvarchar(max)

Declare @IsExportToExcel bit = 0
Declare @PaginationClause nvarchar(max) = ''


set  @whereClause =''

set @whereClauseIcon=''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyType = tmp.[CompanyType],
    @CompanyTypeCriteria = tmp.[CompanyTypeCriteria],
	@SKUCode = tmp.[SKUCode],
    @SKUCodeCriteria = tmp.[SKUCodeCriteria],
	
	@Company = tmp.[Company],
	@CompanyCriteria = tmp.[CompanyCriteria],

	@Description = tmp.[Description],
	@DescriptionCriteria = tmp.[DescriptionCriteria],

	@RemainingQuantity = tmp.[RemainingQuantity],
	@RemainingQuantityCriteria = tmp.[RemainingQuantityCriteria],

	@FromDate = tmp.[FromDate],
	@FromDateCriteria = tmp.[FromDateCriteria],

	@ToDate = tmp.[ToDate],
	@ToDateCriteria = tmp.[ToDateCriteria],

    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],

	@roleId = tmp.[RoleId],
	@CompanyMnemonic = tmp.[CompanyMnemonic],
	@AllocatedValue=tmp.AllocatedValue,
	@AllocatedValueCriteria=tmp.AllocatedValueCriteria,
   @IsExportToExcel = tmp.[IsExportToExcel]
	

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [CompanyType] nvarchar(max),
   [CompanyTypeCriteria] nvarchar(max),
   [SKUCode]  nvarchar(max),
   [SKUCodeCriteria] nvarchar(max),
   [RemainingQuantity] nvarchar(max),
   [RemainingQuantityCriteria] nvarchar(max),
   [Company]  nvarchar(max),
   [CompanyCriteria] nvarchar(max),
   [Description]  nvarchar(max),
   [DescriptionCriteria] nvarchar(max),
   [RoleId] bigint,
   [CompanyMnemonic] nvarchar(100),
    AllocatedValue nvarchar(max),
   AllocatedValueCriteria nvarchar(max),
   [IsExportToExcel] bit,
   FromDate nvarchar(150),
   FromDateCriteria nvarchar(50),
   ToDate nvarchar(150),
   ToDateCriteria nvarchar(50)
           
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

IF @CompanyType !=''
BEGIN

  IF @CompanyTypeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyType LIKE ''%' + @CompanyType + '%'''
  END
  IF @CompanyTypeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyType NOT LIKE ''%' + @CompanyType + '%'''
  END
  IF @CompanyTypeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyType LIKE ''' + @CompanyType + '%'''
  END
  IF @CompanyTypeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyType LIKE ''%' + @CompanyType + ''''
  END          
  IF @CompanyTypeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CompanyType =  ''' +@CompanyType+ ''''
  END
  IF @CompanyTypeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and CompanyType <>  ''' +@CompanyType+ ''''
  END
END

IF @SKUCode !=''
BEGIN

  IF @SKUCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SKUCode LIKE ''%' + @SKUCode + '%'''
  END
  IF @SKUCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SKUCode NOT LIKE ''%' + @SKUCode + '%'''
  END
  IF @SKUCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SKUCode LIKE ''' + @SKUCode + '%'''
  END
  IF @SKUCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and SKUCode LIKE ''%' + @SKUCode + ''''
  END          
  IF @SKUCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and SKUCode =  ''' +@SKUCode+ ''''
  END
  IF @SKUCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and SKUCode <>  ''' +@SKUCode+ ''''
  END
END

IF @Company !=''
BEGIN

  IF @CompanyCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Company LIKE ''%' + @Company + '%'''
  END
  IF @CompanyCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Company NOT LIKE ''%' + @Company + '%'''
  END
  IF @CompanyCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Company LIKE ''' + @Company + '%'''
  END
  IF @CompanyCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Company LIKE ''%' + @Company + ''''
  END          
  IF @CompanyCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Company =  ''' +@Company+ ''''
  END
  IF @CompanyCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Company <>  ''' +@Company+ ''''
  END
END
;


IF @Description !=''
BEGIN

  IF @DescriptionCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field1 LIKE ''%' + @Description + '%'''
  END
  IF @DescriptionCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field1 NOT LIKE ''%' + @Description + '%'''
  END
  IF @DescriptionCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field1 LIKE ''' + @Description + '%'''
  END
  IF @DescriptionCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Field1 LIKE ''%' + @Description + ''''
  END          
  IF @DescriptionCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and Field1 =  ''' +@Description+ ''''
  END
  IF @DescriptionCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and Field1 <>  ''' +@Description+ ''''
  END
END
;



IF @RemainingQuantity !=''
BEGIN

  IF @RemainingQuantityCriteria = 'gte'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))) - (select ISNULL([dbo].[fn_UsedProductQuantityByItemAndCompany](Rules.SKUCode,Rules.FromDate,Rules.ToDate,(select CompanyId from Company where CompanyMnemonic = Rules.CompanyType)),0)))) >= ''' + @RemainingQuantity + ''''
  END
  IF @RemainingQuantityCriteria = 'gt'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))) - (select ISNULL([dbo].[fn_UsedProductQuantityByItemAndCompany](Rules.SKUCode,Rules.FromDate,Rules.ToDate,(select CompanyId from Company where CompanyMnemonic = Rules.CompanyType)),0)))) > ''' + @RemainingQuantity + ''''
  END
  IF @RemainingQuantityCriteria = 'lte'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))) - (select ISNULL([dbo].[fn_UsedProductQuantityByItemAndCompany](Rules.SKUCode,Rules.FromDate,Rules.ToDate,(select CompanyId from Company where CompanyMnemonic = Rules.CompanyType)),0)))) <= ''' + @RemainingQuantity + ''''
  END
  IF @RemainingQuantityCriteria = 'lt'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))) - (select ISNULL([dbo].[fn_UsedProductQuantityByItemAndCompany](Rules.SKUCode,Rules.FromDate,Rules.ToDate,(select CompanyId from Company where CompanyMnemonic = Rules.CompanyType)),0)))) < ''' + @RemainingQuantity + ''''
  END          
  IF @RemainingQuantityCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))) - (select ISNULL([dbo].[fn_UsedProductQuantityByItemAndCompany](Rules.SKUCode,Rules.FromDate,Rules.ToDate,(select CompanyId from Company where CompanyMnemonic = Rules.CompanyType)),0)))) =  ''' +@RemainingQuantity+ ''''
  END
  IF @RemainingQuantityCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))) - (select ISNULL([dbo].[fn_UsedProductQuantityByItemAndCompany](Rules.SKUCode,Rules.FromDate,Rules.ToDate,(select CompanyId from Company where CompanyMnemonic = Rules.CompanyType)),0)))) <>  ''' +@RemainingQuantity+ ''''
  END
END




IF @AllocatedValue !=''
BEGIN

  IF @AllocatedValueCriteria = 'gte'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))))) = ''' + @AllocatedValue + ''''
  END
  IF @AllocatedValueCriteria = 'gt'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))))) > ''' + @AllocatedValue + ''''
  END
  IF @AllocatedValueCriteria = 'lte'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))))) <= ''' + @AllocatedValue + ''''
  END
  IF @AllocatedValueCriteria = 'lt'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))))) < ''' + @AllocatedValue + ''''
  END          
  IF @AllocatedValueCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))))) =  ''' +@AllocatedValue+ ''''
  END
  IF @AllocatedValueCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Convert(bigint,(LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))))) <>  ''' +@AllocatedValue+ ''''
  END
END



IF @FromDate !=''
BEGIN

IF @FromDateCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,FromDate,103) = CONVERT(date,'''+@FromDate+''',103)'
		END
	Else IF @FromDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,FromDate,103) > DATEADD(DAY,-1,CONVERT(date,'''+@FromDate+''',103))'
		END
	Else IF @FromDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,FromDate,103) < CONVERT(date,'''+@FromDate+''',103)'
		END
END

IF @ToDate !=''
BEGIN

IF @ToDateCriteria = '='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,ToDate,103) = CONVERT(date,'''+@ToDate+''',103)'
		END
	Else IF @ToDateCriteria = '>='
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,ToDate,103) > DATEADD(DAY,-1,CONVERT(date,'''+@ToDate+''',103))'
		END
	Else IF @ToDateCriteria = '<'
		BEGIN
			SET @whereClause = @whereClause + ' and CONVERT(date,ToDate,103) < CONVERT(date,'''+@ToDate+''',103)'
		END
END


If @roleId = 4
Begin 
SET @whereClause = @whereClause + 'and CompanyType = '+ @CompanyMnemonic +''
End

If @IsExportToExcel != '0'
	Begin			
		SET @PaginationClause = '1=1'
	End
Else
	Begin
		SET @PaginationClause = [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)
	ENd

set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
AllocatedValue,
UsedQuantity,
(AllocatedValue - UsedQuantity) as RemainingQuantity,
case when (AllocatedValue - UsedQuantity) > 0 then 1 else 0 end as PositiveAllocationQuantity ,
[RuleId]
      ,[RuleType]
      ,[RuleText]
      ,[SKUCode]
	 , ItemName
      ,[CompanyType]
      ,[Remarks]

      ,[SequenceNumber],
	   FromDate,
	    ToDate,
	  Company,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
	  ,[Field1] as [Description]
 from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(ModifiedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount
,(SELECT [dbo].[fn_GetThenValueFromRule] (LTRIM(RTRIM(SUBSTRING(RuleText, CHARINDEX(''Then'', RuleText) + 4, LEN(RuleText)))))) as AllocatedValue

,(select ISNULL([dbo].[fn_UsedProductQuantityByItemAndCompany](Rules.SKUCode,Rules.FromDate,Rules.ToDate,(select CompanyId from Company where CompanyMnemonic = Rules.CompanyType)),0)) as UsedQuantity

,[RuleId]
      ,[RuleType]
      ,[RuleText]
      ,[SKUCode]
	 ,(select   ISNULL(STUFF((SELECT '','' +    I.ItemName  from Item i where i.ItemCode in  (SELECT * FROM [dbo].[fnSplitValues](Rules.SKUCode)) FOR XML PATH('''')
),1,1,''''),'''') ) as ItemName
      ,[CompanyType]
      ,[Remarks]
      ,[SequenceNumber]
      ,[FromDate]
      ,[ToDate]
	  ,Company
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
	  ,[Field1]
	  from (SELECT [RuleId]
      ,[RuleType]
      ,[RuleText]
	  ,(SELECT [dbo].[fn_GetSKUCodeAndCompanyMnemonicFromRule] (Rules.[RuleId],''SKUCode'')) as [SKUCode]
	   ,(SELECT [dbo].[fn_GetSKUCodeAndCompanyMnemonicFromRule] (Rules.[RuleId],''CompanyMnemonic'')) as [CompanyType]
	   ,(SELECT top 1 case when SUBSTRING(CompanyName,0,CHARINDEX(''-'',CompanyName,0))='''' then SUBSTRING(CompanyName,1,5) else 
	  isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',CompanyName,0)),SUBSTRING(CompanyName,1,5))  end FROM Company where CompanyMnemonic=(SELECT [dbo].[fn_GetSKUCodeAndCompanyMnemonicFromRule] (Rules.[RuleId],''CompanyMnemonic''))) as Company

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
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
  FROM [dbo].[Rules] where IsActive=1 and RuleType=2)
	  as Rules where IsActive=1 and RuleType=2 and  ' + @whereClause +') as tmp where '+ @PaginationClause + '
 FOR XML path(''RuleList''),ELEMENTS,ROOT(''Rule'')) AS XML)'
  PRINT @sql
   execute (@sql)
END
