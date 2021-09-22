CREATE PROCEDURE [dbo].[SSP_GetListCanOrderFromForCustomerApp] 
(
@xmlDoc XML
)

AS
BEGIN
Declare @CompanyId bigint;
DECLARE @intPointer INT;
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


SELECT  
		@CompanyId = tmp.[CompanyId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [CompanyId] bigint
   )tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT  'true' AS [@json:Array], c.CompanyId,c.CompanyName,c.CompanyMnemonic
,Isnull(es.RuleId,0) as RuleId from company c join EntityRelationship es on c.CompanyId=es.RelatedEntity 
where c.IsActive=1 and es.IsActive=1 and es.PrimaryEntity=@CompanyId and es.RelationshipPurpose=4201
	FOR XML path('CompanyList'),ELEMENTS,ROOT('Json')) AS XML)
END
