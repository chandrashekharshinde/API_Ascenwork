
CREATE PROCEDURE [dbo].[USP_CustomerApp_NotificationSetting] --'<Json><ServicesAction>UdateNotificationPreferencesDetails</ServicesAction><NotificationPreferencesList><NotificationPreferencesId>1</NotificationPreferencesId><Companyid>66</Companyid><Notification>true</Notification></NotificationPreferencesList><NotificationPreferencesList><NotificationPreferencesId>2</NotificationPreferencesId><Companyid>66</Companyid><Notification>true</Notification></NotificationPreferencesList><NotificationPreferencesList><NotificationPreferencesId>3</NotificationPreferencesId><Companyid>66</Companyid><Notification>true</Notification></NotificationPreferencesList></Json>'
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
    
	  
	  DECLARE @Customerid BIGINT 
	  set @Customerid=0;
      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 
			select *  into #NotificationPreferencesList
				FROM OPENXML(@intpointer,'Json/NotificationPreferencesList',2)
				WITH
				(
				    [NotificationPreferencesId] bigint,
					[CustomerId] bigint,
					[Companyid] bigint,
					[CreatedBy] bigint,
					[Notification] nvarchar(250)
				)tmp	;

---select * from #NotificationPreferencesList

SET @Customerid=(select top 1 #NotificationPreferencesList.[CustomerId] from #NotificationPreferencesList)
delete from [NotificationPreferences] where CompanyId = (select top 1 #NotificationPreferencesList.[CustomerId] from #NotificationPreferencesList) 



INSERT INTO [dbo].[NotificationPreferences]
           ([CompanyId]
           ,[Notification]
		   ,[EventMasterId]
           ,[modifiedby]
           
		   ,[modifieddate]   
           
           ,[IsActive]
           
           )          SELECT tmp.[CustomerId]                  ,tmp.[Notification]				 ,tmp.EventMasterId				 ,tmp.[CreatedBy]                 ,Getdate()				 				 ,1                                            FROM   OPENXML(@intpointer, 'Json/NotificationPreferencesList', 2)                     WITH ( [NotificationPreferencesId] bigint,
				       [Companyid]   BIGINT, 
				       [CustomerId] BIGINT,
					   [EventMasterId] BIGINT,
					   [Notification] bit,
					   [CreatedBy] bigint    )tmp
		    	
			DECLARE @NotificationPreferences BIGINT 
			 SET @NotificationPreferences = @@IDENTITY ;
           -- Drop table #NotificationPreferencesList;
			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
			SELECT CAST((SELECT   'true' AS [@json:Array],
            @Customerid AS Customerid , (case when @Customerid=0 then 'Faild' else 'Success' end) as Status
          FOR XML path('NotificationList'),ELEMENTS,ROOT('Json')) AS XML)

          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 
          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END
  