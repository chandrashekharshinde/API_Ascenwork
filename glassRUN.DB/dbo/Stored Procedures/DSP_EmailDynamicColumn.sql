

Create PROCEDURE [dbo].[DSP_EmailDynamicColumn]
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

		Declare @EmailDynamicColumnId bigint

		SELECT 
			@EmailDynamicColumnId = tmp.[EmailDynamicColumnId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[EmailDynamicColumnId] bigint
        )tmp ;

	
		Update EmailDynamicColumn
		SET 
			IsActive=0 
		where [EmailDynamicColumnId]=@EmailDynamicColumnId

		SELECT @EmailDynamicColumnId as EmailDynamicColumnId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
