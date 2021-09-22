-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Wednesday, January 20, 2016
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.Pages table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_Pages]
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

        INSERT INTO	[Pages]
        (
        	[ModuleId],
        	[PageName],
        	[ParentPageId],
        	[ControllerName],
        	[ActionName],
        	[IsReport],
        	[Description],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate],
        	--[UpdatedBy],
        	--[UpdatedDate],
        	[IPAddress]
        )

        SELECT
        	tmp.[ModuleId],
        	tmp.[PageName],
        	tmp.[ParentPageId],
        	tmp.[ControllerName],
        	tmp.[ActionName],
        	tmp.[IsReport],
        	tmp.[Description],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	GETDATE(),--tmp.[CreatedDate],
        	--tmp.[UpdatedBy],
        	--tmp.[UpdatedDate],
        	tmp.[IPAddress]
            FROM OPENXML(@intpointer,'Pages',2)
        WITH
        (
            [ModuleId] bigint,
            [PageName] nvarchar(100),
            [ParentPageId] bigint,
            [ControllerName] nvarchar(100),
            [ActionName] nvarchar(100),
            [IsReport] bit,
            [Description] nvarchar(500),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime,
            --[UpdatedBy] bigint,
            --[UpdatedDate] datetime,
            [IPAddress] nvarchar(20)
        )tmp
        
        DECLARE @PageId bigint
	    SET @PageId= @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @PageId

    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
