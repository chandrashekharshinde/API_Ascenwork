
CREATE PROCEDURE [dbo].[USP_Activity] --'<Json><ServicesAction>InsertActivity</ServicesAction><StatusCode>909090</StatusCode><Header>Enquiry</Header><ActivityName>Enquiry_Activity</ActivityName><Sequence></Sequence><IsResponseRequired></IsResponseRequired><ResponsePropertyName></ResponsePropertyName><RejectedStatus></RejectedStatus><IsApp>true</IsApp><IconName>fa-list</IconName><ActivityPreviousStepsList><ActivityId>1</ActivityId><ActivityName>Create Enquiry</ActivityName><StatusCode>1</StatusCode><Header>Enquiry</Header><Name>Create Enquiry</Name><IsPossiblePreviousSelected>true</IsPossiblePreviousSelected></ActivityPreviousStepsList><ActivityPreviousStepsList><ActivityId>3</ActivityId><ActivityName>Enquiry Approval By Finance Controller</ActivityName><StatusCode>340</StatusCode><Header>Enquiry</Header><Name>Enquiry Approval By Finance Controller</Name><IsPossiblePreviousSelected>true</IsPossiblePreviousSelected></ActivityPreviousStepsList><ActivityPossibleStepsList><ActivityId>2</ActivityId><ActivityName>Enquiry Approval By Order Admin</ActivityName><StatusCode>320</StatusCode><Header>Enquiry </Header><Name>Enquiry Approval By Order Admin</Name><IsPossibleNextSelected>true</IsPossibleNextSelected></ActivityPossibleStepsList><ActivityPossibleStepsList><ActivityId>11</ActivityId><ActivityName>Order creation</ActivityName><StatusCode>520</StatusCode><Header>Order</Header><Name>Order creation</Name><IsPossibleNextSelected>true</IsPossibleNextSelected></ActivityPossibleStepsList><ActivityPrerequisiteStepsList><ActivityId>2</ActivityId><ActivityName>Enquiry Approval By Order Admin</ActivityName><StatusCode>320</StatusCode><Header>Enquiry </Header><Name>Enquiry Approval By Order Admin</Name><IsPossiblePrerequisiteSelected>true</IsPossiblePrerequisiteSelected></ActivityPrerequisiteStepsList><ActivityPrerequisiteStepsList><ActivityId>12</ActivityId><ActivityName>Planning</ActivityName><StatusCode>525</StatusCode><Header>Order Process</Header><Name>Planning</Name><IsPossiblePrerequisiteSelected>true</IsPossiblePrerequisiteSelected></ActivityPrerequisiteStepsList><ActivityFormMappingList><StatusCode>909090</StatusCode><FormName>Add Role Access</FormName><FormURL>AddRoleAccess</FormURL><FormType>2401</FormType></ActivityFormMappingList><ActivityFormMappingList><StatusCode>909090</StatusCode><FormName>Order List</FormName><FormURL>OrderList</FormURL><FormType>2401</FormType></ActivityFormMappingList><ActivityFormMappingList><StatusCode>909090</StatusCode><FormName>Add/Edit Event</FormName><FormURL>AddEditEvent</FormURL><FormType>2401</FormType></ActivityFormMappingList></Json>' 
(
	@xmlDoc XML 
)
AS 
BEGIN 
	
	SET ARITHABORT ON 

	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 

    SET @ErrSeverity = 15; 

    BEGIN TRY 
		
		EXEC Sp_xml_preparedocument @intpointer output, @xmlDoc 
				
		Declare @ParentActivityId bigint
		Declare @ActivityId bigint
		Declare @CurrentStatusCode nvarchar(100)
		Declare @Header nvarchar(50)
		Declare @HeaderExists bit

		
		SELECT * Into #tmpActivity
		FROM OPENXML(@intpointer, 'Json', 2) 
		WITH
		( 
			[ActivityId] bigint,
			[StatusCode] NVARCHAR(500), 
		    [Header] NVARCHAR(200), 
		    [ActivityName] NVARCHAR(50),
			[ServiceAction] nvarchar(100), 
		    [Sequence] bigint, 
			[IsResponseRequired] NVARCHAR(max), 
		    [ResponsePropertyName] NVARCHAR(max), 
			[RejectedStatus] bigint,
			[IsApp] nvarchar(50),
			[ParentId] bigint,
			[IconName] nvarchar(100)
		)tmp 

			--Set @CurrentStatusCode =(
   --       SELECT     tmpt.[StatusCode]
   --       FROM   OPENXML(@intpointer, 'Json', 2) 
   --                 WITH ( [StatusCode]         NVARCHAR(500)
   --                        )tmpt )
		Set @CurrentStatusCode =(SELECT StatusCode FROM #tmpActivity)
		Set @Header =(SELECT Header FROM #tmpActivity)
		Set @HeaderExists=(SELECT CASE WHEN EXISTS(select * from Activity where Header=@Header) THEN 1 ELSE 0 END)

		 --Update  [dbo].Activity 
		 -- SET
		 -- @ActivityId = tmp.[ActivityId],
   --            StatusCode =  tmp.[StatusCode], 
			--	Header = tmp.[Header], 
			--	ActivityName = tmp.[ActivityName], 
			--	ServiceAction = tmp.[ServiceAction],
			--	[Sequence] = tmp.[Sequence],
			--	IsResponseRequired = tmp.[IsResponseRequired], 
			--	ResponsePropertyName = tmp.[ResponsePropertyName],
			--	RejectedStatus =  tmp.[RejectedStatus], 
			--	IsApp = tmp.[IsApp],
			--	ParentId = tmp.[ParentId], 
			--	IconName = tmp.[IconName]
                  
   --       FROM   OPENXML(@intpointer, 'Json', 2) 
   --                 WITH ( 
			--		[ActivityId] bigint,
			--		[StatusCode]         NVARCHAR(500), 
   --                        [Header]     NVARCHAR(200), 
   --                        [ActivityName]      NVARCHAR(50),
			--			   [ServiceAction] nvarchar(100), 
   --                        [Sequence]			bigint, 
			--			   [IsResponseRequired]        NVARCHAR(max), 
   --                        [ResponsePropertyName]       NVARCHAR(max), 
			--			   [RejectedStatus] bigint,
			--			   [IsApp] nvarchar(50),
			--			   [ParentId] bigint,
			--			   IconName nvarchar(100)

   --                        )tmp 

		If(@HeaderExists=1)
			BEGIN
				
				Print '@HeaderExists'

				Update [dbo].Activity 
				SET
					@ActivityId = tmp.[ActivityId],
					[StatusCode] =  tmp.[StatusCode], 
					[Header] = tmp.[Header], 
					[ActivityName] = tmp.[ActivityName], 
					[ServiceAction] = tmp.[ServiceAction],
					[Sequence] = tmp.[Sequence],
					[IsResponseRequired] = tmp.[IsResponseRequired], 
					[ResponsePropertyName] = tmp.[ResponsePropertyName],
					[RejectedStatus] =  tmp.[RejectedStatus], 
					[IsApp] = tmp.[IsApp],
					[ParentId] = tmp.[ParentId], 
					[IconName] = tmp.[IconName]
				FROM #tmpActivity tmp 
				Where ActivityId=tmp.[ActivityId]

				SET @ActivityId = @@IDENTITY 

				Print '@ActivityId= ' Print @ActivityId
			END
			ELSE
			BEGIN
				
				Print '@HeaderNotExists'

				INSERT INTO [dbo].Activity 
				(
					[StatusCode],
					[Header],
					[ActivityName],
					[ServiceAction],
					[Sequence],
					[IsResponseRequired],
					[ResponsePropertyName],
					[RejectedStatus],
					[IsApp],
					[ParentId],
					[IconName]
				) 
				SELECT 
					tmp.[StatusCode], 
					tmp.[Header], 
					tmp.[ActivityName], 
					tmp.[ServiceAction],
					tmp.[Sequence],
					tmp.[IsResponseRequired], 
					tmp.[ResponsePropertyName],
					tmp.[RejectedStatus], 
					tmp.[IsApp],
					0,--tmp.[ParentId], 
					tmp.[IconName]
				FROM #tmpActivity tmp 

				SET @ParentActivityId = @@IDENTITY 
				Print '@ParentActivityId= ' Print @ParentActivityId

				
				INSERT INTO [dbo].Activity 
				(
					[StatusCode],
					[Header],
					[ActivityName],
					[ServiceAction],
					[Sequence],
					[IsResponseRequired],
					[ResponsePropertyName],
					[RejectedStatus],
					[IsApp],
					[ParentId],
					[IconName]
				) 
				SELECT 
					[StatusCode], 
					[Header], 
					[ActivityName], 
					[ServiceAction],
					[Sequence],
					[IsResponseRequired], 
					[ResponsePropertyName],
					[RejectedStatus], 
					[IsApp],
					@ParentActivityId, 
					[IconName]
				FROM Activity
				Where ActivityId=@ParentActivityId 

				SET @ActivityId = @@IDENTITY 
			END

         

----------------------------------------------------------------------------------------------------------------------------------------------------------------          


		Delete ActivityPossibleSteps where CurrentStatusCode = @CurrentStatusCode
		Delete ActivityPreviousSteps where CurrentStatusCode = @CurrentStatusCode
		Delete ActivityPrerequisiteSteps where CurrentStatusCode = @CurrentStatusCode
		Delete ActivityFormMapping where StatusCode = @CurrentStatusCode

----------------------------------------------------------------------------------------------------------------------------------------------------------------

        --INSERT INTO ActivityPossibleSteps 
        --              (CurrentStatusCode,
					   --PossibleStatusCode)
					    
        --  SELECT 
        --         @CurrentStatusCode, 
        --         tmp1.StatusCode

        --  FROM   OPENXML(@intpointer, 'Json/ActivityPossibleStepsList', 2) 
        --            WITH ( 
        --                    StatusCode  NVARCHAR(50)
						  --  )tmp1
						  
		INSERT INTO ActivityPossibleSteps 
		(
			[CurrentStatusCode],
			[PossibleStatusCode]
		)
		SELECT 
			@CurrentStatusCode, 
            tmp1.[StatusCode]
		FROM OPENXML(@intpointer, 'Json/ActivityPossibleStepsList', 2) 
		WITH 
		( 
			[StatusCode] NVARCHAR(50)
		)tmp1  


----------------------------------------------------------------------------------------------------------------------------------------------------------------

							 --INSERT INTO ActivityPreviousSteps 
        --              (CurrentStatusCode,
					   --PreviousStatusCode)
					    
        --  SELECT 
        --         @CurrentStatusCode, 
        --         tmp4.StatusCode

        --  FROM   OPENXML(@intpointer, 'Json/ActivityPreviousStepsList', 2) 
        --            WITH ( 
        --                      StatusCode  NVARCHAR(50)
						  --  )tmp4

		INSERT INTO ActivityPreviousSteps 
        (
			[CurrentStatusCode],
			[PreviousStatusCode]
		)
		SELECT 
			@CurrentStatusCode, 
            tmp4.[StatusCode]
		FROM OPENXML(@intpointer, 'Json/ActivityPreviousStepsList', 2) 
		WITH 
		( 
			[StatusCode] NVARCHAR(50)
		)tmp4



----------------------------------------------------------------------------------------------------------------------------------------------------------------


--INSERT INTO ActivityPrerequisiteSteps 
--                      (CurrentStatusCode,
--					   PrerequisiteStatusCode)
					    
--          SELECT 
--                 @CurrentStatusCode, 
--                 tmp2.StatusCode

--          FROM   OPENXML(@intpointer, 'Json/ActivityPrerequisiteStepsList', 2) 
--                    WITH (  
--                           StatusCode  NVARCHAR(50)
--						    )tmp2

		INSERT INTO ActivityPrerequisiteSteps 
		(
			[CurrentStatusCode],
			[PrerequisiteStatusCode]
		)
		SELECT 
			@CurrentStatusCode, 
            tmp2.[StatusCode]
		FROM OPENXML(@intpointer, 'Json/ActivityPrerequisiteStepsList', 2) 
		WITH 
		(  
			[StatusCode] NVARCHAR(50)
		)tmp2


----------------------------------------------------------------------------------------------------------------------------------------------------------------

--INSERT INTO ActivityFormMapping 
--                      (StatusCode,
--					   FormName,
--					   FormURL,
--					   FormType)
					    
--          SELECT 
--                 tmp3.StatusCode, 
--                 tmp3.FormName,
--				 tmp3.FormURL, 
--                 tmp3.FormType

--          FROM   OPENXML(@intpointer, 'Json/ActivityFormMappingList', 2) 
--                    WITH ( 
--                           StatusCode  NVARCHAR(50), 
--                           FormName  NVARCHAR(50),
--						   FormURL  NVARCHAR(50),
--						   FormType  NVARCHAR(50)
--						    )tmp3

		INSERT INTO ActivityFormMapping 
		(
			[StatusCode],
			[FormName],
			[FormURL],
			[FormType]
		)
		SELECT 
			tmp3.[StatusCode], 
			tmp3.[FormName],
			tmp3.[FormURL], 
			tmp3.[FormType]
		FROM OPENXML(@intpointer, 'Json/ActivityFormMappingList', 2) 
		WITH 
		( 
			[StatusCode] NVARCHAR(50), 
            [FormName] NVARCHAR(50),
			[FormURL] NVARCHAR(50),
			[FormType] NVARCHAR(50)
		)tmp3


		SELECT @ActivityId AS ActivityId 
		FOR XML RAW('Json'), ELEMENTS 

		EXEC Sp_xml_removedocument @intPointer 
	
	END TRY 
	BEGIN CATCH 
		SELECT @ErrMsg = Error_message(); 
		RAISERROR(@ErrMsg,@ErrSeverity,1); 
		RETURN; 
	END CATCH 
  END