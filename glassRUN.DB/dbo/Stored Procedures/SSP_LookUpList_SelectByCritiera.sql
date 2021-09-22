CREATE PROCEDURE [dbo].[SSP_LookUpList_SelectByCritiera]-- '<Json><ServicesAction>LoadAllCompanyDetailListByDropDown</ServicesAction><CompanyType>23</CompanyType></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


declare @UserId bigint, 
  @PageName nvarchar(250),
   @PageControlName nvarchar(250)


SELECT @UserId = tmp.[UserId],
@PageName=tmp.[PageName],
@PageControlName  =tmp.[PageControlName ]
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
  
   [UserId] bigint,
   [PageName] nvarchar(250),
   [PageControlName] nvarchar(250)
  
   )tmp



set  @orderBy =''
set  @whereClause =''

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'tmp.[LookUpId]' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END



declare @dynamicExpression nvarchar(max);

set  @dynamicExpression  =(SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause] (@UserId,@PageName ,@PageControlName) )


SET @whereClause = @whereClause + ''+ @dynamicExpression

if(@dynamicExpression ='')
begin

SET @whereClause = '1 !=1 '


end






 SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ( (
   select ''true'' AS [@json:Array]  , * from ( SELECT    
 COUNT(LookUpId) OVER () as TotalCount,  LookUpId  , lc.Name  as ''LookUpCategoryName'' , l.Name  , Code  , ISNULL(l.Field9,'''') as Field9, ISNULL(l.Field10,'''') as Field10,
 Description   From   LookUp   l 
  join LookUpCategory  lc 
   on l.LookupCategory =lc.LookUpCategoryId ) tmp
   WHERE ' + @whereClause  + ' ORDER BY '+@orderBy+'   FOR XML path(''LookUpList''),ELEMENTS,ROOT(''Json'')) AS XML)'



   

 PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END