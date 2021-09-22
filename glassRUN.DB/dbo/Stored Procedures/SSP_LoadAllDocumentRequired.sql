Create PROCEDURE [dbo].[SSP_LoadAllDocumentRequired]-- '<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><ProfileId>390</ProfileId></Json>'


AS
BEGIN







			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT    'true' AS [@json:Array]  ,
RoleId  , DocumentTypeId     From  RoleDocumentRequired  where isactive=1
	FOR XML path('DocumentRequiredList'),ELEMENTS,ROOT('Json')) AS XML)
END