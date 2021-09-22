

CREATE PROCEDURE [dbo].[SSP_AllNotificationTypeMasterDetails] (
@xmlDoc XML
)
AS	
BEGIN
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;

Declare @PageId Nvarchar(100)

SELECT  
		@PageId = tmp.[PageId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [PageId] bigint
   )tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((
SELECT 'true' AS [@json:Array], [NotificationTypeMasterId],
		[NotificationTypeMasterId] as [Id],
		[NotificationType] as [Name],
		[NotificationDescription],	
		[IsActive],
		[CreatedBy],
		[CreatedDate],
		[UpdatedBy],
		[UpdatedDate]
       FROM [NotificationTypeMaster] WHERE IsActive = 1
  FOR XML path('NotificationTypeMasterList'),ELEMENTS,ROOT('Json')) AS XML)
END