CREATE PROCEDURE [dbo].[ISP_RoleMaster]-- '<Json><ServicesAction>SaveRoleMaster</ServicesAction><RoleMasterId>0</RoleMasterId><Description>343434</Description><RoleName>test1</RoleName><PolicyName>Default Policy</PolicyName><CreatedBy>8</CreatedBy><IsActive>true</IsActive></Json>'
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

        INSERT INTO	[RoleMaster]
        (
        	[RoleName],
        	[Description],
			[PolicyName],
			[RoleParentId],
        	[IsActive],
        	[CreatedDate],
        	[CreatedBy],
        	[CreatedFromIPAddress]
        
        )

        SELECT
        	tmp.[RoleName],
        	tmp.[Description],
			tmp.[PolicyName],
			tmp.[RoleParentId],
        	tmp.[IsActive],
        	GETDATE(),
        	tmp.[CreatedBy],
        	tmp.[CreatedFromIPAddress]
        
            FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            [RoleName] nvarchar(50),
            [Description] nvarchar(2000),
			[PolicyName] nvarchar(150),
			[RoleParentId] bigint,
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20)
           
        )tmp
        
        DECLARE @RoleMaster bigint
	    SET @RoleMaster = @@IDENTITY

			
			exec  USP_InsertAndUpdateRoleWisePageMappingAndRoleWiseFieldAccess @xmlDoc
    
    SELECT @RoleMaster
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
