CREATE PROCEDURE [dbo].[SSP_SettingMasterById] --'<Json><ServicesAction>LoadSettingMasterById</ServicesAction><SettingMasterId>46</SettingMasterId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @SettingMasterId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @SettingMasterId = tmp.[SettingMasterId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[SettingMasterId] bigint
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] 
								,SettingMasterId
								,SettingParameter
								,SettingValue
								,CompanyId
								,DeliveryType
								,ProductType
								,sm.Description
								,Version
								,p.PageName
								,p.PageId
								,sm.IsActive
								,sm.CreatedDate
								,sm.CreatedBy
								,sm.UpdatedDate
								,sm.UpdatedBy
								,p.PageId
								,p.PageName
  FROM [SettingMaster] sm left join Pages p on sm.PageName=p.PageName WHERE [SettingMasterId]=@SettingMasterId
	FOR XML path('SettingMasterList'),ELEMENTS,ROOT('SettingMaster')) AS XML)
END