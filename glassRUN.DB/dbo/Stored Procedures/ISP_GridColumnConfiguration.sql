-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.EmailContent table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_GridColumnConfiguration] --'<Json><ServicesAction>SaveEmailContent</ServicesAction><EmailContentList><EmailContentId>3</EmailContentId><EmailEventId>1</EmailEventId><Subject>&lt;p&gt;Test 1a&lt;/p&gt;</Subject><EmailHeader>&lt;p&gt;&lt;span style="color: rgb(91, 91, 91);text-align: left;background-color: rgb(255, 255, 255);float: none;"&gt;Test 2b&lt;/span&gt;&lt;br/&gt;&lt;br/&gt;&lt;/p&gt;</EmailHeader><EmailBody>&lt;p&gt;&lt;span style="color: rgb(91, 91, 91);text-align: left;background-color: rgb(255, 255, 255);float: none;"&gt;Test 3&lt;/span&gt;&lt;br/&gt;&lt;br/&gt;&lt;br/&gt;&lt;/p&gt;</EmailBody><EmailFooter>&lt;p&gt;&lt;span style="color: rgb(91, 91, 91);text-align: left;background-color: rgb(255, 255, 255);float: none;"&gt;Test 5&lt;/span&gt;&lt;br/&gt;&lt;br/&gt;&lt;br/&gt;&lt;/p&gt;</EmailFooter><CreatedBy>8</CreatedBy><EmailRecepientList><EmailRecepientId>1</EmailRecepientId><EmailEventId>1</EmailEventId><EmailContentId>3</EmailContentId><Email>a</Email><EmailType>TO</EmailType><IsActive>1</IsActive></EmailRecepientList><EmailRecepientList><EmailRecepientId>4</EmailRecepientId><EmailEventId>1</EmailEventId><EmailContentId>3</EmailContentId><Email>c</Email><EmailType>CC</EmailType><IsActive>false</IsActive></EmailRecepientList><EmailRecepientList><EmailRecepientIdGUID>46b97591-97df-489c-807a-3357cd56b693</EmailRecepientIdGUID><EmailRecepientId>0</EmailRecepientId><Email>t</Email><EmailType>CC</EmailType><IsActive>true</IsActive></EmailRecepientList><IsActive>true</IsActive></EmailContentList></Json>'

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(max)
	DECLARE @ErrMsg NVARCHAR(max)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
         


			SELECT * INTO #tmpGridColumnConfiguration 
			FROM OPENXML(@intpointer,'Json/GridColumnConfigurationList',2)
			 WITH
             (
				[GridColumnConfigurationId] bigint,
				[RoleId] bigint,
				[LoginId] bigint,
				[ResourceId] bigint,
				[GridColumnId] bigint,
				[ObjectId] bigint,
				[PageId] bigint,
				[IsPinned] bit,
				[IsAvailable] bit,
				[IsDefault] bit,
				[IsMandatory] bit,
				[IsSystemMandatory] bit,
				[SequenceNumber] bigint,
				[Description] nvarchar(500) ,
				[IsDetailsViewAvailable] bit,
				[IsExportAvailable] bit,
				GroupSequence bigint,
				IsGrouped bit,
				[IsActive] bit,
				[CreatedBy] bigint
			 ) tmp

			 
			 
			 UPDATE dbo.GridColumnConfiguration
			 SET dbo.GridColumnConfiguration.IsActive=0
			 FROM #tmpGridColumnConfiguration 
			 WHERE 
			 dbo.GridColumnConfiguration.[RoleId]=#tmpGridColumnConfiguration.[RoleId]
			 and dbo.GridColumnConfiguration.[LoginId]=#tmpGridColumnConfiguration.[LoginId]
			 and dbo.GridColumnConfiguration.[PageId]=#tmpGridColumnConfiguration.[PageId]
			 and dbo.GridColumnConfiguration.[ObjectId]=#tmpGridColumnConfiguration.[ObjectId]


			 UPDATE [dbo].[GridColumnConfiguration]
			 SET [RoleId] = #tmpGridColumnConfiguration.[RoleId]
			,[LoginId] = #tmpGridColumnConfiguration.[LoginId]
			,[GridColumnId] = #tmpGridColumnConfiguration.[GridColumnId]
			,[ObjectId]=#tmpGridColumnConfiguration.[ObjectId]
			,[PageId] = #tmpGridColumnConfiguration.[PageId]
			,[IsPinned] = #tmpGridColumnConfiguration.[IsPinned]
			,[IsAvailable] = #tmpGridColumnConfiguration.[IsAvailable]
			,[IsDefault] = #tmpGridColumnConfiguration.[IsDefault]
			,[IsMandatory] = #tmpGridColumnConfiguration.[IsMandatory]
			,[IsSystemMandatory] = #tmpGridColumnConfiguration.[IsSystemMandatory]
			,[SequenceNumber] = #tmpGridColumnConfiguration.[SequenceNumber]
			,[Description] = #tmpGridColumnConfiguration.[Description]
			,[IsDetailsViewAvailable] =#tmpGridColumnConfiguration.[IsDetailsViewAvailable]
			,[IsExportAvailable] = #tmpGridColumnConfiguration.[IsExportAvailable]
			,[GroupSequence] = #tmpGridColumnConfiguration.[GroupSequence]
			,[IsGrouped] = #tmpGridColumnConfiguration.[IsGrouped]
			,[IsActive] = #tmpGridColumnConfiguration.[IsActive]
			,[UpdatedBy] = #tmpGridColumnConfiguration.CreatedBy
			,[UpdatedDate] =GETDATE()
			 FROM #tmpGridColumnConfiguration 
			 WHERE 
			 dbo.GridColumnConfiguration.[RoleId]=#tmpGridColumnConfiguration.[RoleId]
			 and dbo.GridColumnConfiguration.[LoginId]=#tmpGridColumnConfiguration.[LoginId]
			 and dbo.GridColumnConfiguration.[GridColumnId]=#tmpGridColumnConfiguration.[GridColumnId]
			 and dbo.GridColumnConfiguration.[PageId]=#tmpGridColumnConfiguration.[PageId]
			 and dbo.GridColumnConfiguration.[ObjectId]=#tmpGridColumnConfiguration.[ObjectId]





		INSERT INTO [dbo].[GridColumnConfiguration]
           ([RoleId]
           ,[LoginId]
           ,[ResourceId]
           ,[GridColumnId]
		   ,[ObjectId]
           ,[PageId]
           ,[IsPinned]
           ,[IsAvailable]
           ,[IsDefault]
           ,[IsMandatory]
           ,[IsSystemMandatory]
           ,[SequenceNumber]
           ,[Description]
           ,[IsDetailsViewAvailable]
           ,[IsExportAvailable]
		   ,GroupSequence
		   ,IsGrouped
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		select tmpgc.[RoleId]
           ,tmpgc.[LoginId]
           ,tmpgc.[ResourceId]
           ,tmpgc.[GridColumnId]
		   ,tmpgc.[ObjectId]
           ,tmpgc.[PageId]
           ,tmpgc.[IsPinned]
           ,tmpgc.[IsAvailable]
           ,tmpgc.[IsDefault]
           ,tmpgc.[IsMandatory]
           ,tmpgc.[IsSystemMandatory]
           ,tmpgc.[SequenceNumber]
           ,tmpgc.[Description]
           ,tmpgc.[IsDetailsViewAvailable]
           ,tmpgc.[IsExportAvailable]
		   ,tmpgc.GroupSequence
		   ,tmpgc.IsGrouped
           ,tmpgc.[IsActive]
           ,tmpgc.[CreatedBy]
           ,GETDATE()
			FROM #tmpGridColumnConfiguration tmpgc
			WHERE 

			NOT EXISTS (SELECT GridColumnConfigurationId from dbo.GridColumnConfiguration gcc where
			 gcc.[RoleId]=tmpgc.[RoleId]
			 and gcc.[LoginId]=tmpgc.[LoginId]
			 and gcc.[GridColumnId]=tmpgc.[GridColumnId]
			 and gcc.[PageId]=tmpgc.[PageId]
			 );




           SELECT 1 as EmailContentId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_EmailContent'