
create PROCEDURE [dbo].[SSP_AllSettings] ----56

AS
BEGIN
	SELECT CAST((
	SELECT  [SettingMasterId]
      ,[SettingParameter]
      ,[SettingValue]
      ,0 as [SupplierId]
	  ,ProductType
	  ,DeliveryType
	  ,0  AS SupplierLobId
	  ,[Description]
      , 4 as [LobId]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[UpdatedDate]
      ,[UpdatedBy]
  FROM [dbo].[SettingMaster] WHERE IsActive=1
		FOR XML RAW('SettingMasterList'),ELEMENTS,ROOT('SettingMaster')) AS XML)
	
END