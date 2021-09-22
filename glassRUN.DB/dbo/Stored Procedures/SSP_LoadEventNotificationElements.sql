CREATE PROCEDURE [dbo].[SSP_LoadEventNotificationElements] 
as
begin

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((
SELECT 'true' AS [@json:Array], 
[EventContentId],
      [EventCode]
      ,[EventMasterId]
      ,[NotificationTypeMasterId]
      ,[NotificationType]
      ,[Title]
      ,[BodyContent]
      ,[PriorityTypeMasterId]
	  ,[PriorityTypeCode]
      ,[CreatedDate]
      ,[UpdatedDate]
      ,[UpdatedBy]
  FROM [dbo].EventContent
  WHERE IsActive=1
  FOR XML path('EventContenList'),ELEMENTS,ROOT('Json')) AS XML)


end