CREATE PROCEDURE [dbo].[SSP_OrderDocumentByOrderId] --1
@xmlDoc XML


AS

BEGIN
DECLARE @intPointer INT;
Declare @OrderId bigint
Declare @DocumentTypeId bigint
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
 @OrderId = tmp.[orderid],
 @DocumentTypeId= tmp.[docType]
	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			orderid bigint,
			docType bigint
			)tmp;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
SELECT CAST((SELECT top 1  'true' AS [@json:Array], OrderDocumentId ,
	        OrderId ,
	        DocumentTypeId ,
	        DocumentFormat ,
	        DocumentBlob ,
			'-' as [FileName],
	        (Select SettingValue from SettingMaster where SettingParameter='ServerURL') as ServerURL,
			 (Select SettingValue from SettingMaster where SettingParameter='OrderDocumentPath') as OrderDocumentPath,
			(SELECT OrderNumber FROM dbo.[Order] WHERE OrderId=@OrderId) AS OrderNumber,
			Lookup.Name AS DocumentType,Lookup.Code AS lookupCode,OrderProductId 
			FROM OrderDocument left JOIN Lookup ON OrderDocument.DocumentTypeId=Lookup.LookupID 
			WHERE OrderId=@OrderId and DocumentTypeId=@DocumentTypeId
FOR XML path('OrderDocumentList'),ELEMENTS,ROOT('OrderDocument')) AS XML)
	
	
END