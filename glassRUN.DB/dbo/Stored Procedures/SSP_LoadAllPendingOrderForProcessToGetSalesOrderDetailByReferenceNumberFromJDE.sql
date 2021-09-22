
CREATE PROCEDURE [dbo].[SSP_LoadAllPendingOrderForProcessToGetSalesOrderDetailByReferenceNumberFromJDE] --1

AS
BEGIN


	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
 Select Cast((
SELECT 'true' AS [@json:Array]
, e.EnquiryAutoNumber

 FROM Enquiry  e
where   CurrentState=502
FOR XML path('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
