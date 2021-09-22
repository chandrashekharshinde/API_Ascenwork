create PROCEDURE [dbo].[SSP_GetAllAttachmentDocumentByEventNotificationId] -- '<Json><EventType>CNE</EventType><ObjectId>18804501</ObjectId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @EventNotificationId bigint;
Declare @NotificationType nvarchar(250);


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EventNotificationId = tmp.[EventNotificationId],
@NotificationType = tmp.[NotificationType]

	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			EventNotificationId bigint,
			NotificationType  nvarchar(250)
          
			)tmp ;



	declare @orderid bigint ;
	declare @eventmasterId bigint ;


set @orderid =(	select ObjectId  From  EventNotification en  where
			 en.EventNotificationId=14925  and en.ObjectType='Order')
set @eventmasterId =(	select EventMasterId  From  EventNotification en  where
			 en.EventNotificationId=14925  and en.ObjectType='Order')  ;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((
SELECT 'true' AS [@json:Array],
	 ed.DocumentTypeId  ,
	  ed.DocumentType ,
	   isnull(od.DocumentBlob,'')  as DocumentBlob  ,
	    isnull(od.DocumentFormat,'')  as DocumentFormat  
	    
	     From eventdocument  ed  left join OrderDocument od 
 on ed.documenttypeid  =od.DocumentTypeId   and  od.OrderId=@orderid where
eventmasterid=@eventmasterId  
  FOR XML path('EventDocumentList'),ELEMENTS,ROOT('Json')) AS XML)
	
END