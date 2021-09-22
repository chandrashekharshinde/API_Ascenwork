-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Wednesday, January 20, 2016
-- Created By:   Nimish
-- Procedure to update entries in the dbo.Pages table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_Pages]

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

            DECLARE @PageId BIGINT
            
            UPDATE dbo.Pages SET
			@PageId=tmp.[PageId],    
        	[ModuleId]=tmp.ModuleId ,
        	[PageName]=tmp.PageName ,
        	[ParentPageId]=tmp.ParentPageId ,
        	[ControllerName]=tmp.ControllerName ,
        	[ActionName]=tmp.ActionName ,
        	[IsReport]=tmp.IsReport ,
        	[Description]=tmp.Description ,
        	[IsActive]=tmp.IsActive ,
        	--[CreatedBy]=tmp.CreatedBy ,
        	--[CreatedDate]=tmp.CreatedDate ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedDate]=GETDATE(),--tmp.UpdatedDate ,
        	[IPAddress]=tmp.IPAddress
            FROM OPENXML(@intpointer,'Pages',2)
			WITH
			(
            [PageId] bigint,
            [ModuleId] bigint,
            [PageName] nvarchar(100),
            [ParentPageId] bigint,
            [ControllerName] nvarchar(100),
            [ActionName] nvarchar(100),
            [IsReport] bit,
            [Description] nvarchar(500),
            [IsActive] bit,
            --[CreatedBy] bigint,
            --[CreatedDate] datetime,
            [UpdatedBy] bigint,
            [UpdatedDate] datetime,
            [IPAddress] nvarchar(20)
           
            )tmp WHERE Pages.[PageId]=tmp.[PageId]

            SELECT  @PageId

            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_Pages'
