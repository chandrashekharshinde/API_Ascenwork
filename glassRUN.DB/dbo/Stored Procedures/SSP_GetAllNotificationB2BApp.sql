



CREATE PROCEDURE [dbo].[SSP_GetAllNotificationB2BApp] --''

@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @companyId bigint=0
Declare @RoleId bigint;
Declare @UserId bigint;
Declare @CompanyType nvarchar (100);
Declare @PageName nvarchar (100);




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

	SELECT

	@CompanyId=tmp.CompanyId,
	@RoleId=tmp.RoleId,
	@UserId=tmp.UserId,
	@PageName=tmp.PageName
	FROM OPENXML(@intpointer,'Json',2)
	   WITH
	   (
		CompanyId bigint,
		RoleId bigint,
		UserId bigint,
		PageName nvarchar (100)
	   )tmp;

  print @CompanyId
  set @CompanyType=(select top 1 CompanyType from Company where CompanyId=@CompanyId);

 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
 SELECT CAST((Select 'true' AS [@json:Array] ,E1.EventUserType,
	 E1.EventCode,
	 E1.UserType,
	 E1.DescriptionResourceKey,
	 E1.DisplayIcon
	 ,isnull((select top 1 (case when N1.[Notification]=1 then 1  when N1.[Notification]=0 then 0  else  -1 end) IsSelected 
	 from NotificationPreferences N1
	  where  N1.IsActive=1 and N1.CompanyId=@CompanyId  and N1.EventMasterId=(select top 1 EventMasterId from EventMaster  
	  where EventCode=E1.EventCode and EventMaster.IsActive=1)),-1) as IsSelectedNotification,
	 (select top 1 EventMasterId from EventMaster where EventCode=E1.EventCode and EventMaster.IsActive=1) EventMasterId
	 ,(select top 1 [UserPreferencesValue] from [UserPreferences] where [CompanyId] = @companyId and [UserPreferencesKey] = 'NotificationStoreDays') As NotificationDays
	from EventUserTypeMapping E1  where IsActive=1 and UserType=@CompanyType order by SequenceNumber
	FOR XML path('NotificationList'),ELEMENTS,ROOT('Json')) AS XML)

end
