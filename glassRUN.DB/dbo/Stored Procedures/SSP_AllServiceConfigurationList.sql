CREATE PROCEDURE [dbo].[SSP_AllServiceConfigurationList] --'<Json><CompanyId>1</CompanyId></Json>'

AS

BEGIN




WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  SELECT CAST((SELECT 'true' AS [@json:Array]  , ServiceConfigurationId , ServicesAction , ServicesURL from ServiceConfiguration  
 where IsActive=1 
 --and ServicesAction='LoadFeedbackList_Paging'
	FOR XML PATH('ServiceConfigurationList'),ELEMENTS,ROOT('Json')) AS XML)
END
