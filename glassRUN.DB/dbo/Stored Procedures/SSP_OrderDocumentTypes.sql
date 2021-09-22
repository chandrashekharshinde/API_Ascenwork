CREATE PROCEDURE [dbo].[SSP_OrderDocumentTypes] --'<Json><ServicesAction>LoadOrderDocumentTypes</ServicesAction><LoginId>464</LoginId><PageName>ControlTower</PageName></Json>'
(
@xmlDoc XML
)
AS

BEGIN

DECLARE @intPointer INT;
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

Declare @SQL nvarchar(max)
Declare @WhereClause nvarchar(max)

Declare @LoginId bigint
Declare @PageName nvarchar(100)

		SELECT 
			@LoginId = tmp.[LoginId],
			@PageName = tmp.[PageName]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[LoginId] bigint,
			[PageName] nvarchar(100)
		)tmp ;



SET @WhereClause = (SELECT [dbo].[fn_GetUserAndDimensionAndPageWiseWhereClause] (@LoginId , @PageName) )


SET @SQL = '
WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)
	SELECT CAST((SELECT ''true'' AS [@json:Array], 
					LookUpId
,LookupCategory
,Name
,Code
,Description
,ShortCode
,SortOrder
,ResourceKey
,Criteria
,ParentId
,Remarks
,CreatedBy
,CreatedDate
,ModifiedBy
,ModifiedDate
,IsActive
,SequenceNo
,Field1
,Field2
,Field3
,Field4
,Field5
,Field6
,Field7
,Field8
,ISNULL(Field9,'''') as Field9
,ISNULL(Field10,'''') as Field10
FROM LOOKUP where LookupCategory = (select LookUpCategoryId from LookupCategory where Name = ''DocumentType'') ' + @whereClause +'
FOR XML path(''OrderDocumentTypeList''),ELEMENTS,ROOT(''Json'')) AS XML)'


print @whereClause
print @SQL
exec (@SQL)
END
