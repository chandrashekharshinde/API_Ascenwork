CREATE PROCEDURE [dbo].[SSP_Notifications_ByNotificationId] --1
@NotificationId BIGINT
AS
BEGIN

	SELECT [NotificationsId]
      ,[NotificationType]
      ,[Remarks]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[IsActive]
      ,[SequenceNo]
      ,[Field1]
      ,[Field2]
      ,[Field3]
      ,[Field4]
      ,[Field5]
      ,[Field6]
      ,[Field7]
      ,[Field8]
      ,[Field9]
      ,[Field10]
	FROM [dbo].[Notifications]
	 WHERE (NotificationsId=@NotificationId OR @NotificationId=0) AND IsActive=1
	FOR XML RAW('Notifications'),ELEMENTS
	
	
	
END
