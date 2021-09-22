CREATE PROCEDURE [dbo].[USP_PageWiseConfiguration]-- '<Json><ServicesAction>UpdateDimensionMapping</ServicesAction><PropertyMappingList><UserDimensionMappingId>147</UserDimensionMappingId><UserId>463</UserId><RoleId>4</RoleId><RoleName>Customer</RoleName><PropertyName>IsAvailableCredit</PropertyName><PagePropertiesId>24</PagePropertiesId><PageName>Enquiry List</PageName><PageId>9</PageId><ControllerName>SalesAdminApproval</ControllerName><ControlId>5</ControlId><ControlType>Equal</ControlType><DisplayName>RejectButton</DisplayName><ControlValue>yes</ControlValue><IsActive>1</IsActive><CreatedBy>1</CreatedBy><CreatedDate>2019-03-07T18:09:16.58</CreatedDate><UserList><Id>463</Id><Name>Distributor1</Name></UserList></PropertyMappingList><PropertyMappingList><PropertyGUID>59753a4c-aabd-4acc-8306-17e7aceaf693</PropertyGUID><UserDimensionMappingId>0</UserDimensionMappingId><RoleId>4</RoleId><PageId>9</PageId><PageName>SalesAdminApproval</PageName><ControllerName>SalesAdminApproval</ControllerName><UserId>463</UserId><ControlId>5</ControlId><PropertyName>SoldTo</PropertyName><ControlType>In</ControlType><ControlTypeId>In</ControlTypeId><ControlValue>12</ControlValue><IsActive>true</IsActive></PropertyMappingList></Json>'

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




			SELECT * INTO #tmpPageWiseConfiguration
			FROM OPENXML(@intpointer,'Json/PageWiseConfigurationList',2)
			 WITH
             (
			 [PageId]         Bigint, 
                           [RoleId]         Bigint, 
                           [UserId]         Bigint,
                           [CompanyId]	    Bigint,
						   [SettingName]    NVARCHAR(max), 
                           [SettingValue]   NVARCHAR(max), 
						   [IsActive]		bit,
						  [CreatedBy]      bigint
			 ) tmp


			

			SET  @pageName= (Select top 1 PageId from #tmpPageWiseConfiguration) 
		SET	@userId=(Select top 1  [UserId] from #tmpPageWiseConfiguration) 
		SET	@roleId=(Select top 1  [RoleId] from #tmpPageWiseConfiguration) 
		

		delete PageWiseConfiguration where PageId=@pageName and UserId=@userId and RoleId=@roleId



          INSERT INTO [dbo].[PageWiseConfiguration]
		           ([PageId]
		           ,[RoleId]
		           ,[UserId]
		         --  ,[CompanyId]
		           ,[SettingName]
		           ,[SettingValue]
		           ,[IsActive]
		           ,[CreatedBy]
		           ,[CreatedDate])
          SELECT 
				 tmp.[PageId],
				 tmp.[RoleId], 
				 tmp.[UserId], 
				-- tmp.[CompanyId], 
				 tmp.[SettingName], 
				 ISNULL(tmp.[SettingValue],0),
				 tmp.[IsActive], 
				 tmp.[CreatedBy],
				 Getdate() from #tmpPageWiseConfiguration tmp




             SELECT @UserDimensionMappingId as LocationId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END