
 CREATE PROCEDURE [dbo].[USP_EventRetrySettings]
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT;
	DECLARE @EventRetrySettingsId bigint;
	DECLARE @NotificationTypeMasterId INT;
	DECLARE @NotificationType NVARCHAR(2048) ;
	
	SET @NotificationType='-';
	
	SET @ErrSeverity = 15; 

	BEGIN TRY

		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
			

 SELECT @EventRetrySettingsId = tmp.[EventRetrySettingsId],
	   @NotificationTypeMasterId = tmp.[NotificationTypeMasterId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EventRetrySettingsId] bigint,
			[NotificationTypeMasterId] bigint
			
			)tmp ;

	select  top 1 @NotificationType= NotificationType  from  NotificationTypeMaster where NotificationType is not null and NotificationTypeMasterId= @NotificationTypeMasterId;

	update	dbo.[EventRetrySettings]
          set
		    @EventRetrySettingsId=tmp.[EventRetrySettingsId],
			[EventMasterId]=tmp.[EventMasterId],
			[NotificationTypeMasterId]=tmp.[NotificationTypeMasterId],
			[NotificationType]=@NotificationType,
			[RetryCount]=tmp.[RetryCount],
			[RetryInterval]=tmp.[RetryInterval],
			[IsActive]=tmp.[IsActive],
			[UpdatedBy]=tmp.[UpdatedBy],
			[UpdatedDate]=GETDATE()
        FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
		    [EventRetrySettingsId] bigint,
		    [EventMasterId] bigint,
			[NotificationTypeMasterId] bigint,
			[NotificationType] nvarchar(max),
			[RetryCount] bigint,
			[RetryInterval] bigint,
			[IsActive] bit,
			[UpdatedBy] bigint
        )tmp
        
	WHERE [EventRetrySettings].[EventRetrySettingsId]=tmp.[EventRetrySettingsId];


	SELECT @EventRetrySettingsId as EventRetrySettingsId FOR XML RAW('Json'),ELEMENTS
	exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
