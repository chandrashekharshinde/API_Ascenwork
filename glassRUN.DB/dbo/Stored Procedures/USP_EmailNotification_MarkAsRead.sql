Create PROCEDURE [dbo].[USP_EmailNotification_MarkAsRead] -- '<Json><ServicesAction>UpdateEmailNotification</ServicesAction><EmailNotificationId>49</EmailNotificationId><MarkAsRead>1</MarkAsRead></Json>'

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
            DECLARE @EmailNotificationId bigint
            UPDATE dbo.EmailNotification SET
        	MarkAsRead=1 ,
        	
        	[UpdatedDate]=tmp.UpdatedDate ,
        	[UpdatedBy]=tmp.UpdatedBy
            FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
		
            MarkAsRead bit,
				EmailNotificationId bigint,
            [UpdatedDate] datetime,
            [UpdatedBy] bigint
            )tmp WHERE EmailNotification.[EmailNotificationId]=tmp.[EmailNotificationId]
            SELECT  @EmailNotificationId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
