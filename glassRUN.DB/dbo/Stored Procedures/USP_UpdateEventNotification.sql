CREATE PROCEDURE [dbo].[USP_UpdateEventNotification] -- '<Json><EventType>CNE</EventType><ObjectId>18804501</ObjectId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @EventNotificationId bigint;



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EventNotificationId = tmp.[EventNotificationId]

	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			EventNotificationId bigint
          
			)tmp ;

UPDATE EventNotification  SET IsCreated=1  WHERE EventNotificationId=@EventNotificationId


 SELECT @EventNotificationId as EventNotificationId FOR XML RAW('Json'),ELEMENTS

END