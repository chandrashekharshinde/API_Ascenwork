CREATE PROCEDURE [dbo].[USP_DimensionMapping]-- '<Json><ServicesAction>UpdateDimensionMapping</ServicesAction><PropertyMappingList><UserDimensionMappingId>147</UserDimensionMappingId><UserId>463</UserId><RoleId>4</RoleId><RoleName>Customer</RoleName><PropertyName>IsAvailableCredit</PropertyName><PagePropertiesId>24</PagePropertiesId><PageName>Enquiry List</PageName><PageId>9</PageId><ControllerName>SalesAdminApproval</ControllerName><ControlId>5</ControlId><ControlType>Equal</ControlType><DisplayName>RejectButton</DisplayName><ControlValue>yes</ControlValue><IsActive>1</IsActive><CreatedBy>1</CreatedBy><CreatedDate>2019-03-07T18:09:16.58</CreatedDate><UserList><Id>463</Id><Name>Distributor1</Name></UserList></PropertyMappingList><PropertyMappingList><PropertyGUID>59753a4c-aabd-4acc-8306-17e7aceaf693</PropertyGUID><UserDimensionMappingId>0</UserDimensionMappingId><RoleId>4</RoleId><PageId>9</PageId><PageName>SalesAdminApproval</PageName><ControllerName>SalesAdminApproval</ControllerName><UserId>463</UserId><ControlId>5</ControlId><PropertyName>SoldTo</PropertyName><ControlType>In</ControlType><ControlTypeId>In</ControlTypeId><ControlValue>12</ControlValue><IsActive>true</IsActive></PropertyMappingList></Json>'

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
            DECLARE @UserDimensionMappingId bigint
			Declare @pageName nvarchar(200)
			DECLARE @userId bigint
			Declare @roleId bigint
			Declare @controlId bigint




			SELECT * INTO #tmpUserDimensionMapping
			FROM OPENXML(@intpointer,'Json/PropertyMappingList',2)
			 WITH
             (
			 [UserDimensionMappingId] bigint,           
            [UserId]         NVARCHAR(500), 
                [RoleId]     NVARCHAR(200), 
                [ControlId]      NVARCHAR(50), 
                [PageName]			NVARCHAR(200), 
				[ControllerName]			NVARCHAR(200),
			   [ControlType]        nvarchar(10),
                [PropertyName]       NVARCHAR(max), 
			   [ControlValue] nvarchar(max),
			   OperatorType nvarchar(10),
			   [IsActive] bit
			 ) tmp


			

			SET  @pageName= (Select top 1 [ControllerName] from #tmpUserDimensionMapping) 
		SET	@userId=(Select top 1  [UserId] from #tmpUserDimensionMapping) 
		SET	@roleId=(Select top 1  [RoleId] from #tmpUserDimensionMapping) 
		SET	@controlId=(Select top 1  [ControlId] from #tmpUserDimensionMapping) 





            UPDATE dbo.UserDimensionMapping SET
			@UserDimensionMappingId=tmp.UserDimensionMappingId,
			
			[UserId]=ISNULL(tmp.[UserId] ,0),
        	[RoleMasterId]=tmp.[RoleId] ,
			DimensionName=tmp.[PropertyName],
			PageName=tmp.[ControllerName],
			OperatorType=tmp.ControlType,
			ControlId=tmp.[ControlId],
			DimensionValue=tmp.[ControlValue],     
			[IsActive]=tmp.IsActive ,   	
			UpdatedBy=1	,
			UpdatedDate=GETDATE()
        	
            FROM OPENXML(@intpointer,'Json/PropertyMappingList',2)
			WITH
			(
            [UserDimensionMappingId] bigint,           
            [UserId]         NVARCHAR(500), 
                [RoleId]     NVARCHAR(200), 
                [ControlId]      NVARCHAR(50), 
                [PageName]			NVARCHAR(200), 
				[ControllerName]			NVARCHAR(200), 
			   [ControlType]        nvarchar(10),
                [PropertyName]       NVARCHAR(max), 
			   [ControlValue] nvarchar(max),
			   
			   [IsActive] bit
            )tmp WHERE UserDimensionMapping.[UserDimensionMappingId]=tmp.[UserDimensionMappingId]

			

		
			  

			-- select * from #tmpUserDimensionMapping
		UPDATE UserDimensionMapping SET IsActive=0 WHERE (PageName=@pageName OR @pageName = '') and (UserId = @userId)
 and (ControlId = @controlId OR @controlId = '') and (RoleMasterId = @roleId)


			 UPDATE dbo.UserDimensionMapping
			 SET dbo.UserDimensionMapping.IsActive=#tmpUserDimensionMapping.IsActive
			FROM #tmpUserDimensionMapping WHERE dbo.UserDimensionMapping.[UserDimensionMappingId]=#tmpUserDimensionMapping.[UserDimensionMappingId]





		  INSERT INTO [dbo].UserDimensionMapping (UserId, RoleMasterId, ControlId, PageName, OperatorType, DimensionName, DimensionValue,IsActive, CreatedBy,CreatedDate) 
          SELECT ISNULL(#tmpUserDimensionMapping.[UserId],0), #tmpUserDimensionMapping.[RoleId],  #tmpUserDimensionMapping.[ControlId],  #tmpUserDimensionMapping.[ControllerName], #tmpUserDimensionMapping.ControlType,
		   #tmpUserDimensionMapping.[PropertyName], #tmpUserDimensionMapping.[ControlValue],1, 1 , Getdate()
								   FROM #tmpUserDimensionMapping WHERE #tmpUserDimensionMapping.UserDimensionMappingId=0




             SELECT @UserDimensionMappingId as LocationId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END