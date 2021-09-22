-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleMaster table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_InsertAndUpdateRoleMaster]-- '<Json><ServicesAction>InsertAndUpdateRoleMaster</ServicesAction><RoleMasterId>0</RoleMasterId><Description>ere</Description><RoleName>ererr</RoleName><PolicyName>Default Policy</PolicyName><CreatedBy>8</CreatedBy><IsActive>true</IsActive></Json>'

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
            


			select * into #tempRoleMaster
			  FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
            [RoleMasterId] bigint,           
            [RoleName] nvarchar(50), 
			[PolicyName] nvarchar(150), 
			[RoleParentId] bigint,         
            [IsActive] bit,           
              [CreatedBy] bigint,           
            [CreatedFromIPAddress] nvarchar(20)   ,
			[Description] nvarchar(250)        
            )tmp 


			 DECLARE @RoleMasterId bigint
	  

			-----insert  role master 
			INSERT INTO [RoleMaster] ( [RoleName], [Description], [PolicyName], [RoleParentId], [IsActive], [CreatedDate], [CreatedBy], [CreatedFromIPAddress] ) 
			SELECT #tempRoleMaster.[RoleName], #tempRoleMaster.[Description], #tempRoleMaster.[PolicyName], #tempRoleMaster.[RoleParentId], 1,
			 GETDATE(), #tempRoleMaster.[CreatedBy], #tempRoleMaster.[CreatedFromIPAddress] from    #tempRoleMaster  left join RoleMaster rm  on #tempRoleMaster.RoleName  = rm.RoleName
			 where rm.RoleMasterId  is null

			   SET @RoleMasterId = @@IDENTITY

			   ---update  role master---


			   update  RoleMaster   set 
			   @RoleMasterId=rm.RoleMasterId,
			   PolicyName = #tempRoleMaster.[PolicyName],
			   Description = #tempRoleMaster.[Description]

			       from    #tempRoleMaster  left join RoleMaster rm  on #tempRoleMaster.RoleName  = rm.RoleName
			 where rm.RoleMasterId  is not null



			
			--exec  USP_InsertAndUpdateRoleWisePageMappingAndRoleWiseFieldAccess @xmlDoc


			 SELECT @RoleMasterId as RoleMasterId FOR XML RAW('Json'),ELEMENTS
          
		  
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_RoleMaster'
