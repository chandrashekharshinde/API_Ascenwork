create PROCEDURE [dbo].[SSP_GetAllPendingNotificationRequest] 
AS
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((
SELECT 'true' AS [@json:Array],
	 [NotificationRequestId]
      ,[EventNotificationId]
      ,[NotifcationType]  as  NotificationType
      ,[Title]
      ,[BodyContent]
      ,[RecipientTo]
      ,[RecipientCC]
      ,[RecipientBCC]
      ,[MobileNumber]
      ,[DeviceToken]
      ,[DeviceType]
      ,[PushNotificationType]
      ,[Sound]
      ,[Badge]
      ,[LoginId]
      ,[IsValid]
      ,[IsSent]
      ,[IsSentDatetime]
      ,[IsSentReason]
      ,[IsDelivered]
      ,[IsDeliveredDatetime]
      ,[IsDeliveredReason]
      ,[IsAck]
      ,[IsAckDatetime]
      ,[RetryCount]
      ,[PriorityType]
      ,[MessageId]
      ,[NotificationRequestGuid]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedDate]
      ,[UpdatedBy]
  FROM [dbo].[NotificationRequest]
  WHERE ISNULL(IsSent,0)=0  AND IsActive=1
  FOR XML path('NotificationRequestList'),ELEMENTS,ROOT('Json')) AS XML)

  END