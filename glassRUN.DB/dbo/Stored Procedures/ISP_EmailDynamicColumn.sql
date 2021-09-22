

CREATE PROCEDURE [dbo].[ISP_EmailDynamicColumn]
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

        INSERT INTO	[EmailDynamicColumn]
        (
        	[EmailDynamicTableId],
        	[ColumnName],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        )
        SELECT
        	tmp.[EmailDynamicTableId],
        	tmp.[ColumnName],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	GETDATE()
		FROM OPENXML(@intpointer,'Json/EmailDynamicColumnList',2)
        WITH
        (
            [EmailDynamicTableId] bigint,
            [ColumnName] nvarchar(100),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
        )tmp
        
        DECLARE @EmailDynamicColumnId bigint
	    SET @EmailDynamicColumnId = @@IDENTITY
        
        --Add child table insert procedure when required.
    
  		SELECT @EmailDynamicColumnId as EmailDynamicColumnId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
