CREATE PROCEDURE [dbo].[SSP_AllItemList_paging] --'<Json><ServicesAction>LoadItemDertails</ServicesAction><PageIndex>0</PageIndex><PageSize>20</PageSize><OrderBy></OrderBy><OrderByCriteria></OrderByCriteria><ItemName></ItemName><ItemNameCriteria></ItemNameCriteria><ItemCode>12345</ItemCode><ItemCodeCriteria>=</ItemCodeCriteria><PrimaryUOM></PrimaryUOM><PrimaryUOMCriteria></PrimaryUOMCriteria><ItemNameEnglishLanguage></ItemNameEnglishLanguage><ItemNameEnglishLanguageCriteria></ItemNameEnglishLanguageCriteria></Json>'
(
	@xmlDoc XML
)
AS
BEGIN

Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(max)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)
Declare @CompanyId int
DECLARE @ItemName nvarchar(150)
DECLARE @ItemNameCriteria nvarchar(50)
DECLARE @ItemCode nvarchar(150)
DECLARE @ItemCodeCriteria nvarchar(50)
DECLARE @PrimaryUOM nvarchar(150)
DECLARE @PrimaryUOMCriteria nvarchar(50)
DECLARE @ItemNameEnglishLanguage nvarchar(150)
DECLARE @ItemNameEnglishLanguageCriteria nvarchar(50)

set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	@ItemName=tmp.[ItemName],
	@ItemNameCriteria=tmp.[ItemNameCriteria],
	@ItemCode=tmp.ItemCode,
	@ItemCodeCriteria=tmp.ItemCodeCriteria,
	@ItemNameEnglishLanguage=tmp.[ItemNameEnglishLanguage],
	@ItemNameEnglishLanguageCriteria=tmp.[ItemNameEnglishLanguageCriteria],
	@PrimaryUOM=tmp.PrimaryUOM,
	@PrimaryUOMCriteria=tmp.PrimaryUOMCriteria,
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@CompanyId = tmp.CompanyId
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
	  [PageIndex] int,
	  [PageSize] int,
	  [OrderBy] nvarchar(2000),  
	  [ItemName] nvarchar(150),
	  [ItemNameCriteria] nvarchar(50),
	  ItemCode nvarchar(50),
	  ItemCodeCriteria nvarchar(150),
	  [ItemNameEnglishLanguage] nvarchar(150),
	  [ItemNameEnglishLanguageCriteria] nvarchar(50),
	  PrimaryUOM nvarchar(200),
	  PrimaryUOMCriteria nvarchar(50),
	  CompanyId int
   )tmp

  

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'ItemId desc' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

IF @ItemName !=''
BEGIN

  IF @ItemNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemName LIKE ''%' + @ItemName + '%'''
  END
  IF @ItemNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemName NOT LIKE ''%' + @ItemName + '%'''
  END
  IF @ItemNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemName LIKE ''' + @ItemName + '%'''
  END
  IF @ItemNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemName LIKE ''%' + @ItemName + ''''
  END          
  IF @ItemNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ItemName =  ''' +@ItemName+ ''''
  END
  IF @ItemNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ItemName <>  ''' +@ItemName+ ''''
  END
END

IF @ItemCode !=''
BEGIN

  IF @ItemCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemCode LIKE ''%' + @ItemCode + '%'''
  END
  IF @ItemCodeCriteria = 'notcontains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemCode NOT LIKE ''%' + @ItemCode + '%'''
  END
  IF @ItemCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemCode LIKE ''' + @ItemCode + '%'''
  END
  IF @ItemCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemCode LIKE ''%' + @ItemCode + ''''
  END          
  IF @ItemCodeCriteria = '='
 BEGIN

 SET @whereClause = @whereClause + ' and ItemCode =  ''' +@ItemCode+ ''''
  END
  IF @ItemCodeCriteria = '<>'
 BEGIN

 SET @whereClause = @whereClause + ' and ItemCode <>  ''' +@ItemCode+ ''''
  END
END


IF @ItemNameEnglishLanguage !=''
BEGIN

  IF @ItemNameEnglishLanguageCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemNameEnglishLanguage LIKE ''%' + @ItemNameEnglishLanguage + '%'''
  END
  IF @ItemNameEnglishLanguageCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemNameEnglishLanguage NOT LIKE ''%' + @ItemNameEnglishLanguage + '%'''
  END
  IF @ItemNameEnglishLanguageCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemNameEnglishLanguage LIKE ''' + @ItemNameEnglishLanguage + '%'''
  END
  IF @ItemNameEnglishLanguageCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ItemNameEnglishLanguage LIKE ''%' + @ItemNameEnglishLanguage + ''''
  END          
  IF @ItemNameEnglishLanguageCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ItemNameEnglishLanguage =  ''' +@ItemNameEnglishLanguage+ ''''
  END
  IF @ItemNameEnglishLanguageCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ItemNameEnglishLanguage <>  ''' +@ItemNameEnglishLanguage+ ''''
  END
END

IF @PrimaryUOM !=''
BEGIN

  IF @PrimaryUOMCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) LIKE ''%' + @PrimaryUOM + '%'''
  END
  IF @PrimaryUOMCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) NOT LIKE ''%' + @PrimaryUOM + '%'''
  END
  IF @PrimaryUOMCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) LIKE ''' + @PrimaryUOM + '%'''
  END
  IF @PrimaryUOMCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) LIKE ''%' + @PrimaryUOM + ''''
  END          
  IF @PrimaryUOMCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) =  ''' +@PrimaryUOM+ ''''
  END
  IF @PrimaryUOMCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) <>  ''' +@PrimaryUOM+ ''''
  END
END


   

  SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT  ''true'' AS [@json:Array]  ,[ItemId],
  rownumber,TotalCount,
  ItemName,
  ItemNameEnglishLanguage,
  ItemCode,
  ItemShortCode,
  PrimaryUnitOfMeasure,
  PrimaryUOM,
  SecondaryUnitOfMeasure,
  ProductType,
  BussinessUnit
  ,[DangerGoods]
      ,[Description]
      ,[StockInQuantity]
      ,[WeightPerUnit]
      ,[ImageUrl]
      ,[PackSize]
      ,[BranchPlant]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo]
	  ,Amount
	  ,UOM
	  
      from 
      (SELECT  ROW_NUMBER() OVER (ORDER BY ItemId desc) as rownumber , COUNT(*) OVER () as TotalCount,[ItemId],
      ItemName,
	  ItemNameEnglishLanguage,
      ItemCode,
      ItemShortCode,
	  PrimaryUnitOfMeasure,
	  (Select top 1 Name from Lookup where LookupId=Item.PrimaryUnitOfMeasure) as PrimaryUOM,
	  SecondaryUnitOfMeasure,
	  ProductType,
	  BussinessUnit
	  ,[DangerGoods]
      ,[Description]
      ,[StockInQuantity]
      ,[WeightPerUnit]
      ,[ImageUrl]
      ,[PackSize]
      ,[BranchPlant]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo] 
	  ,(SELECT [dbo].[fn_GetPriceOfItem] ([ItemId],0)) as Amount
	  ,(SELECT [dbo].[fn_LookupValueById] (PrimaryUnitOfMeasure)) as UOM
	  
	  from Item WHERE ' + @whereClause +' and ItemCode not in (''55909001'',''55909002'',''55909003'')) as tmp where '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
	FOR XML PATH(''ItemList''),ELEMENTS,ROOT(''Json'')) AS XML)'


	   PRINT @sql
 
 EXEC sp_executesql @sql

END
