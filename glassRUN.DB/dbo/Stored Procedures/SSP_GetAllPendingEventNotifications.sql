CREATE PROCEDURE [dbo].[SSP_GetAllPendingEventNotifications] 
AS
BEGIN

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((
SELECT 'true' AS [@json:Array], [EventNotificationId]
      ,[EventCode]
      ,[EventMasterId]
      ,[ObjectId]
      ,[ObjectType]
      ,[IsCreated]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedDate]
      ,[UpdatedBy]
	  ,'jhj bkk' as Message
  FROM [dbo].[EventNotification]
  WHERE ISNULL(IsCreated,0)=0  AND IsActive=1
  FOR XML path('EventNotificationList'),ELEMENTS,ROOT('Json')) AS XML)

  END