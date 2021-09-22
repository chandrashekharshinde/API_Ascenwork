CREATE PROCEDURE [dbo].[SSP_LoadOrderDocument_ByOrderId] --'<Json><OrderId>75994</OrderId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @orderId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @orderId = tmp.[OrderId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[OrderId] bigint
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array], OrderDocumentId,OrderId,DocumentTypeId,DocumentFormat,DocumentBlob
			   		FROM OrderDocument  WHERE  OrderId = @orderId and DocumentTypeId in (select LookUpId from LookUp where Code = 'PickSlip')
	FOR XML path('OrderDocumentList'),ELEMENTS,ROOT('Json')) AS XML)
END
