
CREATE PROCEDURE [dbo].[ISP_GridColumn]
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

		select * into #tempGridColumn
			  FROM OPENXML(@intpointer,'Json/GridColumnList',2)
			WITH
			(
				[GridColumnId] [bigint],
				[ObjectId] [bigint],
				[PropertyName] [nvarchar](500),
				[PropertyType] [nvarchar](500),
				[IsControlField] [bit],
				[ResourceKey] [nvarchar](500),
				[OnScreenDisplay] [bit],
				[IsDetailsViewAvailable] [bit],
				[IsSystemMandatory] [bit],
				[Data1] [nvarchar](max),
				[Data2] [nvarchar](max),
				[Data3] [nvarchar](max),
				[IsActive] [bit],
				[CreatedBy] [bigint],
				[CreatedDate] [datetime],
				[ModifiedBy] [bigint],
				[ModifiedDate] [datetime] 
            )tmp 

			--select * into #tempResource
			--  FROM OPENXML(@intpointer,'Json/ResourceList',2)
			--WITH
			--([dbo].[GridColumn]
   --         [LoginId] bigint ,
			-- [ActivationCode] nvarchar(max)
   --         )tmp 

			INSERT INTO [GridColumn] ( 
			[ObjectId], 
			[PropertyName], 
			[PropertyType], 
			[IsControlField], 
			[ResourceKey], 
			[OnScreenDisplay], 
			[IsDetailsViewAvailable], 
			[IsSystemMandatory], 
			[Data1], 
			[Data2], 
			[Data3], 
			[IsActive], 
			[CreatedBy], 
			[CreatedDate]
			--[ModifiedBy], 
			--[ModifiedDate] 
			) 
			SELECT 
			#tempGridColumn.[ObjectId], 
			#tempGridColumn.[PropertyName], 
			#tempGridColumn.[PropertyType], 
			#tempGridColumn.[IsControlField], 
			#tempGridColumn.[ResourceKey], 
			#tempGridColumn.[OnScreenDisplay], 
			#tempGridColumn.[IsDetailsViewAvailable], 
			#tempGridColumn.[IsSystemMandatory], 
			#tempGridColumn.[Data1], 
			#tempGridColumn.[Data2], 
			#tempGridColumn.[Data3], 
			#tempGridColumn.[IsActive], 
			#tempGridColumn.[CreatedBy], 
			GETDATE()
			--#tempGridColumn.[ModifiedBy], 
			--#tempGridColumn.[ModifiedDate]
			from #tempGridColumn  

		DECLARE @GridColumnId bigint
	    SET @GridColumnId = @@IDENTITY

  		SELECT @GridColumnId as GridColumnId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
