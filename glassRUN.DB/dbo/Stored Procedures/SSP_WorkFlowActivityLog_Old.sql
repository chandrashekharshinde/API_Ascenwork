
Create PROCEDURE [dbo].[SSP_WorkFlowActivityLog_Old] --'<Json><ServicesAction>LoadWorkFlowActivityLog</ServicesAction><OrderId>77590</OrderId><RoleId>3</RoleId><UserId>8</UserId></Json>'
@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @OrderId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @OrderId = tmp.[OrderId]

FROM OPENXML(@intpointer,'Json',2)
WITH
(
[OrderId] bigint
)tmp ;


select * into #temp from (
select WorkFlowActivityLogId
,LoginId
,RoleId
,EnquiryId
,EnquiryNumber
,OrderId
,OrderNumber
,pwfal.WorkFlowCode
,WorkFlowCurrentStatusCode
,WorkFlowCurrentActivityName
,WorkFlowPreviousStatusCode
,WorkFlowPreviousActivityName
,RawData
,CreatedBy
,CONVERT(varchar(11),CreatedDate,103) as CreatedDate
,SequenceNo
,IsAutomated
,CreatedDate as fromdate
,(select top 1 CreatedDate From WorkFlowActivityLog wfal where (wfal.OrderId =@OrderId or wfal.EnquiryId =@OrderId) and wfal.WorkFlowActivityLogId > pwfal.WorkFlowActivityLogId order by wfal.WorkFlowActivityLogId asc ) as todate
FROM WorkFlowActivityLog pwfal
left join WorkFlowStep on StatusCode = WorkFlowCurrentStatusCode and WorkFlowStep.WorkFlowCode = pwfal.WorkFlowCode
WHERE (OrderId =@OrderId or EnquiryId =@OrderId)
UNION 
select '' as WorkFlowActivityLogId
,'' as LoginId
,'' as RoleId
,'' as EnquiryId
,'' as EnquiryNumber
,@OrderId as OrderId
,(select OrderNumber from [Order] where OrderId =@OrderId ) as OrderNumber
,WorkFlowCode
,StatusCode as WorkFlowCurrentStatusCode
,ActivityName as WorkFlowCurrentActivityName
,'' as WorkFlowPreviousStatusCode
,'' as WorkFlowPreviousActivityName
,'' as RawData
,'' as CreatedBy
,'' as CreatedDate
,SequenceNo 
,IsAutomated 
,'' as fromdate
,'' as todate
from WorkFlowStep 
where WorkFlowCode = (select distinct WorkFlowCode from WorkFlowActivityLog where (OrderId =@OrderId or EnquiryId =@OrderId)) 
and StatusCode > (select top 1 WorkFlowCurrentStatusCode from WorkFlowActivityLog where (OrderId =@OrderId or EnquiryId =@OrderId) order by WorkFlowActivityLogId desc)
) a
order by SequenceNo desc;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array] , WorkFlowActivityLogId
,LoginId
,RoleId
,EnquiryId
,EnquiryNumber
,OrderId
,OrderNumber
,WorkFlowCode
,WorkFlowCurrentStatusCode
,WorkFlowCurrentActivityName
,WorkFlowPreviousStatusCode
,WorkFlowPreviousActivityName
,RawData
,CreatedBy
,CONVERT(varchar(11),CreatedDate,103) as CreatedDate
,SequenceNo 
,IsAutomated 
, (select cast ((SELECT 'true' AS [@json:Array] , a.StatusCode,a.Header,a.ActivityName ,eam.ActivityId,eam.EventMasterId
,nr.NotificationRequestId
,nr.EventNotificationId
,nr.NotifcationType
,nr.Title
,nr.BodyContent
,nr.RecipientTo
,nr.RecipientCC
,nr.RecipientBCC
,nr.MobileNumber
,nr.DeviceToken
,nr.DeviceType
,nr.PushNotificationType
,nr.Sound
,nr.Badge
,nr.LoginId
,nr.IsValid
,nr.IsSent
,nr.IsSentDatetime
,nr.IsSentReason
,nr.IsDelivered
,nr.IsDeliveredDatetime
,nr.IsDeliveredReason
,nr.IsAck
,nr.IsAckDatetime
,nr.RetryCount
,nr.PriorityType
,nr.MessageId
,nr.NotificationRequestGuid
,nr.IsActive
,nr.CreatedBy
,nr.CreatedDate
,nr.UpdatedDate
,nr.UpdatedBy
,CONVERT(varchar(11),nr.CreatedDate,103) as CreatedDate
from EventNotification en
join NotificationRequest nr on nr.EventNotificationId = en.EventNotificationId 
join EventActivityMapping eam on eam.EventMasterId = en.EventMasterId
join Activity a on a.ActivityId = eam.ActivityId WHERE ObjectId=@OrderId and a.StatusCode = WorkFlowCurrentStatusCode
FOR XML path('EmailLogList'),ELEMENTS) AS XML))
,(select cast ((SELECT 'true' AS [@json:Array]
,om.[OrderId]
,om.[DeliveryPersonnelId]
,(select top 1 p.Name from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [Name]
,(select top 1 ISNULL(p.ContactNumber,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,(select top 1 ISNULL(p.EmailId,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,om.[ExpectedTimeOfAction] as Planned
,om.[ActualTimeOfAction] as Actual
,'' as LastOnline
,om.[Latitude]
,om.[Longitude]
FROM [ORDERMOVEMENT] om where om.LocationType = 1 and om.OrderId = @OrderId
FOR XML path('CollectionInfoList'),ELEMENTS) AS XML))
,(select cast ((SELECT 'true' AS [@json:Array]
,om.[OrderId]
,om.[DeliveryPersonnelId]
,(select top 1 p.Name from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [Name]
,(select top 1 ISNULL(p.ContactNumber,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,(select top 1 ISNULL(p.EmailId,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,om.[ExpectedTimeOfAction] as Planned
,om.[ActualTimeOfAction] as Actual
,'' as LastOnline
,om.[Latitude]
,om.[Longitude]
FROM [ORDERMOVEMENT] om where om.LocationType = 2 and om.OrderId = @OrderId
FOR XML path('DeliveryInfoList'),ELEMENTS) AS XML))
,(select cast ((SELECT 'true' AS [@json:Array]
,l.LogId
,l.UserId
,l.ObjectId
,l.ObjectType
,l.LogDescription
,l.FunctionCall
,LogDate
,CONVERT(varchar(11),l.LogDate,103) as LogDate
,l.LoggingTypeId
,l.Source
,l.CreatedDate
,(select top 1 CreatedDate from WorkFlowActivityLog where (OrderId =@OrderId or EnquiryId =@OrderId)) as fromdate
,(select top 1 CreatedDate from WorkFlowActivityLog where (OrderId =@OrderId or EnquiryId =@OrderId) and WorkFlowCurrentStatusCode > (select top 1 WorkFlowCurrentStatusCode from WorkFlowActivityLog where (OrderId =@OrderId or EnquiryId =@OrderId) )) as todate
FROM Log l where ObjectId = @OrderId and LogDate between fromdate and todate
FOR XML path('LogList'),ELEMENTS) AS XML))
FROM #temp
order by SequenceNo desc
FOR XML path('WorkFlowActivityLogList'),ELEMENTS,ROOT('Json')) AS XML)	

END