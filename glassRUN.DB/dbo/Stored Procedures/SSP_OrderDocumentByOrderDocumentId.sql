

CREATE PROCEDURE [dbo].[SSP_OrderDocumentByOrderDocumentId] --'<Json><OrderDocumentId>75994</OrderDocumentId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @OrderDocumentId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @OrderDocumentId = tmp.[OrderDocumentId]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[OrderDocumentId] bigint
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array]
								,OrderDocumentId
								,OrderId
								,DocumentTypeId
								,(SELECT dbo.fn_LookupValueById(DocumentTypeId)) as 'DocumentType'
								,DocumentFormat
								,DocumentBlob
			   		FROM OrderDocument  WHERE  OrderDocumentId = @OrderDocumentId
	FOR XML path('OrderDocumentList'),ELEMENTS,ROOT('Json')) AS XML)
END