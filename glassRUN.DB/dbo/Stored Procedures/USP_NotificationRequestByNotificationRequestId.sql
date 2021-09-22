CREATE PROCEDURE [dbo].[USP_NotificationRequestByNotificationRequestId] -- '<Json><EventCode>OrderCreated</EventCode><ObjectId>18804501</ObjectId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

  select * into #tmpNotificationRequest
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			
			EventNotificationId bigint,
			NotificationType nvarchar(250),
		    Title nvarchar(250),
			BodyContent nvarchar(250),
			RecipientTo nvarchar(250),
			RecipientCC nvarchar(250),
			RecipientBCC nvarchar(250),
			LoginId bigint,
			MessageId nvarchar(250),
			DeviceToken nvarchar(250),
			DeviceType nvarchar(250),
			PushNotificationType nvarchar(250),
			Sound nvarchar(250),
			Badge nvarchar(250),
			NotificationRequestGuid nvarchar(250),
			IsSent bit,
			IsSentDatetime datetime

			)tmp ;







	drop  table #tmpNotificationRequest


END