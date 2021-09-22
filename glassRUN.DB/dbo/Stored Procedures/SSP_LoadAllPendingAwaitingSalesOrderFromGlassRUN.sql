
CREATE PROCEDURE [dbo].[SSP_LoadAllPendingAwaitingSalesOrderFromGlassRUN] --1

AS
BEGIN


	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((
SELECT 'true' AS [@json:Array]
, e.EnquiryAutoNumber

 FROM Enquiry  e
where   CurrentState=370
FOR XML path('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
