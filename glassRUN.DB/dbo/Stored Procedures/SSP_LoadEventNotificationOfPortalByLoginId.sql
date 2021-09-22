CREATE PROCEDURE [dbo].[SSP_LoadEventNotificationOfPortalByLoginId] -- '<Json><EventCode>OrderCreated</EventCode><ObjectId>18804501</ObjectId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
declare @LoginId  bigint ;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

 select  @LoginId =tmp.LoginId
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			LoginId bigint
			)tmp ;


	

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((select top 10 'true' AS [@json:Array],*,(select count(nr1.NotificationRequestId) from NotificationRequest nr1  where  
nr1.NotifcationType='PORTAL'  and nr1.LoginId=@LoginId and (nr1.isAck=0 or nr1.IsAck is null)) As TotalCount from NotificationRequest  where  
NotifcationType='PORTAL'  and LoginId=@LoginId and (isAck=0 or IsAck is null) order by CreatedDate desc
	FOR XML path('EventNotificationList'),ELEMENTS,ROOT('Json')) AS XML)





END