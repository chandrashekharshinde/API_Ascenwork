




CREATE PROCEDURE [dbo].[USP_SettingMaster]

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
            DECLARE @SettingMasterId bigint
            UPDATE dbo.SettingMaster SET
			@SettingMasterId=tmp.[SettingMasterId],
			[SettingParameter]=tmp.[SettingParameter], 
			[SettingValue]=tmp.[SettingValue], 
			[Description]=tmp.[Description], 
        	[IsActive]=tmp.IsActive ,        	
        	[UpdatedBy]=tmp.ModifiedBy ,
        	[UpdatedDate]=GETDATE()
            FROM OPENXML(@intpointer,'Json/SettingMasterList',2)
			WITH
			(
            [SettingMasterId] [bigint],
				[SettingParameter] [nvarchar](500),
				[SettingValue] [nvarchar](Max),
				[Description] [nvarchar](500),
				[IsActive] [bit],
				[CreatedBy] [bigint],
				[CreatedDate] [datetime],
				[ModifiedBy] [bigint],
				[UpdatedDate] [datetime]
           
            )tmp WHERE [SettingMaster].[SettingMasterId]=tmp.[SettingMasterId]
            SELECT @SettingMasterId as SettingMasterId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

