CREATE PROCEDURE [dbo].[SSP_GetOrderProductById]-- '<Json><ServicesAction>LoadOrderProductById</ServicesAction><OrderId>1</OrderId></Json>'
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

SELECT @OrderId = tmp.[OrderId]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[OrderId] int
			)tmp


				SET @sql = 'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) select cast ((SELECT ''true'' AS [@json:Array]  , * FROM (SELECT	t.[OrderId],
				t.OrderProductId,
			
	       t.ProductCode,
		   t.ProductQuantity,
		   i.ItemName
		   ,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as UOM
		   ,i.[ItemName] + '' ('' + i.[ItemCode] + '')'' as ItemNameCode
            from OrderProduct t left join Item i on t.ProductCode = i.ItemCode
				WHERE t.ProductCode<>65999001 and t.IsActive = 1 and t.OrderId='+ CAST(@OrderId as nvarchar(MAX))+' ) tmp
 FOR XML path(''OrderProductList''),ELEMENTS,ROOT(''Json'')) AS XML)'



   	EXEC sp_executesql @sql




END
