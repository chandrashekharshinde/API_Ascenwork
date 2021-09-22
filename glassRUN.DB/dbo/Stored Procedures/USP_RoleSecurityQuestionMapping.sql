-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleSecurityQuestionMapping table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_RoleSecurityQuestionMapping]

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
            DECLARE @RoleSecurityQuestionMappingId bigint
            UPDATE dbo.RoleSecurityQuestionMapping SET
        	[RoleMasterId]=tmp.RoleMasterId ,
        	[SecurityQuestionId]=tmp.SecurityQuestionId ,
        	[IsActive]=tmp.IsActive ,
        	[CreatedDate]=tmp.CreatedDate ,
        	[CreatedBy]=tmp.CreatedBy ,
        	[CreatedFromIPAddress]=tmp.CreatedFromIPAddress ,
        	[UpdatedDate]=tmp.UpdatedDate ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedFromIPAddress]=tmp.UpdatedFromIPAddress
            FROM OPENXML(@intpointer,'RoleSecurityQuestionMapping',2)
			WITH
			(
            [RoleSecurityQuestionMappingId] bigint,
           
            [RoleMasterId] bigint,
           
            [SecurityQuestionId] bigint,
           
            [IsActive] bit,
           
            [CreatedDate] datetime,
           
            [CreatedBy] bigint,
           
            [CreatedFromIPAddress] nvarchar(20),
           
            [UpdatedDate] datetime,
           
            [UpdatedBy] bigint,
           
            [UpdatedFromIPAddress] nvarchar(20)
           
            )tmp WHERE RoleSecurityQuestionMapping.[RoleSecurityQuestionMappingId]=tmp.[RoleSecurityQuestionMappingId]
            SELECT  @RoleSecurityQuestionMappingId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_RoleSecurityQuestionMapping'
