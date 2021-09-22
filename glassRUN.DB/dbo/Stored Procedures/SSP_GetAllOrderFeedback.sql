CREATE PROCEDURE [dbo].[SSP_GetAllOrderFeedback] --'<Json><ServicesAction>LoadOrderProductById</ServicesAction><OrderId>1</OrderId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
Declare @OrderId INT
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
Declare @OrderBy NVARCHAR(20)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

--SELECT @OrderId = tmp.[OrderId]

--FROM OPENXML(@intpointer,'Json',2)
--			WITH
--			(
--			[OrderId] int
--			)tmp


				SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) select cast ((SELECT  ''true'' AS [@json:Array]  , * FROM (SELECT	t.[LookUpId],
	       t.Name
            from LookUp t left join LookUpCategory luc on t.LookupCategory = luc.LookUpCategoryId
				WHERE t.IsActive = 1 and luc.Name = ''CustomerFeedback'' ) tmp
 FOR XML path(''LookUpList''),ELEMENTS,ROOT(''Json'')) AS XML)'




 print @sql





   	EXEC sp_executesql @sql




END
