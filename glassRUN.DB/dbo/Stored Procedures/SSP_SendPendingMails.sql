CREATE PROCEDURE [dbo].[SSP_SendPendingMails] 
AS
BEGIN

SELECT CAST((
SELECT [EmailNotificationId]
      ,[SupplierId]
      ,[ObjectType]
      ,[ObjectId]
	  ,SenderEmailAddress
      ,[EventType]
	  ,[Password]
      ,[IsSent]
      ,[SenderId]
      ,[Message]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[UpdatedDate]
      ,[UpdatedBy]
  FROM [dbo].[EmailNotification]
  WHERE ISNULL(IsSent,0)=0  AND IsActive=1
  FOR XML RAW('EmailNotificationList'),ELEMENTS,ROOT('EmailNotification')) AS XML)

  END
