-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Wednesday, January 20, 2016
-- Created By:   Nimish
-- Procedure to update entries in the dbo.Resources table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_Resources]

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
            
			DECLARE @ResourceId bigint

            UPDATE dbo.Resources SET
			@ResourceId=tmp.[ResourceId],
        	[CultureId]=tmp.CultureId ,
        	[ResourceType]=tmp.ResourceType ,
        	[ResourceKey]=tmp.ResourceKey ,
        	[ResourceValue]=tmp.ResourceValue
            FROM OPENXML(@intpointer,'Resources',2)
			WITH
			(
            [ResourceId] bigint,
            [CultureId] int,
            [ResourceType] nvarchar(200),
            [ResourceKey] nvarchar(100),
            [ResourceValue] nvarchar(500)
            )tmp WHERE Resources.[ResourceId]=tmp.[ResourceId]

            SELECT  @ResourceId

            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_Resources'
