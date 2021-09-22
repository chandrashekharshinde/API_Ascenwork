
create PROCEDURE [dbo].[SSP_GetAllOrderForLorryReceiptGeneration] --1

AS
BEGIN


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((SELECT 'true' AS [@json:Array], OrderId
 FROM  [order]  where CurrentState=101    and      OrderId not in (select OrderId from OrderDocument where DocumentTypeId in (select LookUpId from LookUp where Code = 'LorryReceipt'))
FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END



