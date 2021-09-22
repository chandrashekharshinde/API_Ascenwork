CREATE PROCEDURE [dbo].[SSP_GetEventContentByEventmasterId] --'<Json><OrderId>1</OrderId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @EventContentId bigint = 0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EventContentId=tmp.[EventContentId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[EventContentId] bigint
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT  ec.EventContentId,
ec.EventMasterId,
ec.EventCode,
ec.NotificationTypeMasterId,
ec.NotificationType	,
ec.Title,
ec.BodyContent,
ec.PriorityTypeMasterId,
ec.PriorityTypeCode,	
ec.CreatedBy,
ec.CreatedDate,
ec.UpdatedBy,
ec.UpdatedDate,
(select cast ((SELECT  'true' AS [@json:Array] ,
                er.[EventRecipientId],
				er.EventMasterId as EventMasterId,
				er.EventCode  ,
				er.NotificationTypeMasterId as NotificationTypeMasterId ,
				er.NotificationType,
				er.Recipient as  Email,
				er.RecipientType as EmailType,
				er.RecipientType as EmailTypeName,
				er.RoleMasterId [Role],
				er.UserId as UserId,
				er.[IsSpecific] as IsSpecific, 
				CASE WHEN (l.UserName IS null OR l.UserName ='') THEN  '-' ELSE l.UserName END as UserName,
				CASE WHEN (rol.RoleName IS NULL  OR rol.RoleName ='') THEN  '-' ELSE rol.RoleName END as RoleName
			     --l.UserName as UserName,
				-- rol.RoleName as RoleName
				from [EventRecipient] er  left join [Login] l on er.UserId=l.LoginId
				left join RoleMaster rol on rol.RoleMasterId=er.RoleMasterId
				WHERE er.IsActive = 1 AND er.EventContentId = ec.EventContentId
 FOR XML path('EventRecipientList'),ELEMENTS) AS xml)),
 (select cast ((SELECT  'true' AS [@json:Array] ,
                ed.[EventDocumentId],
				ed.EventMasterId as EventMasterId,
				ed.EventCode  ,
				ed.NotificationTypeMasterId as NotificationTypeMasterId ,
				ed.NotificationType,
				ed.DocumentTypeId ,
				ed.DocumentType ,
				ed.Remarks ,
					ed.IsActive 
				from [EventDocument] ed  
				WHERE ed.IsActive = 1 AND ed.EventContentId = ec.EventContentId
 FOR XML path('EventDocumentList'),ELEMENTS) AS xml))
FROM EventContent ec where ec.IsActive = 1 and ec.EventContentId=@EventContentId
FOR XML path('EventContentList'),ELEMENTS,ROOT('Json')) AS XML)
END
