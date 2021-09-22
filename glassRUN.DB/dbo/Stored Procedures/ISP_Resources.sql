CREATE PROCEDURE [dbo].[ISP_Resources]
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

        INSERT INTO	[Resources]
        (
        	[CultureId],
        	[ResourceType],
        	[ResourceKey],
        	[ResourceValue]
        )

        SELECT
        	tmp.[CultureId],
        	tmp.[ResourceType],
        	tmp.[ResourceKey],
        	tmp.[ResourceValue]
            FROM OPENXML(@intpointer,'Resources',2)
        WITH
        (
            [CultureId] int,
            [ResourceType] nvarchar(200),
            [ResourceKey] nvarchar(100),
            [ResourceValue] nvarchar(500)
        )tmp
        
        DECLARE @ResourceId bigint
	    SET @ResourceId= @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @ResourceId

    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
