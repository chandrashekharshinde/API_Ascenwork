

Create PROCEDURE [dbo].[USP_EmailDynamicTable]
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

        DECLARE @EmailDynamicTableId bigint

        UPDATE dbo.EmailDynamicTable 
		SET
			@EmailDynamicTableId=tmp.EmailDynamicTableId,
        	[TableName]=tmp.TableName,
        	[IsActive]=tmp.IsActive ,
        	[UpdatedBy]=tmp.CreatedBy ,
        	[UpdatedDate]=GETDATE()
		FROM OPENXML(@intpointer,'Json/EmailDynamicTableList',2)
		WITH
		(
			[EmailDynamicTableId] BIGINT,
            [TableName] nvarchar(100),
            [IsActive] bit,           
            [CreatedBy] bigint,
            [UpdatedDate] datetime
		)tmp 
		WHERE EmailDynamicTable.[EmailDynamicTableId]=tmp.[EmailDynamicTableId]
                        
		
		SELECT @EmailDynamicTableId as EmailDynamicTableId FOR XML RAW('Json'),ELEMENTS

		exec sp_xml_removedocument @intPointer

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
