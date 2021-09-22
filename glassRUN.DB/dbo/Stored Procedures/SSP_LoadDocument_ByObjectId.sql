CREATE PROCEDURE [dbo].[SSP_LoadDocument_ByObjectId] --'<Json><ServicesAction>LoadObjectDocumentByObjectId</ServicesAction><ObjectId>9</ObjectId><ObjectType>Profile</ObjectType></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @ObjectId bigint=0;
declare @ObjectType nvarchar(50)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ObjectId = tmp.[ObjectId],
	@ObjectType = tmp.[ObjectType]
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[ObjectId] bigint,
				[ObjectType] nvarchar(50)
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array], 
DocumentName,
DocumentsId,
DocumentBase64 as DocumentBlob,
DocumentExtension as DocumentFormat,
ObjectId,
ObjectType
			   		FROM Documents  
					WHERE  DocumentsId = @ObjectId 
					
	FOR XML path('OrderDocumentList'),ELEMENTS,ROOT('Json')) AS XML)
END
