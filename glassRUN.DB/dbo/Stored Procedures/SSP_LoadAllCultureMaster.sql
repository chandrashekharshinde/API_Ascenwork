Create PROCEDURE [dbo].[SSP_LoadAllCultureMaster] --'<Json><CompanyId>1</CompanyId></Json>'
(
@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'
)
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


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  SELECT CAST((SELECT 'true' AS [@json:Array]  ,[CultureMasterId]
      ,[CultureName]
      ,[CultureCode]
      ,[Description]
      ,[Active]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
  FROM [dbo].[CultureMaster] where [Active]=1
	FOR XML PATH('CultureMasterList'),ELEMENTS,ROOT('CultureMaster')) AS XML)
END
