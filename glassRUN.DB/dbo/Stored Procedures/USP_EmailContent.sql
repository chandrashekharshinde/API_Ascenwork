-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.EmailContent table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_EmailContent] --'<Json><ServicesAction>SaveEmailContent</ServicesAction><EmailContentList><EmailContentId>3</EmailContentId><EmailEventId>1</EmailEventId><Subject>&lt;p&gt;Test 1a&lt;/p&gt;</Subject><EmailHeader>&lt;p&gt;&lt;span style="color: rgb(91, 91, 91);text-align: left;background-color: rgb(255, 255, 255);float: none;"&gt;Test 2b&lt;/span&gt;&lt;br/&gt;&lt;br/&gt;&lt;/p&gt;</EmailHeader><EmailBody>&lt;p&gt;&lt;span style="color: rgb(91, 91, 91);text-align: left;background-color: rgb(255, 255, 255);float: none;"&gt;Test 3&lt;/span&gt;&lt;br/&gt;&lt;br/&gt;&lt;br/&gt;&lt;/p&gt;</EmailBody><EmailFooter>&lt;p&gt;&lt;span style="color: rgb(91, 91, 91);text-align: left;background-color: rgb(255, 255, 255);float: none;"&gt;Test 5&lt;/span&gt;&lt;br/&gt;&lt;br/&gt;&lt;br/&gt;&lt;/p&gt;</EmailFooter><CreatedBy>8</CreatedBy><EmailRecepientList><EmailRecepientId>1</EmailRecepientId><EmailEventId>1</EmailEventId><EmailContentId>3</EmailContentId><Email>a</Email><EmailType>TO</EmailType><IsActive>1</IsActive></EmailRecepientList><EmailRecepientList><EmailRecepientId>4</EmailRecepientId><EmailEventId>1</EmailEventId><EmailContentId>3</EmailContentId><Email>c</Email><EmailType>CC</EmailType><IsActive>false</IsActive></EmailRecepientList><EmailRecepientList><EmailRecepientIdGUID>46b97591-97df-489c-807a-3357cd56b693</EmailRecepientIdGUID><EmailRecepientId>0</EmailRecepientId><Email>t</Email><EmailType>CC</EmailType><IsActive>true</IsActive></EmailRecepientList><IsActive>true</IsActive></EmailContentList></Json>'

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
            DECLARE @EmailContentId bigint
		
            UPDATE dbo.EmailContent SET
			@EmailContentId=tmp.EmailContentId,
        	[SupplierId]=tmp.SupplierId ,        	
        	[EmailEventId]=tmp.EmailEventId ,
        	[Subject]=tmp.[Subject] ,
        	[EmailHeader]=tmp.EmailHeader ,
        	[EmailBody]=tmp.EmailBody ,
        	[EmailFooter]=tmp.EmailFooter ,
        	[IsActive]=tmp.IsActive ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedDate]=tmp.UpdatedDate
            FROM OPENXML(@intpointer,'Json/EmailContentList',2)
			WITH
			(
			[EmailContentId] bigint,
            [SupplierId] bigint,            
            [EmailEventId] bigint,
            [Subject] nvarchar(max),
            [EmailHeader] nvarchar(max),
            [EmailBody] nvarchar(max),
            [EmailFooter] nvarchar(max),
            [IsActive] bit,           
            [UpdatedBy] bigint,
            [UpdatedDate] datetime
            )tmp WHERE EmailContent.[EmailContentId]=tmp.[EmailContentId]


			SELECT * INTO #tmpEmailRecepient 
			FROM OPENXML(@intpointer,'Json/EmailContentList/EmailRecepientList',2)
			 WITH
             (
			 [EmailRecepientId] bigint,
				[EmailEventId] bigint,
            [EmailContentId] bigint,            
            [Email] NVARCHAR(500),
            [EmailType] nvarchar(10),
            [RoleId] BIGINT,
            [UserName] nvarchar(250),
			[IsActive] bit
			 ) tmp

			-- SELECT * FROM #tmpEmailRecepient

			 UPDATE EmailRecepient SET IsActive=0 WHERE EmailContentId=@EmailContentId


			 UPDATE dbo.EmailRecepient
			 SET dbo.EmailRecepient.IsActive=#tmpEmailRecepient.IsActive
			FROM #tmpEmailRecepient WHERE dbo.EmailRecepient.EmailRecepientId=#tmpEmailRecepient.EmailRecepientId


			INSERT INTO [dbo].[EmailRecepient]  ([EmailEventId],[EmailContentId],[EmailAddress],[ToCC],[RoleId],[UserName],[IsActive])
     SELECT  	#tmpEmailRecepient.[EmailEventId], 	@EmailContentId, 	#tmpEmailRecepient.[Email],
        	#tmpEmailRecepient.[EmailType],
			#tmpEmailRecepient.[RoleId],
			#tmpEmailRecepient.[UserName],
			#tmpEmailRecepient.[IsActive]
            FROM #tmpEmailRecepient
         WHERE #tmpEmailRecepient.EmailRecepientId=0

			 
			--DELETE dbo.EmailRecepient WHERE IsActive=0


           SELECT @EmailContentId as EmailContentId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_EmailContent'
