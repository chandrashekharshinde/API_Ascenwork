CREATE PROCEDURE [dbo].[SSP_AllNotificationsList] 
AS
BEGIN

SELECT CAST((SELECT [NotificationsId]
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
  FROM [Notifications] WHERE IsActive = 1
	FOR XML RAW('NotificationsList'),ELEMENTS,ROOT('Notifications')) AS XML)
END
