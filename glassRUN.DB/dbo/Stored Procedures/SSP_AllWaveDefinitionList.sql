CREATE PROCEDURE [dbo].[SSP_AllWaveDefinitionList] --'<Json><ServicesAction>LoadWaveDefinitionDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><WaveDateTime></WaveDateTime><WaveDateTimeCriteria></WaveDateTimeCriteria><RuleText></RuleText><RuleTextCriteria></RuleTextCriteria><UserId>7</UserId></Json>'
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

DECLARE @waveDateTime nvarchar(150)
DECLARE @waveDateTimeCriteria nvarchar(50)
DECLARE @ruleText nvarchar(150)
DECLARE @ruleTextCriteria nvarchar(50)
DECLARE @userId bigint

set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	@waveDateTime=tmp.[WaveDateTime],
	@waveDateTimeCriteria=tmp.[WaveDateTimeCriteria],
	@ruleText=tmp.[RuleText],
	@ruleTextCriteria=tmp.[RuleTextCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@userId=tmp.UserId
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),  
   [WaveDateTime] nvarchar(150),
   [WaveDateTimeCriteria] nvarchar(50),
   [RuleText] nvarchar(150),
   [RuleTextCriteria] nvarchar(50),
   UserId bigint
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'TransporterVehicleId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)




IF @ruleText !=''
BEGIN

  IF @ruleTextCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RuleText LIKE ''%' + @ruleText + '%'''
  END
  IF @ruleTextCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RuleText NOT LIKE ''%' + @ruleText + '%'''
  END
  IF @ruleTextCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RuleText LIKE ''' + @ruleText + '%'''
  END
  IF @ruleTextCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and RuleText LIKE ''%' + @ruleText + ''''
  END          
  IF @ruleTextCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and RuleText =  ''' +@ruleText+ ''''
  END
  IF @ruleTextCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and RuleText <>  ''' +@ruleText+ ''''
  END
END


set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
[WaveDefinitionId]
,convert(nvarchar,CAST(WaveDateTime as time),100) as WaveDateTime      
      ,[RuleText]
      ,[RuleType]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]

 from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(ModifiedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
[WaveDefinitionId]
      ,[WaveDateTime]
      ,[RuleText]
      ,[RuleType]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
 FROM [WaveDefinition]
	  WHERE IsActive = 1  and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''WaveDefinitionList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	   PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
