-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleMaster table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_NotificationRequestByEmailAddressAndMessageId]-- '<Json><ServicesAction>InsertAndUpdateRoleMaster</ServicesAction><RoleMasterId>0</RoleMasterId><Description>ere</Description><RoleName>ererr</RoleName><PolicyName>Default Policy</PolicyName><CreatedBy>8</CreatedBy><IsActive>true</IsActive></Json>'

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
            


			select * into #tempNotificationRequestList
			  FROM OPENXML(@intpointer,'Json/NotificationRequestList',2)
			WITH
			(
               
            [MessageId] nvarchar(250), 
			[IsDeliveredDatetime] nvarchar(250),       
			[EmailAddress] nvarchar(250),  
            [IsDelivered] bit,           
            [IsDeliveredReason] nvarchar(250)  			   
            )tmp 


			

			----update notfication request table by messageid and email address

			update NotificationRequest   set   IsDelivered = #tempNotificationRequestList.IsDelivered   , IsDeliveredDatetime=#tempNotificationRequestList.IsDelivered,
			   IsDeliveredReason=#tempNotificationRequestList.IsDeliveredReason from 
			 #tempNotificationRequestList  join  NotificationRequest  nr on nr.MessageId=#tempNotificationRequestList.[MessageId]  and nr.RecipientTo = #tempNotificationRequestList.[EmailAddress]
			 where nr.NotificationRequestId  is not null



			 SELECT 'Success' as OutputMessage FOR XML RAW('Json'),ELEMENTS
          
		  
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure ISP_EventNotification'