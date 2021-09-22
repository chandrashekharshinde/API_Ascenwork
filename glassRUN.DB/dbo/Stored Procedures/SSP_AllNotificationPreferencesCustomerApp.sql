

CREATE PROCEDURE [dbo].[SSP_AllNotificationPreferencesCustomerApp]-- '<Json><ServicesAction>GetAllTruckSizeListByVehicleId</ServicesAction><CompanyId>10003</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN
DECLARE @intPointer INT;
declare @companyId bigint=0

declare @ItemValue  nvarchar(250);

Declare @companyType bigint;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyId=tmp.CompanyId
   
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [CompanyId] bigint
           
   )tmp;




select top 1 @companyType= CompanyType from Company where CompanyId=@CompanyId

 if @companyType=25
 begin
 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

SELECT CAST((SELECT 'true' AS [@json:Array] 
      
      ,[EventMasterId]
	  ,EventDescription
      
	  ,ISNULL((Select ISNULL([Notification],0) from NotificationPreferences where EventMasterId=EventMaster.EventMasterId and IsActive=1 and CompanyId=@companyId),0) as [Notification]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
		
		FROM EventMaster  WHERE IsActive = 1 and EventMasterId in(39,40,41,42)
		order by ISNULL((Select ISNULL([Notification],0) from NotificationPreferences where EventMasterId=EventMaster.EventMasterId and IsActive=1 and CompanyId=@companyId),0) desc
	FOR XML path('NotificationPreferencesList'),ELEMENTS,ROOT('Json')) AS XML)
 end
 else
 begin
 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

SELECT CAST((SELECT 'true' AS [@json:Array] 
      
      ,[EventMasterId]
	  ,EventDescription
      
	  ,ISNULL((Select ISNULL([Notification],0) from NotificationPreferences where EventMasterId=EventMaster.EventMasterId and IsActive=1 and CompanyId=@companyId),0) as [Notification]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
		
		FROM EventMaster  WHERE IsActive = 1 and EventCode in('EnquiryRejected','OrderCreated','ComplaintReceivedFromCustomer','ChatMessage','Collected','Delivered','TruckOut')
		order by ISNULL((Select ISNULL([Notification],0) from NotificationPreferences where EventMasterId=EventMaster.EventMasterId and IsActive=1 and CompanyId=@companyId),0) desc

	FOR XML path('NotificationPreferencesList'),ELEMENTS,ROOT('Json')) AS XML)
 end

END






