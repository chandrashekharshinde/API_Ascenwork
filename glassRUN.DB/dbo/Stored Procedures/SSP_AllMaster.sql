Create PROCEDURE [dbo].[SSP_AllMaster] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;
			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
			
SELECT CAST((SELECT  'true' AS [@json:Array],
	 [MasterId]
	,[PageId]
	,[SettingName]
	,[Description]
	,[IsActive]
	,[CreatedBy]
	,[CreatedDate]
	,[UpdatedBy]
	,[UpdatedDate]
   FROM [Master] WHERE IsActive = 1  order by SettingName Asc
	FOR XML path('MasterList'),ELEMENTS,ROOT('Json')) AS XML)
END