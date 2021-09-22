CREATE PROCEDURE [dbo].[SSP_EmailLog] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'
@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @ObjectId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @ObjectId = tmp.[ObjectId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ObjectId] bigint
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] , en.EventCode
												,en.ObjectId
												,en.ObjectType
												,nr.NotificationRequestId
												,nr.EventNotificationId
												,nr.NotifcationType
												,nr.Title
												,nr.BodyContent
												,nr.RecipientTo
												,nr.RecipientCC
												,nr.RecipientBCC
												,nr.MobileNumber
												,nr.DeviceToken
												,nr.DeviceType
												,nr.PushNotificationType
												,nr.Sound
												,nr.Badge
												,nr.LoginId
												,nr.IsValid
												,nr.IsSent
												,nr.IsSentDatetime
												,nr.IsSentReason
												,nr.IsDelivered
												,nr.IsDeliveredDatetime
												,nr.IsDeliveredReason
												,nr.IsAck
												,nr.IsAckDatetime
												,nr.RetryCount
												,nr.PriorityType
												,nr.MessageId
												,nr.NotificationRequestGuid
												,nr.IsActive
												,nr.CreatedBy
												,nr.CreatedDate
												,nr.UpdatedDate
												,nr.UpdatedBy
												,CONVERT(varchar(11),nr.CreatedDate,103) as CreatedDate
	FROM EventNotification en
	JOIN NotificationRequest nr on nr.EventNotificationId = en.EventNotificationId WHERE ObjectId=@ObjectId
	FOR XML path('EmailLogList'),ELEMENTS,ROOT('Json')) AS XML)
END
