CREATE PROCEDURE [dbo].[ISP_RoleWisePageMapping]
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

        INSERT INTO	[RoleWisePageMapping]
        (
        	[PageId],
        	[RoleMasterId],
        	[AccessId],
        	[CreatedBy],
        	[CreatedDate],        	
        	[IsActive]
        )

        SELECT
        	tmp.[PageId],
        	tmp.[RoleMasterId],
        	tmp.[AccessId],
        	tmp.[CreatedBy],
        	GETDATE(),
        	tmp.[IsActive]
            FROM OPENXML(@intpointer,'RoleWisePageMapping',2)
        WITH
        (
            [PageId] bigint,
            [RoleMasterId] bigint,
            [AccessId] int,
            [CreatedBy] bigint,
            [CreatedDate] datetime,          
            [IsActive] bit
        )tmp
        
        DECLARE @RoleWisePageMapping bigint
	    SET @RoleWisePageMapping = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @RoleWisePageMapping
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
