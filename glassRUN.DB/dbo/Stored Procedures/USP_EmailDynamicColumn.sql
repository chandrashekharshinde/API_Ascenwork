

Create PROCEDURE [dbo].[USP_EmailDynamicColumn]
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

        DECLARE @EmailDynamicColumnId bigint

        UPDATE dbo.EmailDynamicColumn 
		SET
			@EmailDynamicColumnId=tmp.EmailDynamicColumnId,
			[EmailDynamicTableId]=tmp.EmailDynamicTableId,
        	[ColumnName]=tmp.ColumnName,
        	[IsActive]=tmp.IsActive ,
        	[UpdatedBy]=tmp.CreatedBy ,
        	[UpdatedDate]=GETDATE()
		FROM OPENXML(@intpointer,'Json/EmailDynamicColumnList',2)
		WITH
		(
			[EmailDynamicColumnId] BIGINT,
			[EmailDynamicTableId] BIGINT,
            [ColumnName] nvarchar(100),
            [IsActive] bit,           
            [CreatedBy] bigint,
            [UpdatedDate] datetime
		)tmp 
		WHERE EmailDynamicColumn.[EmailDynamicColumnId]=tmp.[EmailDynamicColumnId]
                        
		
		SELECT @EmailDynamicColumnId as EmailDynamicColumnId FOR XML RAW('Json'),ELEMENTS

		exec sp_xml_removedocument @intPointer

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
