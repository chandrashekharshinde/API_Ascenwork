CREATE PROCEDURE [dbo].[ISP_CompanyVersionMapping]
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

        INSERT INTO	[CompanyVersionMapping]
        (
        	[CompanyId],
        	[ObjectId],
        	[ObjectName],
        	[VersionNumber],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        	
        )

        SELECT
        	tmp.[CompanyId],
        	tmp.[ObjectId],
        	tmp.[ObjectName],
        	tmp.[VersionNumber],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	tmp.[CreatedDate]
        
            FROM OPENXML(@intpointer,'CompanyVersionMapping',2)
        WITH
        (
            [CompanyId] bigint,
            [ObjectId] bigint,
            [ObjectName] nvarchar(150),
            [VersionNumber] nvarchar(50),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
            
        )tmp
        
        DECLARE @CompanyVersionMapping bigint
	    SET @CompanyVersionMapping = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @CompanyVersionMapping
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
