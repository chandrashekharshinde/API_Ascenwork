CREATE PROCEDURE [dbo].[ISP_Object]
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

        INSERT INTO	[Object]
        (
        	[ObjectName],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        	
        )

        SELECT
        	tmp.[ObjectName],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	tmp.[CreatedDate]
        	
            FROM OPENXML(@intpointer,'Object',2)
        WITH
        (
            [ObjectName] nvarchar(250),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
         
        )tmp
        
        DECLARE @Object bigint
	    SET @Object = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @Object
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
