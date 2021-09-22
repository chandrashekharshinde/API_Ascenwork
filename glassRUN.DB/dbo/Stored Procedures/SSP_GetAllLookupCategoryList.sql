Create PROCEDURE [dbo].[SSP_GetAllLookupCategoryList] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'

AS
BEGIN


DECLARE @intPointer INT;
declare @companyId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint
			)tmp;







			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,
[LookUpCategoryId]
      ,[Name]
      ,[Remarks]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
      ,[SequenceNo]
 
from  LookUpCategory 
where isactive = 1 and EndUserUpdate=1
	FOR XML path('LookUpCategoryList'),ELEMENTS,ROOT('Json')) AS XML)
END