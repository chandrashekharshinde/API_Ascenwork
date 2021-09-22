Create PROCEDURE [dbo].[SSP_GetPageRuleEventByPageRuleEventIdId] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @PageRuleEventId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @PageRuleEventId = tmp.[PageRuleEventId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[PageRuleEventId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,[PageRuleEventId]
      ,[PageId]
      ,[PageName]
      ,[PageEvent]
      ,[RuleType]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
				   FROM [PageRuleEvent]  
	  WHERE [PageRuleEventId]=@PageRuleEventId
	FOR XML path('PageRuleEventList'),ELEMENTS,ROOT('Json')) AS XML)
END
