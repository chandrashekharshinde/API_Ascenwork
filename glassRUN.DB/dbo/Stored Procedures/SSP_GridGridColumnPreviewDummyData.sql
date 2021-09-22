

CREATE PROCEDURE [dbo].[SSP_GridGridColumnPreviewDummyData] --'<Json><ServicesAction>LoadGridColumnPagingList</ServicesAction><ObjectId>1</ObjectId></Json>'
(
@xmlDoc XML
)
AS

BEGIN

DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)

Declare @ObjectId  Nvarchar(100)=''

set  @whereClause =''

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT  
		@ObjectId = tmp.[ObjectId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   ([ObjectId] bigint
   )tmp

DECLARE @cols  AS NVARCHAR(MAX)='';
DECLARE @query AS NVARCHAR(MAX)='';
SELECT @cols = @cols + QUOTENAME(PropertyName) + ',' FROM (select distinct PropertyName from GridColumn where ObjectId=@objectid) as tmp
select @cols = substring(@cols, 0, len(@cols)) --trim "," at end

set @query = 
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  
select cast ((SELECT  ''true'' AS [@json:Array]  , * from (SELECT * from 
(
   select gc.PropertyName,gc.data1
	from GridColumn gc 
	where gc.ObjectId='+@objectid+'
) src
pivot 
(
    min(data1) for PropertyName in (' + @cols + ')
) piv
Union All
SELECT * from 
(
   select gc.PropertyName,gc.data2
	from GridColumn gc 
	where gc.ObjectId='+@objectid+'
) src
pivot 
(
    min(data2) for PropertyName in (' + @cols + ')
) piv
union all
SELECT * from 
(
    select gc.PropertyName,gc.data3
	from GridColumn gc 
	where gc.ObjectId='+@objectid+'
) src
pivot 
(
    max(data3) for PropertyName in (' + @cols + ')
) piv) as tmp
FOR XML PATH(''GridColumnDataPreviewList''),ELEMENTS,ROOT(''Json'')) AS XML)
'
print @query
execute(@query)

END
