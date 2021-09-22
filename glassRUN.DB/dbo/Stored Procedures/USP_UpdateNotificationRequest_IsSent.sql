create PROCEDURE [dbo].[USP_UpdateNotificationRequest_IsSent] -- '<Json><EventType>CNE</EventType><ObjectId>18804501</ObjectId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @NotificationRequestId bigint;



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @NotificationRequestId = tmp.[NotificationRequestId]

	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			NotificationRequestId bigint
          
			)tmp ;

UPDATE NotificationRequest  SET IsSent=1  ,IsSentDatetime=GETDATE() WHERE NotificationRequestId=@NotificationRequestId


 SELECT @NotificationRequestId as NotificationRequestId FOR XML RAW('Json'),ELEMENTS

END