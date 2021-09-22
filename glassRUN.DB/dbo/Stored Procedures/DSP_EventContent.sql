

CREATE PROCEDURE [dbo].[DSP_EventContent] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @EventContentId bigint;
Declare @userId bigint;
--Declare @EventMasterID12 bigint;
--Declare @NotificationTypeMasterID bigint;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @EventContentId = tmp.[EventContentId],
		@userId=tmp.[CreatedBy]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EventContentId] bigint,
			[CreatedBy] bigint
           
			)tmp ;


			
Update EventContent SET IsActive=0,UpdatedDate=GETDATE(),UpdatedBy=@userId where EventContentId=@EventContentId

--select top 1 @EventMasterID12=EventMasterId,@NotificationTypeMasterID=NotificationTypeMasterId from EventContent where EventContentId=@EventContentId 

--update EventRecipient SET IsActive=0 where EventMasterId=@EventMasterID12 and NotificationTypeMasterId=@NotificationTypeMasterID

update EventRecipient SET IsActive=0,UpdatedDate=GETDATE(),UpdatedBy=@userId where EventContentId=@EventContentId

 SELECT @EventContentId as EventContentID FOR XML RAW('Json'),ELEMENTS
END