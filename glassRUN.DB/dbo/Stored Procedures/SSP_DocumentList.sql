
CREATE PROCEDURE [dbo].[SSP_DocumentList] --'<Json><ObjectId>77437</ObjectId></Json>'
(
@xmlDoc XML
)
AS
BEGIN

DECLARE @objectId bigint=0

DECLARE @intPointer INT;
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @objectId = tmp.[ObjectId]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[ObjectId] bigint
			)tmp;
			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array]
							,DocumentsId
							,DocumentTypeId
							,(SELECT dbo.fn_LookupValueById(DocumentTypeId)) as 'DocumentType'
							,DocumentName
							,DocumentExtension
							--,DocumentBase64
							,ObjectId
							,ObjectType
							,SequenceNo
							,IsActive
							,CreatedBy
							,CreatedDate
							--,ModifiedBy
							--,ModifiedDate
FROM Documents  WHERE  ObjectId = @objectId
FOR XML path('DocumentList'),ELEMENTS,ROOT('Json')) AS XML)
END