CREATE PROCEDURE [dbo].[SSP_SettingMasterBySettingParameter]-- 'TruckBufferWeight'
(
@SettingParameter nvarchar(250)
)
AS

BEGIN



SELECT SettingMasterId ,SettingValue from SettingMaster where SettingMaster.IsActive=1 and SettingMaster.SettingParameter=@SettingParameter FOR XML RAW('Json'),ELEMENTS

END
