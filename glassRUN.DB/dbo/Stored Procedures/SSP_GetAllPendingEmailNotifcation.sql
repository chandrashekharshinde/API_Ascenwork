CREATE PROCEDURE [dbo].[SSP_GetAllPendingEmailNotifcation] 
AS
BEGIN
---- insert email notification for missing report notifcation

Declare  @EmailNotificationId bigint ;

select   @EmailNotificationId=EmailNotificationId  from EmailNotification where EventType='MRN' and  convert(date, CreatedDate) = convert(date, getdate())

if(@EmailNotificationId is null)
begin



INSERT INTO [dbo].[EmailNotification]
           (
           [EventType]
           ,[IsSent]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate]
           )
     VALUES
           (
           'MRN'
           ,0
           ,1
           ,1
           ,GETDATE()
          );

end ;

-------get all pending notifcation
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((
SELECT 'true' AS [@json:Array], [EmailNotificationId]
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
  FOR XML path('EmailNotificationList'),ELEMENTS,ROOT('Json')) AS XML)

  END
