CREATE PROCEDURE [dbo].[SSP_LoadAllNotificationByUserId] --'<Json><OrderId>1</OrderId></Json>'
(
@xmlDoc XML
)
AS

BEGIN

DECLARE @intPointer INT;
declare @LoginId  bigint ;

declare @NotificationType  nvarchar(250);
declare @DeviceType  nvarchar(250);
declare @SearchText  nvarchar(250);

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

 select  @LoginId =tmp.LoginId ,
  @NotificationType  =tmp.NotificationType,
  @DeviceType = tmp.DeviceType,
   @SearchText = tmp.SearchText
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			LoginId bigint,
			NotificationType  nvarchar(250),
			DeviceType nvarchar(250),
			SearchText nvarchar(250)
			)tmp ;


	

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((select 'true' AS [@json:Array],NotificationRequestId ,Title ,ISNULL(IsAck,0) as IsAck   from NotificationRequest  where  
 NotifcationType=@NotificationType  and DeviceType=@DeviceType  and LoginId=@LoginId and  IsSent=1  
  and  (Title like '%'+@SearchText+'%' ) order by NotificationRequestId desc
	FOR XML path('EventNotificationList'),ELEMENTS,ROOT('Json')) AS XML)



END




