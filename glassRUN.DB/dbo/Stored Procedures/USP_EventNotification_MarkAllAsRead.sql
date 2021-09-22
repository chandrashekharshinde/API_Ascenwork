CREATE PROCEDURE [dbo].[USP_EventNotification_MarkAllAsRead] -- '<Json><ServicesAction>UpdateEmailNotification</ServicesAction><EmailNotificationId>49</EmailNotificationId><MarkAsRead>1</MarkAsRead></Json>'

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
            DECLARE @NotificationRequestId bigint
            UPDATE dbo.NotificationRequest SET
        	IsAck=1, --Changed By Chetan Tambe (17 Sept 2019)        	
        	[IsAckDatetime]=GETDATE()         	
            FROM OPENXML(@intpointer,'Json',2)
			WITH
			(		
			[LoginId] bigint         
            )tmp WHERE NotificationRequest.[LoginId]=tmp.[LoginId] and NotifcationType = 'PORTAL' and ISNULL(IsAck,0) = 0
            SELECT  @NotificationRequestId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END