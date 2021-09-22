
create PROCEDURE [dbo].[SSP_RequiredOrderDocumentByOrderId] --1
@OrderId BIGINT
AS
BEGIN

	SELECT  OrderDocumentId ,
	        OrderId ,
	        DocumentTypeId ,
	        DocumentFormat ,
	        DocumentBlob ,
	        
			Lookup.Name AS DocumentType,Lookup.Code AS lookupCode,OrderProductId FROM OrderDocument JOIN Lookup ON OrderDocument.DocumentTypeId=Lookup.LookupID WHERE OrderId=@OrderId AND DocumentTypeId IN (302,303,309,310)

	
	
END