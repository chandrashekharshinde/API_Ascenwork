
CREATE PROCEDURE [dbo].[ISP_EventRetrysettings] 
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	DECLARE @NotificationTypeMasterId int;
	DECLARE @NotificationType nvarchar(50);
	DECLARE @EventMasterId int;
	DECLARE @EventRetrySettingsId bigint
	SET @ErrSeverity = 15; 

		BEGIN TRY
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
       
	   SELECT @NotificationTypeMasterId = tmp.[NotificationTypeMasterId],@EventMasterId=tmp.[EventMasterId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[NotificationTypeMasterId] bigint,
			[EventMasterId] bigint
			
			)tmp ;
	select  top 1 @NotificationType= NotificationType  from  NotificationTypeMaster where NotificationType is not null and NotificationTypeMasterId= @NotificationTypeMasterId;
	
		 if not exists(SELECT 1 FROM [EventRetrysettings] WHERE IsActive=1 and [EventMasterId] = @EventMasterId AND NotificationTypeMasterId = @NotificationTypeMasterId) 
		  BEGIN 
		     INSERT INTO	[EventRetrysettings]
			(
				[EventMasterId],
				[NotificationTypeMasterId],
				[NotificationType],
				[RetryCount],
				[RetryInterval],
				[IsActive],
				[Createdby],
				[CreatedDate]
			
			)

			SELECT
        		tmp.[EventMasterId],
        		tmp.[NotificationTypeMasterId],
        		@NotificationType,
        		tmp.[RetryCount],
				tmp.[RetryInterval],
        		tmp.[IsActive],
        		tmp.[CreatedBy],
        		GETDATE()
        
				FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[EventMasterId] bigint,
				[NotificationTypeMasterId] bigint,
				[NotificationType] nvarchar(max),
				[RetryCount] bigint,
				[RetryInterval] bigint,
				[IsActive] bit,
				[CreatedBy] bigint
			)tmp
	    SET @EventRetrySettingsId = @@IDENTITY
		END 
		ELSE 
			BEGIN 
			SET @EventRetrySettingsId =-1;
		END 
   
        
        --Add child table insert procedure when required.
    
  	SELECT @EventRetrySettingsId as EventRetrySettingsId FOR XML RAW('Json'),ELEMENTS
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
