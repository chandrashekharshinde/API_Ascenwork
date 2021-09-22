-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleMaster table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_InsertAndUpdateRoleWisePageMappingAndRoleWiseFieldAccess]

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
          


			
			SELECT * INTO #tmpRoleWisePageMapping
			FROM OPENXML(@intpointer,'Json/RoleWisePageMappingList',2)
			 WITH
             (
			 [RoleWisePageMappingId] bigint,
			 [PageId] bigint,
            [RoleMasterId] bigint,
			[LoginId] bigint,
            [AccessId] bigint,         
            [IsActive] bit,
            [CreatedBy] bigint
			
			 ) tmp



			 --select *From #tmpRoleWisePageMapping left join  [dbo].[RoleWisePageMapping] rwpm  on #tmpRoleWisePageMapping.RoleMasterId =rwpm.RoleMasterId  
			 -- and   #tmpRoleWisePageMapping.[PageId] =rwpm.PageId


			   INSERT INTO [dbo].[RoleWisePageMapping]  ([PageId],[RoleMasterId],[LoginId],[AccessId],[IsActive],[CreatedBy],[CreatedDate])
			  SELECT #tmpRoleWisePageMapping.[PageId], #tmpRoleWisePageMapping.[RoleMasterId], #tmpRoleWisePageMapping.[LoginId],#tmpRoleWisePageMapping.[AccessId],#tmpRoleWisePageMapping.[IsActive],1,getdate()
			  FROM #tmpRoleWisePageMapping  left join  [dbo].[RoleWisePageMapping] rwpm  on (#tmpRoleWisePageMapping.RoleMasterId =rwpm.RoleMasterId and  #tmpRoleWisePageMapping.LoginId =rwpm.LoginId  )
			  and   #tmpRoleWisePageMapping.[PageId] =rwpm.PageId
			  
			   WHERE rwpm.RoleWisePageMappingId is null


			  
			  UPDATE RoleWisePageMapping SET AccessId=#tmpRoleWisePageMapping.AccessId,
			  IsActive=#tmpRoleWisePageMapping.[IsActive],ModifiedDate=getdate() 
			  from #tmpRoleWisePageMapping left join  [dbo].[RoleWisePageMapping] rwpm  on (#tmpRoleWisePageMapping.RoleMasterId =rwpm.RoleMasterId and  #tmpRoleWisePageMapping.LoginId =rwpm.LoginId  )
			  and   #tmpRoleWisePageMapping.[PageId] =rwpm.PageId
			  WHERE  rwpm.RoleWisePageMappingId is not null



			

						  SELECT * INTO #tmpRoleWiseFieldMapping
						 FROM OPENXML(@intpointer,'Json/RoleWisePageMappingList/RoleWiseFieldAccessList',2)
						 WITH
					     (
						 [RoleWiseFieldAccessId] bigint,
						 [PageId] bigint,
					     [RoleId] bigint,
						 [LoginId] bigint,
						 [ObjectPropertiesId] bigint,
						 [PageControlId] bigint,
					     [AccessId] bigint,         
					     [IsActive] bit,
					     [CreatedBy] bigint
						
						 ) tmp

						  --SELECT * from #tmpRoleWiseFieldMapping


						      INSERT INTO [dbo].[RoleWiseFieldAccess]  ([PageId],[RoleId],[LoginId],[AccessId],[PageControlId],[IsActive],[CreatedBy],[CreatedDate])
							SELECT #tmpRoleWiseFieldMapping.[PageId],#tmpRoleWiseFieldMapping.[RoleId],#tmpRoleWiseFieldMapping.[LoginId],#tmpRoleWiseFieldMapping.[AccessId],#tmpRoleWiseFieldMapping.[PageControlId],#tmpRoleWiseFieldMapping.[IsActive],1,getdate()
							FROM #tmpRoleWiseFieldMapping  LEFT JOIN RoleWiseFieldAccess RWDA  on RWDA.PageId = #tmpRoleWiseFieldMapping.[PageId]
							and   (RWDA.RoleId = #tmpRoleWiseFieldMapping.[RoleId] and  RWDA.LoginId =#tmpRoleWiseFieldMapping.LoginId) and RWDA.PageControlId = #tmpRoleWiseFieldMapping.[PageControlId]
							 WHERE   RWDA.RoleWiseFieldAccessId is null

						 -- update RoleWiseFieldAccess Set IsActive=0  WHERE RoleId = @RoleMasterId

						  UPDATE RoleWiseFieldAccess SET AccessId=#tmpRoleWiseFieldMapping.AccessId,
						  IsActive=1,UpdatedDate=getdate() 
						  from #tmpRoleWiseFieldMapping LEFT JOIN RoleWiseFieldAccess RWDA  on RWDA.PageId = #tmpRoleWiseFieldMapping.[PageId]
							and  (RWDA.RoleId = #tmpRoleWiseFieldMapping.[RoleId] and  RWDA.LoginId =#tmpRoleWiseFieldMapping.LoginId) and RWDA.PageControlId = #tmpRoleWiseFieldMapping.[PageControlId]
							 WHERE   RWDA.RoleWiseFieldAccessId is not null


						


							 SELECT 'Sccesss' as OutputMessage FOR XML RAW('Json'),ELEMENTS  

            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_RoleMaster'
