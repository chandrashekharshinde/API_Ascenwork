CREATE PROCEDURE [dbo].[SSP_AllSettingMasterList] --'<Json><CompanyId>1</CompanyId></Json>'
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


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  SELECT CAST((SELECT 'true' AS [@json:Array]  ,[SettingMasterId]
      ,[SettingParameter]
      ,[SettingValue]
      ,[CompanyId]
      ,[DeliveryType]
      ,[ProductType]
      ,[Description]
      ,[Version]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[UpdatedDate]
      ,[UpdatedBy]
  FROM [dbo].[SettingMaster] where IsActive=1
	FOR XML PATH('SettingMasterList'),ELEMENTS,ROOT('SettingMaster')) AS XML)
END