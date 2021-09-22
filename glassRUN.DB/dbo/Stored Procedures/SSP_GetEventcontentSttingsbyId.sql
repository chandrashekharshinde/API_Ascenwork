
CREATE PROCEDURE [dbo].[SSP_GetEventcontentSttingsbyId] --'<Json><OrderId>1</OrderId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @EventRetrySettingsId bigint = 0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EventRetrySettingsId=tmp.[EventRetrySettingsId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[EventRetrySettingsId] bigint
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array], EventRetrySettingsId,
EventMasterId,
NotificationTypeMasterId,
NotificationType,
RetryCount,
RetryInterval,
IsActive,
Createdby,
CreatedDate,
UpdatedBy,
UpdatedDate
FROM EventretrySettings  where IsActive = 1 and EventRetrySettingsId=@EventRetrySettingsId
FOR XML path('EventRetrySettingsList'),ELEMENTS,ROOT('Json')) AS XML)
END

