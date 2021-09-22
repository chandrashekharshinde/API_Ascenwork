

Create PROCEDURE [dbo].[DSP_EmailDynamicTable]
(
	@xmlDoc XML
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

		Declare @EmailDynamicTableId bigint

		SELECT 
			@EmailDynamicTableId = tmp.[EmailDynamicTableId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[EmailDynamicTableId] bigint
        )tmp ;

	
		Update EmailDynamicTable
		SET 
			IsActive=0 
		where [EmailDynamicTableId]=@EmailDynamicTableId

		SELECT @EmailDynamicTableId as EmailDynamicTableId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
