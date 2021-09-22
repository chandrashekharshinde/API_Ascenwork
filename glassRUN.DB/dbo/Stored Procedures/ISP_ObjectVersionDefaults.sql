CREATE PROCEDURE [dbo].[ISP_ObjectVersionDefaults]
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

        INSERT INTO	[ObjectVersionDefaults]
        (
        	[ObjectId],
        	[ObjectPropertyId],
        	[DefaultValue],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        	
        )

        SELECT
        	tmp.[ObjectId],
        	tmp.[ObjectPropertyId],
        	tmp.[DefaultValue],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	tmp.[CreatedDate]
        
            FROM OPENXML(@intpointer,'ObjectVersionDefaults',2)
        WITH
        (
            [ObjectId] bigint,
            [ObjectPropertyId] bigint,
            [DefaultValue] nvarchar(500),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
           
        )tmp
        
        DECLARE @ObjectVersionDefaults bigint
	    SET @ObjectVersionDefaults = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @ObjectVersionDefaults
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
