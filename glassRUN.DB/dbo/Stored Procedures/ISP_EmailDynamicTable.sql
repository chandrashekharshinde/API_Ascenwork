

CREATE PROCEDURE [dbo].[ISP_EmailDynamicTable]
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

        INSERT INTO	[EmailDynamicTable]
        (
        	[TableName],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        )
        SELECT
        	tmp.[TableName],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	GETDATE()
		FROM OPENXML(@intpointer,'Json/EmailDynamicTableList',2)
        WITH
        (
            [TableName] nvarchar(100),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
        )tmp
        
        DECLARE @EmailDynamicTableId bigint
	    SET @EmailDynamicTableId = @@IDENTITY
        
        --Add child table insert procedure when required.
    
  		SELECT @EmailDynamicTableId as EmailDynamicTableId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
