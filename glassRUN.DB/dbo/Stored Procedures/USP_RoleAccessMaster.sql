-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleMaster table
-----------------------------------------------------------------
 
Create PROCEDURE [dbo].[USP_RoleAccessMaster]

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
            DECLARE @RoleMasterId bigint

            UPDATE dbo.RoleMaster SET
			@RoleMasterId=tmp.RoleMasterId,
        	[RoleName]=tmp.RoleName ,
			[PolicyName] = tmp.PolicyName,
			[RoleParentId] = tmp.RoleParentId,
        	[IsActive]=tmp.IsActive ,
        	[UpdatedDate]=tmp.UpdatedDate ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedFromIPAddress]=tmp.UpdatedFromIPAddress
            FROM OPENXML(@intpointer,'RoleMaster',2)
			WITH
			(
            [RoleMasterId] bigint,           
            [RoleName] nvarchar(50), 
			[PolicyName] nvarchar(150), 
			[RoleParentId] bigint,         
            [IsActive] bit,           
            [UpdatedDate] datetime,           
            [UpdatedBy] bigint,           
            [UpdatedFromIPAddress] nvarchar(20)           
            )tmp WHERE RoleMaster.[RoleMasterId]=tmp.[RoleMasterId]


		   SELECT  @@ROWCOUNT
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_RoleMaster'
