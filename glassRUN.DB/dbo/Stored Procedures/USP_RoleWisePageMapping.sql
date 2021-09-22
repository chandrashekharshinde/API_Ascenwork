CREATE PROCEDURE [dbo].[USP_RoleWisePageMapping]

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
            DECLARE @RoleWisePageMappingId bigint
            UPDATE dbo.RoleWisePageMapping SET
        	[PageId]=tmp.PageId ,
        	[RoleMasterId]=tmp.RoleMasterId ,
        	[AccessId]=tmp.AccessId ,        	
        	[ModifiedBy]=tmp.ModifiedBy ,
        	[ModifiedDate]=GETDATE() ,
        	[IsActive]=tmp.IsActive
            FROM OPENXML(@intpointer,'RoleWisePageMapping',2)
			WITH
			(
            [RoleWisePageMappingId] bigint,
           
            [PageId] bigint,
           
            [RoleMasterId] bigint,
           
            [AccessId] int,           
          
           
            [ModifiedBy] bigint,
           
            [ModifiedDate] datetime,
           
            [IsActive] bit
           
            )tmp WHERE RoleWisePageMapping.[RoleWisePageMappingId]=tmp.[RoleWisePageMappingId]
            SELECT  @RoleWisePageMappingId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_RoleWisePageMapping'
