﻿

Create PROCEDURE [dbo].[SSP_GetAllEmailDynamicColumnByEmailDynamicTableId]
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
				[EmailDynamicColumnId],
				[EmailDynamicTableId],
				[ColumnName],
				[IsActive],
				[CreatedBy],
				[CreatedDate],
				[UpdatedBy],
				[UpdatedDate]
		FROM [dbo].[EmailDynamicColumn]
		WHERE (EmailDynamicTableId=@EmailDynamicTableId OR @EmailDynamicTableId=0) 
		AND IsActive=1
		FOR XML path('EmailDynamicColumnList'),ELEMENTS,ROOT('Json')) AS XML)

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
