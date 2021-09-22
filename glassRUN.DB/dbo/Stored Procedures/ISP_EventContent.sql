
CREATE PROCEDURE [dbo].[ISP_EventContent] --'N<Json><ServicesAction>SaveEventContent</ServicesAction><EventContentId>0</EventContentId><EventMasterId>16</EventMasterId><NotificationTypeMasterId>2</NotificationTypeMasterId><Title>Vinod Yadav</Title><BodyContent>This is&amp;nbsp; Test Foe the Email</BodyContent><RecipientType>BCC</RecipientType><Recipient/><RoleMasterId/><EventRecipientList><CurrentGuid>3717eb8c-62b6-405c-ad8a-8ce36feb2e88</CurrentGuid><EventRecipientId>0</EventRecipientId><EventMasterId>16</EventMasterId><NotificationTypeMasterId>2</NotificationTypeMasterId><Role>1</Role><RoleName>Admin</RoleName><UserId/><UserName/><Email/><EmailType>BCC</EmailType><EmailTypeName>BCC</EmailTypeName><IsActive>1</IsActive><CreatedBy>8</CreatedBy></EventRecipientList><PriorityTypeMasterId>0</PriorityTypeMasterId><IsActive>1</IsActive><CreatedBy>8</CreatedBy></Json>')
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT;
	
	DECLARE @EventMasterId INT;
	DECLARE @NotificationTypeMasterId INT;
	DECLARE @PriorityTypeMasterId INT;
	DECLARE @EventEode NVARCHAR(2048);
	DECLARE @NotificationType NVARCHAR(2048) ;
	DECLARE @PriorityTypeCode NVARCHAR(2048);
	DECLARE @EventContentId bigint

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

	--if not exists(select 1 from [EventContent] where [NotificationTypeMasterId] = @NotificationTypeMasterId and [EventMasterId]=@EventMasterId and IsActive=1)
	--begin
		select  top 1  @EventEode = EventCode   from   EventMaster where  EventCode is not null and EventMasterId= @EventMasterId;
	   select  top 1 @NotificationType= NotificationType  from   NotificationTypeMaster where NotificationType is not null and NotificationTypeMasterId= @NotificationTypeMasterId;

		INSERT INTO	[EventContent]
        (
			[EventMasterId],
			[EventCode],
			[NotificationTypeMasterId],
			[NotificationType],
			[Title],
			[BodyContent],
			[PriorityTypeMasterId],
			[PriorityTypeCode],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
        )
        SELECT
		    tmp.[EventMasterId],
			@EventEode,
			tmp.[NotificationTypeMasterId],
			@NotificationType,
			tmp.[Title],
			tmp.[BodyContent],
			tmp.[PriorityTypeMasterId],
			@PriorityTypeCode,
			tmp.[IsActive],
			tmp.[CreatedBy],
        	GETDATE()
        FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            [EventMasterId] bigint,
			[NotificationTypeMasterId] bigint,
			[Title]nvarchar(Max),
			[BodyContent]nvarchar(Max),
			[PriorityTypeMasterId] bigint,
			[IsActive] bit,
			[CreatedBy] bigint
        )tmp
        
		
	    SET @EventContentId = @@IDENTITY

		INSERT INTO	[EventRecipient]
        (
		    [EventContentId],
			[EventMasterId],
			[EventCode],
			[NotificationTypeMasterId],
			[NotificationType],
			[RecipientType],
			[Recipient],
			[RoleMasterId],
			[UserId],
			[IsSpecific],
			[IsActive],
			[CreatedBy],
			[CreatedDate]
        )
        SELECT
		    @EventContentId,
		    tmp.[EventMasterId],
			@EventEode,
			tmp.[NotificationTypeMasterId],
			@NotificationType,
			tmp.[EmailType],
			tmp.[Email],
			tmp.[Role],
			tmp.[UserId],
			tmp.[IsSpecific],
			tmp.[IsActive],
			tmp.[CreatedBy],
        	GETDATE()
        FROM OPENXML(@intpointer,'Json/EventRecipientList',2)
        WITH
        (
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
			tmp.[DocumentTypeId],
			tmp.[DocumentType],
			tmp.[Remarks],
			tmp.[IsActive],
			tmp.[CreatedBy],
        	GETDATE()
        FROM OPENXML(@intpointer,'Json/EventDocumentList',2)
        WITH
        (
           
			[DocumentType]nvarchar(Max),
			[DocumentTypeId]bigint,
			[Remarks]nvarchar(Max),  
			[IsActive] bit,
			[CreatedBy] bigint
        )tmp



       

		SELECT @EventContentId as EventContentId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 
	-- end
	--else
	--begin
	--    set @EventContentId=-1;	

	--	SELECT @EventContentId as EventContentId FOR XML RAW('Json'),ELEMENTS
	--	exec sp_xml_removedocument @intPointer
 --   end;
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END