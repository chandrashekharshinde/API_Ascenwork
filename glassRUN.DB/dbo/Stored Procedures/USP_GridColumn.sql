CREATE PROCEDURE [dbo].[USP_GridColumn]

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
            DECLARE @GridColumnId bigint
            UPDATE dbo.GridColumn SET
			@GridColumnId=tmp.[GridColumnId],
			[ObjectId]=tmp.[ObjectId], 
			[PropertyName]=tmp.[PropertyName], 
			[PropertyType]=tmp.[PropertyType], 
			[IsControlField]=tmp.[IsControlField], 
			[ResourceKey]=tmp.[ResourceKey], 
			[OnScreenDisplay]=tmp.[OnScreenDisplay], 
			[IsDetailsViewAvailable]=tmp.[IsDetailsViewAvailable], 
			[IsSystemMandatory]=tmp.[IsSystemMandatory], 
			[Data1]=tmp.[Data1], 
			[Data2]=tmp.[Data2], 
			[Data3]=tmp.[Data3], 
        	[IsActive]=tmp.IsActive ,        	
        	[ModifiedBy]=tmp.ModifiedBy ,
        	[ModifiedDate]=GETDATE()
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
           
            )tmp WHERE [GridColumn].[GridColumnId]=tmp.[GridColumnId]
            SELECT @GridColumnId as GridColumnId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
