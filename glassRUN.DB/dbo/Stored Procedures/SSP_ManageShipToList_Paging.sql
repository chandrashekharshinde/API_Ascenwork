CREATE PROCEDURE [dbo].[SSP_ManageShipToList_Paging] --'<Json><ServicesAction>ManageShipToList</ServicesAction><PageIndex>0</PageIndex><PageSize>10</PageSize><OrderBy></OrderBy></Json>'
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
Declare @OrderBy NVARCHAR(100)

DECLARE @CompanyName nvarchar(150)
DECLARE @CompanyNameCriteria nvarchar(50)

DECLARE @CompanyMnemonic nvarchar(150)
DECLARE @CompanyMnemonicCriteria nvarchar(50)

DECLARE @DeliveryLocationName nvarchar(150)
DECLARE @DeliveryLocationNameCriteria nvarchar(50)

DECLARE @DisplayName nvarchar(150)
DECLARE @DisplayNameCriteria nvarchar(50)

DECLARE @DeliveryLocationCode nvarchar(150)
DECLARE @DeliveryLocationCodeCriteria nvarchar(50)

set  @whereClause =''

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT  @PageSize = tmp.[PageSize],
        @PageIndex = tmp.[PageIndex],
        @OrderBy = tmp.[OrderBy],

		@CompanyName = tmp.[CompanyName],
		@CompanyNameCriteria = tmp.[CompanyNameCriteria],

		@CompanyMnemonic = tmp.[CompanyMnemonic],
		@CompanyMnemonicCriteria = tmp.[CompanyMnemonicCriteria],

		@DeliveryLocationName = tmp.[DeliveryLocationName],
		@DeliveryLocationNameCriteria = tmp.[DeliveryLocationNameCriteria],

		@DisplayName = tmp.[DisplayName],
		@DisplayNameCriteria = tmp.[DisplayNameCriteria],

		@DeliveryLocationCode = tmp.[DeliveryLocationCode],
		@DeliveryLocationCodeCriteria = tmp.[DeliveryLocationCodeCriteria]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),

   [CompanyName] nvarchar(150),
   [CompanyNameCriteria] nvarchar(50),
              
   [CompanyMnemonic] nvarchar(150),
   [CompanyMnemonicCriteria] nvarchar(50),

   [DeliveryLocationName] nvarchar(150),
   [DeliveryLocationNameCriteria] nvarchar(50),

   [DisplayName] nvarchar(150),
   [DisplayNameCriteria] nvarchar(50),

   [DeliveryLocationCode] nvarchar(150),
   [DeliveryLocationCodeCriteria] nvarchar(50)

   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'CompanyId  desc' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

IF @CompanyName !=''
BEGIN

  IF @CompanyNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,15) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,15)) end LIKE ''%' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,15) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,15)) end NOT LIKE ''%' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,15) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,15)) end LIKE ''' + @CompanyName + '%'''
  END
  IF @CompanyNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,15) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,15)) end LIKE ''%' + @CompanyName + ''''
  END          
  IF @CompanyNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,15) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,15)) end =  ''' +@CompanyName+ ''''
  END
  IF @CompanyNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,15) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,15)) end <>  ''' +@CompanyName+ ''''
  END
END

IF @CompanyMnemonic !=''
BEGIN

  IF @CompanyMnemonicCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyMnemonic LIKE ''%' + @CompanyMnemonic + '%'''
  END
  IF @CompanyMnemonicCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyMnemonic NOT LIKE ''%' + @CompanyMnemonic + '%'''
  END
  IF @CompanyMnemonicCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyMnemonic LIKE ''' + @CompanyMnemonic + '%'''
  END
  IF @CompanyMnemonicCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and CompanyMnemonic LIKE ''%' + @CompanyMnemonic + ''''
  END          
  IF @CompanyMnemonicCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CompanyMnemonic =  ''' + @CompanyMnemonic + ''''
  END
  IF @CompanyMnemonicCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and CompanyMnemonic <>  ''' + @CompanyMnemonic + ''''
  END
END

IF @DeliveryLocationName !=''
BEGIN

  IF @DeliveryLocationNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName LIKE ''%' + @DeliveryLocationName + '%'''
  END
  IF @DeliveryLocationNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName NOT LIKE ''%' + @DeliveryLocationName + '%'''
  END
  IF @DeliveryLocationNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName LIKE ''' + @DeliveryLocationName + '%'''
  END
  IF @DeliveryLocationNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationName LIKE ''%' + @DeliveryLocationName + ''''
  END          
  IF @DeliveryLocationNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationName =  ''' + @DeliveryLocationName + ''''
  END
  IF @DeliveryLocationNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationName <>  ''' + @DeliveryLocationName + ''''
  END
END

IF @DisplayName !=''
BEGIN

  IF @DisplayNameCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DisplayName LIKE ''%' + @DisplayName + '%'''
  END
  IF @DisplayNameCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DisplayName NOT LIKE ''%' + @DisplayName + '%'''
  END
  IF @DisplayNameCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DisplayName LIKE ''' + @DisplayName + '%'''
  END
  IF @DisplayNameCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DisplayName LIKE ''%' + @DisplayName + ''''
  END          
  IF @DisplayNameCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and DisplayName =  ''' + @DisplayName + ''''
  END
  IF @DisplayNameCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and DisplayName <>  ''' + @DisplayName + ''''
  END
END

IF @DeliveryLocationCode !=''
BEGIN

  IF @DeliveryLocationCodeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''%' + @DeliveryLocationCode + '%'''
  END
  IF @DeliveryLocationCodeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode NOT LIKE ''%' + @DeliveryLocationCode + '%'''
  END
  IF @DeliveryLocationCodeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''' + @DeliveryLocationCode + '%'''
  END
  IF @DeliveryLocationCodeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and DeliveryLocationCode LIKE ''%' + @DeliveryLocationCode + ''''
  END          
  IF @DeliveryLocationCodeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationCode =  ''' + @DeliveryLocationCode + ''''
  END
  IF @DeliveryLocationCodeCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and DeliveryLocationCode <>  ''' + @DeliveryLocationCode + ''''
  END
END



 SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT  ''true'' AS [@json:Array]  ,[DeliveryLocationId],
  rownumber,TotalCount,
  CompanyName,
  CompanyMnemonic,
  DeliveryLocationName,
  DisplayName,
  DeliveryLocationCode,
  Area,
  IsActive
   from 
 
 (SELECT  ROW_NUMBER() OVER (ORDER BY dl.CompanyID desc) as rownumber , COUNT(*) OVER () as TotalCount,dl.[DeliveryLocationId],
   case when SUBSTRING(c.CompanyName,0,CHARINDEX(''-'',c.CompanyName,0))='''' then SUBSTRING(c.CompanyName,1,15) else isnull(SUBSTRING(CompanyName,0,CHARINDEX(''-'',c.CompanyName,0)),SUBSTRING(c.CompanyName,1,15)) end as CompanyName , c.CompanyMnemonic,DeliveryLocationName,ISNULL(DisplayName,DeliveryLocationName) as DisplayName,DeliveryLocationCode,Area,
   dl.IsActive from DeliveryLocation dl join Company c on dl.CompanyID = c.CompanyId
where LocationType = 27 and c.companytype = 22 and ' + @whereClause +'  ) as tmp where '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
	FOR XML PATH(''ShipToList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  
   PRINT @sql
	--SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
	EXEC sp_executesql @sql

END
