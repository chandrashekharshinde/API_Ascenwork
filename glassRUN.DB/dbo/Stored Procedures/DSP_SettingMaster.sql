CREATE PROCEDURE [dbo].[DSP_SettingMaster] --'<Json><ServicesAction>SoftDeleteSettingMaster</ServicesAction><SettingMasterId>79</SettingMasterId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @SettingMaserId bigint;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @SettingMaserId = tmp.[SettingMasterId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[SettingMasterId] bigint
           
			)tmp ;


			
Update SettingMaster SET IsActive=0, UpdatedDate=GETDATE() where SettingMasterId=@SettingMaserId

 SELECT @SettingMaserId as SettingMaserId FOR XML RAW('Json'),ELEMENTS
END