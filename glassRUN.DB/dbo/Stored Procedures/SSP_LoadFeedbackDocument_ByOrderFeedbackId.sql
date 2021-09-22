CREATE PROCEDURE [dbo].[SSP_LoadFeedbackDocument_ByOrderFeedbackId] --'<Json><OrderId>1</OrderId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @OrderFeedbackId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @OrderFeedbackId = tmp.[OrderFeedbackId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[OrderFeedbackId] bigint
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array], DocumentsId,DocumentName,DocumentExtension as DocumentFormat,DocumentBase64 as DocumentBlob,ObjectId,ObjectType
		from Documents   WHERE  IsActive = 1 AND ObjectId = @OrderFeedbackId
	FOR XML path('OrderDocumentList'),ELEMENTS,ROOT('Json')) AS XML)
END
