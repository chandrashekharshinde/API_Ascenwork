



CREATE PROCEDURE [dbo].[DSP_GridColumn]
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

		Declare @GridColumnId bigint

		SELECT 
			@GridColumnId = tmp.[GridColumnId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[GridColumnId] bigint
        )tmp ;

	
		Update GridColumn
		SET 
			IsActive=0 
		where [GridColumnId]=@GridColumnId

		SELECT @GridColumnId as GridColumnId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
