CREATE PROCEDURE [dbo].[SSP_GetEventRecipientByEventContentIdAndEventMasterIdAndNotificationTypeMasterId]-- '<Json><EventNotificationId>15569</EventNotificationId><EventCode>EnquiryCreated</EventCode><EventMasterId>25</EventMasterId><ObjectId>835</ObjectId><ObjectType>Enquiry</ObjectType><IsCreated>0</IsCreated><IsActive>1</IsActive><CreatedBy>10626</CreatedBy><CreatedDate>2019-08-06T10:23:55.887</CreatedDate><Subject>TINQ027176 is created</Subject><BodyContent /><EventContentId>10093</EventContentId><NotificationType>DEVICE</NotificationType><NotificationTypeMasterId>1</NotificationTypeMasterId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

  select * into #tmpfilter
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			EventMasterId bigint,
		   NotificationTypeMasterId bigint,
		   EventNotificationId bigint,
		   EventContentId bigint,
		    ObjectId bigint ,
			ObjectType nvarchar(250)
			)tmp ;


	
	
	Create table #TableVariableEventRecipient (RecipientType nvarchar(250), Recipient varchar(50), LoginId bigint)

  SELECT ROW_NUMBER() OVER(ORDER BY EventRecipientId asc) AS RowId,er.Recipient,er.RecipientType,er.RoleMasterId,er.UserId  ,er.IsSpecific,#tmpfilter.EventMasterId,#tmpfilter.EventNotificationId INTO #EventRecipienttemp  
  from  EventRecipient er  join #tmpfilter  on   er.EventMasterId= #tmpfilter.EventMasterId
  and er.NotificationTypeMasterId=  #tmpfilter.NotificationTypeMasterId  and er.EventContentId=#tmpfilter.EventContentId
  where er.IsActive=1
DECLARE @site_value INT;
DECLARE @site_RowCount INT;






SET @site_value = 1;
SET @site_RowCount=(SELECT COUNT(*) FROM #EventRecipienttemp)
WHILE @site_value <= @site_RowCount
BEGIN


---custom email address
if(exists(select *From    #EventRecipienttemp  where  RowId =@site_value  and (Recipient is not null and  Recipient !=''  )))
begin

insert into #TableVariableEventRecipient(RecipientType,Recipient) select RecipientType ,Recipient  From   #EventRecipienttemp  where  RowId =@site_value

end

-----get recipeint from user id

if(exists(select *From    #EventRecipienttemp  where  RowId =@site_value  and  (UserId is not null and  UserId !='0'  )))
begin

insert into #TableVariableEventRecipient(RecipientType,Recipient,LoginId) select RecipientType ,isnull((select top 1 Contacts from  ContactInformation  where ContactType='Email' and objectid=l.LoginId  and ObjectType='Login' and IsActive=1),'')  ,l.LoginId From   #EventRecipienttemp join Login l on 
#EventRecipienttemp.UserId = l.LoginId       where  RowId =@site_value    and UserId is not null

end

-----get recipeint from rolemaster id   and isspecify is  null

if(exists(select *From    #EventRecipienttemp  where  RowId =@site_value  and   (RoleMasterId is not null and  RoleMasterId !='0'   and isnull(IsSpecific,'0') =0  ) ))
begin
Print '1'
insert into #TableVariableEventRecipient(RecipientType,Recipient,LoginId) 
select RecipientType ,isnull((select top 1 Contacts from  ContactInformation  where ContactType='Email' and objectid=l.LoginId  and ObjectType='Login' and IsActive=1),''),l.LoginId   From   #EventRecipienttemp   join RoleMaster r on r.RoleMasterId=#EventRecipienttemp.RoleMasterId join 
  Login l on l.RoleMasterId = r.RoleMasterId     where  RowId =@site_value    and #EventRecipienttemp.RoleMasterId is not null

end



-----get recipeint from rolemaster id  and isspecify is not null

if(exists(select *From    #EventRecipienttemp  where  RowId =@site_value  and   (RoleMasterId is not null and  RoleMasterId !='0'   and isnull(IsSpecific,'0') =1 ) ))
begin
Print '2'

--select * from #EventRecipienttemp
Declare @EventMasterId bigint;
Declare @EventNotificationId bigint;
declare @RoleMasterId bigint;
Declare @RecipientType Nvarchar(250);
select @EventMasterId=#EventRecipienttemp.EventMasterId ,
@RoleMasterId=#EventRecipienttemp.RoleMasterId,
@EventNotificationId=#EventRecipienttemp.EventNotificationId,
@RecipientType=#EventRecipienttemp.RecipientType
From   #EventRecipienttemp  where  RowId =@site_value    and #EventRecipienttemp.RoleMasterId is not null

Print @EventMasterId
Print @EventNotificationId
Print @RoleMasterId

insert into #TableVariableEventRecipient(RecipientType,Recipient,LoginId) 
SELECT @RecipientType,*  from dbo.SSP_GetSpecificEventrecipientbyEventCode(@EventMasterId,@EventNotificationId,@RoleMasterId) 

end


SET @site_value = @site_value + 1;
END;

--select *From   #TableVariableEventRecipient;
--select * from #EventRecipienttemp;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((select 'true' AS [@json:Array],*   , 

(select cast ((SELECT  'true' AS [@json:Array]  ,UserId as 'LoginId'  , DeviceType , DeviceToken , PushNotificationType    From    UserDetailDeviceTokenMapping
  WHERE  UserId=#TableVariableEventRecipient.LoginId

 FOR XML path('UserDetailDeviceTokenMappingList'),ELEMENTS) AS xml))
 From     #TableVariableEventRecipient
	FOR XML path('EventRecipientList'),ELEMENTS,ROOT('Json')) AS XML)



  DROP TABLE #TableVariableEventRecipient
  DROP TABLE #EventRecipienttemp
 


--IF(@EventCode ='OrderCreated')
--BEGIN

		
--WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
--SELECT CAST((select
-- o.OrderNumber ,
-- o.OrderDate,
-- e.EnquiryAutoNumber

--From 
-- dbo.[order]  o  left join  dbo.[Enquiry] e  on o.EnquiryId=e.EnquiryId  where   OrderId=@ObjectId
--	FOR XML path('Object'),ELEMENTS,ROOT('Json')) AS XML)

--END








END