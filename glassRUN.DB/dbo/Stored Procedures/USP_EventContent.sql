
CREATE PROCEDURE [dbo].[USP_EventContent] --'<Json><ServicesAction>UpdateEventContent</ServicesAction><EventContentId>5</EventContentId><EventMasterId>6</EventMasterId><NotificationTypeMasterId>1</NotificationTypeMasterId><Title>teasubject</Title><BodyContent>Testbody</BodyContent><RecipientType>CC</RecipientType><Recipient></Recipient><RoleMasterId>2</RoleMasterId><EventRecipientList><CurrentGuid>801728d6-5cc2-4769-8971-53c1717cb8ef</CurrentGuid><EventRecipientId>12</EventRecipientId><EventMasterId>6</EventMasterId><NotificationTypeMasterId>1</NotificationTypeMasterId><Role>0</Role><RoleName>-</RoleName><UserId>0</UserId><Email>Abc@gmail.com</Email><EmailType>BCC</EmailType><EmailTypeName>BCC</EmailTypeName><IsActive>1</IsActive><CreatedBy>8</CreatedBy></EventRecipientList><EventRecipientList><CurrentGuid>21ba7696-0f67-4558-a5ff-ce679604864b</CurrentGuid><EventRecipientId>13</EventRecipientId><EventMasterId>6</EventMasterId><NotificationTypeMasterId>1</NotificationTypeMasterId><Role>0</Role><RoleName>-</RoleName><UserId>0</UserId><Email>Abc@gmail.com</Email><EmailType>BCC</EmailType><EmailTypeName>BCC</EmailTypeName><IsActive>1</IsActive><CreatedBy>8</CreatedBy></EventRecipientList><EventRecipientList><CurrentGuid>589cd3df-f094-496b-b778-4b2b88653d70</CurrentGuid><EventRecipientId>14</EventRecipientId><EventMasterId>6</EventMasterId><NotificationTypeMasterId>1</NotificationTypeMasterId><Role>0</Role><RoleName>-</RoleName><UserId>0</UserId><Email>Abc@gmail.com</Email><EmailType>BCC</EmailType><EmailTypeName>BCC</EmailTypeName><IsActive>1</IsActive><CreatedBy>8</CreatedBy></EventRecipientList><EventRecipientList><CurrentGuid>57cae87a-50c7-4d6b-b27d-762486a0227b</CurrentGuid><EventRecipientId>0</EventRecipientId><EventMasterId>6</EventMasterId><NotificationTypeMasterId>1</NotificationTypeMasterId><Role>2</Role><RoleName>TransportManager</RoleName><UserId>5</UserId><UserName>TOM</UserName><Email></Email><EmailType>CC</EmailType><EmailTypeName>CC</EmailTypeName><IsActive>1</IsActive><CreatedBy>8</CreatedBy></EventRecipientList><PriorityTypeMasterId>0</PriorityTypeMasterId><IsActive>1</IsActive><CreatedBy>8</CreatedBy></Json>'
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT;
	
	DECLARE @EventContentId bigint;
	DECLARE @EventMasterId INT;
	DECLARE @NotificationTypeMasterId INT;
	DECLARE @PriorityTypeMasterId INT;
	DECLARE @EventEode NVARCHAR(2048);
	DECLARE @NotificationType NVARCHAR(2048) ;
	DECLARE @PriorityTypeCode NVARCHAR(2048);

	SET @PriorityTypeCode='0';
	SET @NotificationType='-';
	SET @EventEode='-';
	SET @ErrSeverity = 15; 

	BEGIN TRY

		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
			

 SELECT @EventMasterId = tmp.[EventMasterId],
	   @NotificationTypeMasterId = tmp.[NotificationTypeMasterId],
	   @PriorityTypeMasterId = tmp.[PriorityTypeMasterId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EventMasterId] bigint,
			[NotificationTypeMasterId] bigint,
			[PriorityTypeMasterId] bigint
			)tmp ;

 select  top 1  @EventEode = EventCode   from   EventMaster where  EventCode is not null and EventMasterId= @EventMasterId;
select  top 1 @NotificationType= NotificationType  from   NotificationTypeMaster where NotificationType is not null and NotificationTypeMasterId= @NotificationTypeMasterId;

	update	dbo.[EventContent]
          set
		    @EventContentId=tmp.[EventContentId],
			[EventMasterId]=tmp.[EventMasterId],
			[EventCode]=@EventEode,
			[NotificationTypeMasterId]=tmp.[NotificationTypeMasterId],
			[NotificationType]=@NotificationType,
			[Title]=tmp.[Title],
			[BodyContent]=tmp.[BodyContent],
			[PriorityTypeMasterId]=tmp.[PriorityTypeMasterId],
			[PriorityTypeCode]=@PriorityTypeCode,
			[IsActive]=tmp.[IsActive],
			[UpdatedBy]=tmp.[CreatedBy],
			[UpdatedDate]=GETDATE()
        FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
		    [EventContentId] bigint,
            [EventMasterId] bigint,
			[NotificationTypeMasterId] bigint,
			[Title]nvarchar(Max),
			[BodyContent]nvarchar(Max),
			[PriorityTypeMasterId] bigint,
			[IsActive] bit,
			[CreatedBy] bigint
        )tmp
        
	WHERE [EventContent].EventContentId=tmp.[EventContentId];


	select * into #TmpEventRecipient
	FROM OPENXML(@intpointer,'Json/EventRecipientList',2)
        WITH
        (
		    [EventRecipientId] bigint,
		    [EventContentId] bigint,
            [EventMasterId] bigint,
			[NotificationTypeMasterId] bigint,
			[EmailType]nvarchar(Max),
			[Email]nvarchar(Max),
			[Role]bigint,
			[UserId]bigint,
			[IsSpecific]bit,
			[IsActive] bit,
			[CreatedBy] bigint
        )tmp


		--select * from #TmpEventRecipient

		update 	[EventRecipient] set Isactive=0 where [EventContentId]=@EventContentId

		update dbo.[EventRecipient] set dbo.[EventRecipient].[IsActive]=#TmpEventRecipient.[IsActive],
		dbo.[EventRecipient].[UpdatedBy]=#TmpEventRecipient.[CreatedBy],dbo.[EventRecipient].[UpdatedDate]=GETDATE()
		from #TmpEventRecipient where dbo.[EventRecipient].[EventRecipientId]=#TmpEventRecipient.[EventRecipientId]

    	INSERT INTO [dbo].[EventRecipient] (
			[EventContentId],
			[EventMasterId],
			[EventCode],
			[NotificationTypeMasterId],
			[NotificationType],
			[RecipientType],
			[Recipient],[RoleMasterId],
			[UserId],
			[IsSpecific],
			[IsActive],
			[CreatedBy],
			[CreatedDate])
     SELECT @EventContentId,
         	#TmpEventRecipient.[EventMasterId], 
			@EventEode,
	    	#TmpEventRecipient.[NotificationTypeMasterId],
			@NotificationType,
			#TmpEventRecipient.[EmailType],
			#TmpEventRecipient.[Email],
			#TmpEventRecipient.[Role],
			#TmpEventRecipient.[UserId],
			#TmpEventRecipient.[IsSpecific],
			#TmpEventRecipient.[IsActive],
			#TmpEventRecipient.[CreatedBy],
			GETDATE()
	 FROM #TmpEventRecipient
	 WHERE #TmpEventRecipient.[EventRecipientId]=0


	   select * into #tmpEventcontentRules
	   FROM OPENXML(@intpointer,'Json/EventContentRulesList',2)
        WITH
        (
			EventContentId bigint,
			RuleId bigint,
			IsActive bit,
			CreatedBy bigint,
			CreatedDate datetime
        )tmp
	    
		delete from EventContentRule where EventContentId = (select TOP 1 EventContentId from #tmpEventcontentRules)

        INSERT INTO	EventContentRule
        (
			[EventContentId],
			[RuleId],
			[IsActive],
			[CreatedBy],
			[CreatedDate] 
        )

        SELECT
			tmp.[EventContentId] ,
			tmp.[RuleId],
			tmp.[IsActive] ,
			tmp.[CreatedBy] ,
			GETDATE()
			FROM #tmpEventcontentRules tmp

		DROP table #tmpEventcontentRules



		-----update event document  list----

		select * into  #tmpEventDocumentList
		  FROM OPENXML(@intpointer,'Json/EventDocumentList',2)
        WITH
        (
           [EventDocumentId] bigint,
			[DocumentType]nvarchar(Max),
			[DocumentTypeId]bigint,
			[Remarks]nvarchar(Max),  
			[IsActive] bit,
			[CreatedBy] bigint
        )tmp



		delete  	Eventdocument  where [EventContentId]=@EventContentId



		---------------------  insert event document -------

			INSERT INTO	[EventDocument]
        (
		    [EventContentId],
			[EventMasterId],
			[EventCode],
			[NotificationTypeMasterId],
			[NotificationType],
			[DocumentTypeId],
			[DocumentType],
			[Remarks],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
        )
        SELECT
		    @EventContentId,
		   @EventMasterId,
			@EventEode,
			@NotificationTypeMasterId,
			@NotificationType,
			#tmpEventDocumentList.[DocumentTypeId],
			#tmpEventDocumentList.[DocumentType],
			#tmpEventDocumentList.[Remarks],
			#tmpEventDocumentList.[IsActive],
			1,
        	GETDATE()
         from   #tmpEventDocumentList











		SELECT @EventContentId as EventContentId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
