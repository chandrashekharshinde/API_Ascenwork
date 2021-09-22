
CREATE PROCEDURE [dbo].[SSP_WorkFlowActivityLog]-- '<Json><ServicesAction>LoadWorkFlowActivityLog</ServicesAction><OrderId>13265</OrderId><RoleId>7</RoleId><UserId>10508</UserId></Json>'
@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;

Declare @OrderId bigint
Declare @RoleId bigint
Declare @UserId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @OrderId = tmp.[OrderId],
@RoleId = tmp.[RoleId],
@UserId = tmp.[UserId]
FROM OPENXML(@intpointer,'Json',2)
WITH
(
[OrderId] bigint,
[RoleId] bigint,
[UserId] bigint
)tmp ;


   if exists (select wac.WorkflowActivityConfigurationid from [dbo].[WorkflowActivityConfiguration] wac where wac.LoginId = @UserId and wac.IsActive = 1 and wac.WorkFlowCode = (select distinct WorkFlowCode from WorkFlowActivityLog (NOLOCK) where (OrderId =@OrderId or EnquiryId =@OrderId)))
    BEGIN
     set @UserId=@UserId
    end
     else
     BEGIN
      set @UserId=0
     end;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array] , ISNULL(IsAvailable,0) as IsAvailable,ISNULL(IsNotificationLogAvailable,0) as IsNotificationLogAvailable,ISNULL(IsActivityLogAvailable,0) as IsActivityLogAvailable,ISNULL(IsStartDateAvailable,0) as IsStartDateAvailable
,ISNULL(IsEndDateAvailable,0) as IsEndDateAvailable,
ISNULL(IsUserNameAvailable,0) as IsUserNameAvailable,ParentId,IconName,IsParent,WorkFlowActivityLogId,LoginId,RoleId,EnquiryId,EnquiryNumber
,isnull(ActivityStartTime,'') as ActivityStartTime,isnull(ActivityEndTime,'') as ActivityEndTime,
ISNULL(Username, '') as Username,
OrderId,OrderNumber,WorkFlowCode,WorkFlowCurrentStatusCode,WorkFlowCurrentActivityName,WorkFlowPreviousStatusCode,WorkFlowPreviousActivityName,RawData,
CreatedBy,CreatedDate,SequenceNo,IsAutomated,fromdate,todate,
convert(xml,EmailLogList),convert(xml,CollectionInfoList),convert(xml,DeliveryInfoList),convert(xml,LogList)
 from (
SELECT wac.IsAvailable
,wac.IsNotificationLogAvailable
,wac.IsActivityLogAvailable
,wac.IsStartDateAvailable
,wac.IsEndDateAvailable
,wac.IsUserNameAvailable
,a.ParentId
, a.IconName
,0 as IsParent
,isnull(WorkFlowActivityLogId,'') as WorkFlowActivityLogId
,isnull(pwfal.LoginId,'') as LoginId
,isnull(pwfal.RoleId,'') as RoleId
,isnull(EnquiryId,'') as EnquiryId
,isnull(EnquiryNumber,'') as EnquiryNumber
,isnull(@OrderId,'') as OrderId
,isnull((Select OrderNumber from [Order] where OrderId=@OrderId),'') as OrderNumber
,isnull(ws.WorkFlowCode,'') as WorkFlowCode
,isnull(ws.StatusCode,'')  as WorkFlowCurrentStatusCode
,isnull(a.DashboardDisplayName,'') as WorkFlowCurrentActivityName
,isnull(WorkFlowPreviousStatusCode,'') as WorkFlowPreviousStatusCode
,isnull(WorkFlowPreviousActivityName,'') as WorkFlowPreviousActivityName
,isnull(RawData,'') as RawData
,isnull(pwfal.CreatedBy,'') as CreatedBy
,isnull(CONVERT(varchar(11),pwfal.CreatedDate,103),'') as CreatedDate
,isnull(SequenceNo,'') as SequenceNo
,isnull(IsAutomated,'') as IsAutomated
,pwfal.ActivityStartTime,pwfal.ActivityEndTime

,isnull((Select top 1 lin.[NAME] from [login] lin where lin.UserName=pwfal.Username),pwfal.Username) as Username
,pwfal.CreatedDate as fromdate
,(select top 1 CreatedDate From WorkFlowActivityLog wfal (NOLOCK) where (wfal.OrderId =@OrderId or wfal.EnquiryId =@OrderId) and wfal.WorkFlowActivityLogId > pwfal.WorkFlowActivityLogId order by wfal.WorkFlowActivityLogId asc ) as todate
, (select cast ((SELECT 'true' AS [@json:Array] , a.StatusCode,a.Header,a.ActivityName ,eam.ActivityId,eam.EventMasterId
,nr.NotificationRequestId
,nr.EventNotificationId
,ISNULL(nr.NotifcationType,'') as 'Source'
,ISNULL(nr.Title,'') as LogDescription
,nr.BodyContent
,isnull(case when nr.NotifcationType='DEVICE' then (Select top 1 lin.[NAME] from [login] lin where lin.loginid=isnull(nr.loginid,0)) else case when nr.RecipientTo ='' then '-' else nr.RecipientTo end end,'-') as RecipientTo
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
,ISNULL(nr.IsSentDatetime,'') as LogDate
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
from EventNotification en (NOLOCK)
join NotificationRequest nr on nr.EventNotificationId = en.EventNotificationId 
join EventActivityMapping eam on eam.EventMasterId = en.EventMasterId
join Activity a on a.ActivityId = eam.ActivityId WHERE en.ObjectId=@OrderId and a.StatusCode = ws.StatusCode and  wac.IsNotificationLogAvailable=1
FOR XML path('EmailLogList'),ELEMENTS) AS XML)) as EmailLogList
,(select cast ((SELECT 'true' AS [@json:Array] ,
om.[OrderId]
,om.[DeliveryPersonnelId]
,(select top 1 l.Name from [Login] l  where l.LoginId=om.[DeliveryPersonnelId]) as [Name]
,(select top 1 ISNULL(p.ContactNumber,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,(select top 1 ISNULL(p.EmailId,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,om.[ExpectedTimeOfAction] as Planned
,om.[ActualTimeOfAction] as Actual
,(select loc.[LocationName] from Location loc where LocationId = om.Location) as CollectionLocationName
,'' as LastOnline
,om.[Latitude]
,om.[Longitude]
FROM [ORDERMOVEMENT] om (NOLOCK) where om.LocationType = 1 and om.OrderId = @OrderId
FOR XML path('CollectionInfoList'),ELEMENTS) AS XML)) as CollectionInfoList
,(select cast ((SELECT 'true' AS [@json:Array] ,om.[OrderId]
,om.[DeliveryPersonnelId]
,(select top 1 l.Name from [Login] l where l.LoginId=om.[DeliveryPersonnelId]) as [Name]
,(select top 1 ISNULL(p.ContactNumber,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,(select top 1 ISNULL(p.EmailId,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,om.[ExpectedTimeOfAction] as Planned
,om.[ActualTimeOfAction] as Actual
,(select loc.[LocationName] from Location loc where LocationId = om.Location) as DeliveryLocationName
,'' as LastOnline
,om.[Latitude]
,om.[Longitude]
FROM [ORDERMOVEMENT] om (NOLOCK) where om.LocationType = 2 and om.OrderId = @OrderId
FOR XML path('DeliveryInfoList'),ELEMENTS) AS XML)) as DeliveryInfoList
,(select cast ((SELECT 'true' AS [@json:Array] ,
l.LogId
,l.UserId
,l.ObjectId
,l.ObjectType
,l.LogDescription
,l.FunctionCall
,l.LogDate as LogDate
,l.LoggingTypeId
,l.Source
,l.CreatedDate
,(select top 1 CreatedDate from WorkFlowActivityLog where (OrderId =@OrderId or EnquiryId =@OrderId)) as fromdate
,(select top 1 CreatedDate from WorkFlowActivityLog where (OrderId =@OrderId or EnquiryId =@OrderId) and WorkFlowCurrentStatusCode > (select top 1 WorkFlowCurrentStatusCode from WorkFlowActivityLog where (OrderId =@OrderId or EnquiryId =@OrderId) )) as todate
,pwfal.ActivityStartTime
,pwfal.ActivityEndTime
,isnull((Select top 1 lin.[NAME] from [login] lin where lin.UserName=pwfal.Username),pwfal.Username)  as Username
FROM Log l (NOLOCK) where (l.ObjectId = @OrderId or l.ObjectId in (Select o.EnquiryId from [Order] o where o.OrderId=@OrderId))
and LogDate between isnull(pwfal.CreatedDate,'') 
and isnull((select top 1 CreatedDate From WorkFlowActivityLog wfal 
where (wfal.OrderId =@OrderId or wfal.EnquiryId in (Select o.EnquiryId from [Order] o where o.OrderId=@OrderId)) and wfal.WorkFlowActivityLogId > pwfal.WorkFlowActivityLogId 
and wac.IsActivityLogAvailable=1
order by wfal.WorkFlowActivityLogId asc ),'')
FOR XML path('LogList'),ELEMENTS) AS XML)) as LogList
FROM Activity a join WorkFlowStep ws (NOLOCK) on a.StatusCode=ws.StatusCode join [dbo].[WorkflowActivityConfiguration] wac (NOLOCK) on wac.StatusCode=ws.StatusCode
left join WorkFlowActivityLog pwfal (NOLOCK) on pwfal.WorkFlowCurrentStatusCode = ws.StatusCode and ws.WorkFlowCode = pwfal.WorkFlowCode and (OrderId =@OrderId or EnquiryId in (Select o.EnquiryId from [Order] o where o.OrderId=@OrderId))
where wac.WorkFlowCode=ws.WorkFlowCode and ws.WorkFlowCode = (select distinct WorkFlowCode from WorkFlowActivityLog (NOLOCK) 
where (OrderId =@OrderId or EnquiryId in (Select o.EnquiryId from [Order] o where o.OrderId=@OrderId))) and ws.IsActive=1
 and isnull(wac.IsAvailable,0)=1 and wac.IsActive=1 and wac.[RoleId]=@RoleId and wac.LoginId=@UserId
 union all
Select '0' as IsAvailable, '0' as IsNotificationLogAvailable, '0' as IsActivityLogAvailable, ISNULL(wac.IsStartDateAvailable,0) as IsStartDateAvailable,
 ISNULL(wac.IsEndDateAvailable,0) as IsEndDateAvailable, ISNULL(wac.IsUserNameAvailable,0) as IsUserNameAvailable
, ParentId as ParentId, a.IconName,1 as IsParent, '' as WorkFlowActivityLogId, '' as LoginId
, '' as RoleId, '' as EnquiryId, '' as EnquiryNumber, '' as OrderId, '' as OrderNumber
, '' as WorkFlowCode, a.StatusCode as WorkFlowCurrentStatusCode, a.DashboardDisplayName as WorkFlowCurrentActivityName
, '' as WorkFlowPreviousStatusCode, '' as WorkFlowPreviousActivityName, '' as RawData, '' as CreatedBy
, '' as CreatedDate, [Sequence] as SequenceNo, '' as IsAutomated

,

ISNULL((select ActivityEndTime from WorkFlowActivityLog where (OrderId =@OrderId or EnquiryId in (Select o.EnquiryId from [Order] o where o.OrderId=@OrderId))
and WorkFlowCurrentStatusCode in (
select top 1 statuscode from WorkFlowStep where workflowcode = (select distinct WorkFlowCode from WorkFlowActivityLog (NOLOCK) 
where  (OrderId =@OrderId or EnquiryId in (Select o.EnquiryId from [Order] o where o.OrderId=@OrderId)))
and statuscode in (select statuscode from activity where parentid = a.StatusCode)
order by sequenceno asc)), null) as ActivityStartTime,

ISNULL((select ActivityEndTime from WorkFlowActivityLog where (OrderId =@OrderId or EnquiryId in (Select o.EnquiryId from [Order] o where o.OrderId=@OrderId))
and WorkFlowCurrentStatusCode in (
select top 1 statuscode from WorkFlowStep where workflowcode = (select distinct WorkFlowCode from WorkFlowActivityLog (NOLOCK) 
where  (OrderId =@OrderId or EnquiryId in (Select o.EnquiryId from [Order] o where o.OrderId=@OrderId)))
and statuscode in (select statuscode from activity where parentid = a.StatusCode)
order by sequenceno desc)), null) as ActivityEndTime


,'' as Username,
 null as fromdate, null as todate
,null as EmailLogList,(select cast ((SELECT 'true' AS [@json:Array] ,
om.[OrderId]
,om.[DeliveryPersonnelId]
,(select top 1 l.Name from [Login] l  where l.LoginId=om.[DeliveryPersonnelId]) as [Name]
,(select top 1 ISNULL(p.ContactNumber,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,(select top 1 ISNULL(p.EmailId,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,om.[ExpectedTimeOfAction] as Planned
,om.[ActualTimeOfAction] as Actual
,(select loc.[LocationName] from Location loc where LocationId = om.Location) as CollectionLocationName
,'' as LastOnline
,om.[Latitude]
,om.[Longitude]
FROM [ORDERMOVEMENT] om (NOLOCK) where om.LocationType = 1 and om.OrderId = @OrderId
FOR XML path('CollectionInfoList'),ELEMENTS) AS XML)) as CollectionInfoList
,(select cast ((SELECT 'true' AS [@json:Array] ,om.[OrderId]
,om.[DeliveryPersonnelId]
,(select top 1 l.Name from [Login] l where l.LoginId=om.[DeliveryPersonnelId]) as [Name]
,(select top 1 ISNULL(p.ContactNumber,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,(select top 1 ISNULL(p.EmailId,'') from [Login] l join [Profile] p on l.ProfileId=p.ProfileId where l.LoginId=om.[DeliveryPersonnelId]) as [MobileNumber]
,om.[ExpectedTimeOfAction] as Planned
,om.[ActualTimeOfAction] as Actual
,(select loc.[LocationName] from Location loc where LocationId = om.Location) as DeliveryLocationName
,'' as LastOnline
,om.[Latitude]
,om.[Longitude]
FROM [ORDERMOVEMENT] om (NOLOCK) where om.LocationType = 2 and om.OrderId = @OrderId
FOR XML path('DeliveryInfoList'),ELEMENTS) AS XML)) as DeliveryInfoList,null as LogList
 from Activity a join [dbo].[WorkflowActivityConfiguration] wac (NOLOCK) on wac.StatusCode=a.StatusCode
 Where isnull(wac.IsAvailable,0)=1 and ParentId=0 and  a.StatusCode in (Select a.ParentId from WorkFlowStep ws join Activity a on ws.StatusCode=a.StatusCode
 where wac.WorkFlowCode=ws.WorkFlowCode and ws.WorkFlowCode = (select distinct WorkFlowCode from WorkFlowActivityLog (NOLOCK) 
where  wac.IsActive=1  and wac.[RoleId]=@RoleId and wac.LoginId=@UserId 
and (OrderId =@OrderId or EnquiryId in (Select o.EnquiryId from [Order] o where o.OrderId=@OrderId))))
 ) as d
 order by d.SequenceNo asc
FOR XML path('WorkFlowActivityLogList'),ELEMENTS,ROOT('Json')) AS XML)	

END