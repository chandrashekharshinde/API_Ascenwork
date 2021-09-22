


CREATE PROCEDURE [dbo].[SSP_GetAllEmailDynamicTable]
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
			
				
		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
		SELECT CAST((
			SELECT  
				'true' AS [@json:Array],
				[EmailDynamicTableId],
				[TableName],
				[IsActive],
				[CreatedBy],
				[CreatedDate],
				[UpdatedBy],
				[UpdatedDate]
		FROM [dbo].[EmailDynamicTable]
		WHERE IsActive=1
		FOR XML path('EmailDynamicTableList'),ELEMENTS,ROOT('Json')) AS XML)

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
