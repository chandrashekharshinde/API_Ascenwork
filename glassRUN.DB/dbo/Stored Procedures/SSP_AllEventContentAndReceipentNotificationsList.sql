Create PROCEDURE [dbo].[SSP_AllEventContentAndReceipentNotificationsList] 
AS
BEGIN

SELECT CAST((select ec.EventContentId,ec.EventMasterId,ec.EventCode,er.NotificationType,er.NotificationTypeMasterId,er.RecipientType as EmailType,er.RoleMasterId,er.UserId from EventContent ec join EventRecipient er 
				on ec.EventContentId=er.EventContentId WHERE ec.IsActive = 1 
	FOR XML RAW('NotificationsList'),ELEMENTS,ROOT('Json')) AS XML)
END







