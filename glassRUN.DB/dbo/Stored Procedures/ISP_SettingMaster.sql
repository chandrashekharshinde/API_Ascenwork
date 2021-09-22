
CREATE PROCEDURE [dbo].[ISP_SettingMaster]
(
	@xmlDoc xml 
)
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

		select * into #tempSettingMaster
			  FROM OPENXML(@intpointer,'Json/SettingMasterList',2)
			WITH
			(
				[SettingMasterId] [bigint],
				[SettingParameter] [nvarchar](500),
				[SettingValue] [nvarchar](500),
				[Description] [nvarchar](500),
				[IsActive] [bit],
				[CreatedBy] [bigint],
				[CreatedDate] [datetime],
				[ModifiedBy] [bigint],
				[ModifiedDate] [datetime] ,
				[PageName] nvarchar(200)
            )tmp 

			INSERT INTO [SettingMaster] ( 
			[SettingParameter], 
			[SettingValue], 
			[Description], 
			[CompanyId],
			[IsActive], 
			[CreatedBy], 
			[CreatedDate],
			[PageName]
			) 
			SELECT 
			#tempSettingMaster.[SettingParameter], 
			#tempSettingMaster.[SettingValue], 
			#tempSettingMaster.[Description], 
			0,
			#tempSettingMaster.[IsActive], 
			#tempSettingMaster.[CreatedBy], 
			GETDATE(),
			#tempSettingMaster.[PageName]
			from #tempSettingMaster  

		DECLARE @SettingMasterId bigint
	    SET @SettingMasterId = @@IDENTITY

  		SELECT @SettingMasterId as SettingMasterId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END