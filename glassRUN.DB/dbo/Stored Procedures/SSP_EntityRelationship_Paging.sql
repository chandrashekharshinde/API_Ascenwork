CREATE PROCEDURE [dbo].[SSP_EntityRelationship_Paging] --'<Json><ServicesAction>LoadRulesList</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><RuleType>1</RuleType><RuleText></RuleText><RuleTextCriteria></RuleTextCriteria><FromDate></FromDate><FromDateCriteria></FromDateCriteria><ToDate></ToDate><ToDateCriteria></ToDateCriteria><CompanyType></CompanyType><CompanyTypeCriteria></CompanyTypeCriteria></Json>'
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
Declare @PrimaryEntity nvarchar(max)

DECLARE @RuleText nvarchar(150)
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
	@PrimaryEntity=tmp.[PrimaryEntity],
    @OrderBy = tmp.[OrderBy]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [PrimaryEntity] nvarchar(max),
   [OrderBy] nvarchar(2000)
  
           
   )tmp

   

IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF(RTRIM(@whereClauseIcon) = '') BEGIN SET @whereClauseIcon = '1=1' END




SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


IF @RuleTypeNot !=''
BEGIN
  SET @whereClause = @whereClause + ' and RuleType not in ( ' + @RuleTypeNot + ')'
END



IF @PrimaryEntity !=''
BEGIN
  SET @whereClause = @whereClause + ' and PrimaryEntity in ( ' + @PrimaryEntity + ')'
END




set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
PrimaryEntity,
CompanyName,
RelatedEntity,
[IsActive]

 from (
Select ROW_NUMBER() OVER (ORDER BY  PrimaryEntity desc) as rownumber , COUNT(*) OVER () as TotalCount,* from (
select distinct  es.PrimaryEntity,es.IsActive,
(Select top 1 c1.CompanyName from Company c1 where c1.CompanyId=es.PrimaryEntity) as CompanyName,
  STUFF(
         (SELECT '', '' + c2.CompanyName +''(''+c2.CompanyMnemonic+'')'' From Company c2 where c2.CompanyId in(Select es1.RelatedEntity from  EntityRelationship  es1 where es1.PrimaryEntity=es.PrimaryEntity)
          FOR XML PATH (''''))
          , 1, 1, '''')  AS RelatedEntity
from EntityRelationship  es where es.isactive=1) as EntityRelationship
 where IsActive=1 and  ' + @whereClause +' ) as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''EntityRelationshipList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   EXEC sp_executesql @sql
END
