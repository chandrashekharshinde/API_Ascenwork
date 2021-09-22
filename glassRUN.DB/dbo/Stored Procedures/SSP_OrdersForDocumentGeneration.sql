
CREATE PROCEDURE [dbo].[SSP_OrdersForDocumentGeneration] 
AS
BEGIN
	SELECT CAST((
SELECT * FROM (


 SELECT OrderId,OrderNumber,OrderType,SupplierLOBId,LOBId,SupplierId,IsActive,DocumentTypeId,DocumentTypeText FROM 
(SELECT o.OrderId,o.OrderNumber,o.IsActive,od.OrderDocumentId,0 as SupplierLOBId,4 as LOBId,0 as SupplierId, 8000 as OrderType,(SELECT [dbo].[fn_LookupIdByValue]('POD'))  AS DocumentTypeId , 'POD' as  DocumentTypeText
FROM 
dbo.[Order] o LEFT JOIN OrderDocument od ON o.OrderId = od.OrderId AND od.DocumentTypeId = (SELECT [dbo].[fn_LookupIdByValue]('POD')) 

 WHERE o.CurrentState =103 ) AS [Order] WHERE ORderDocumentId is NULL AND IsActive = 1 

) AS [Order] 
FOR XML RAW('OrderList'),ELEMENTS,ROOT('Order')) AS XML)
	
END