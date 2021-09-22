-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RolePasswordPolicyMapping table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_RolePasswordPolicyMapping]

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
            DECLARE @RolePasswordPolicyMappingId bigint
            UPDATE dbo.RolePasswordPolicyMapping SET
        	[RoleMasterId]=tmp.RoleMasterId ,
        	[PasswordPolicyId]=tmp.PasswordPolicyId ,
        	[IsActive]=tmp.IsActive ,
        	[CreatedDate]=tmp.CreatedDate ,
        	[CreatedBy]=tmp.CreatedBy ,
        	[CreatedFromIPAddress]=tmp.CreatedFromIPAddress ,
        	[UpdatedDate]=tmp.UpdatedDate ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedFromIPAddress]=tmp.UpdatedFromIPAddress
            FROM OPENXML(@intpointer,'RolePasswordPolicyMapping',2)
			WITH
			(
            [RolePasswordPolicyMappingId] bigint,
           
            [RoleMasterId] bigint,
           
            [PasswordPolicyId] bigint,
           
            [IsActive] bit,
           
            [CreatedDate] datetime,
           
            [CreatedBy] bigint,
           
            [CreatedFromIPAddress] nvarchar(20),
           
            [UpdatedDate] datetime,
           
            [UpdatedBy] bigint,
           
            [UpdatedFromIPAddress] nvarchar(20)
           
            )tmp WHERE RolePasswordPolicyMapping.[RolePasswordPolicyMappingId]=tmp.[RolePasswordPolicyMappingId]
            SELECT  @RolePasswordPolicyMappingId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_RolePasswordPolicyMapping'
