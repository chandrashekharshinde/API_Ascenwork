-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleMaster table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_EventNotification]-- '<Json><ServicesAction>InsertAndUpdateRoleMaster</ServicesAction><RoleMasterId>0</RoleMasterId><Description>ere</Description><RoleName>ererr</RoleName><PolicyName>Default Policy</PolicyName><CreatedBy>8</CreatedBy><IsActive>true</IsActive></Json>'

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
            


			select * into #tempEventNotification
			  FROM OPENXML(@intpointer,'Json/EventNotificationList',2)
			WITH
			(
            [EventMasterId] bigint,           
            [EventCode] nvarchar(50), 
			[ObjectId] bigint,        
			[ObjectType] nvarchar(150),  
            [CreatedBy] bigint,           
            [CreatedDate] nvarchar(20)  			   
            )tmp 


			 DECLARE @EventNotificationId bigint
	  

			-----insert  role master 
			INSERT INTO [EventNotification] ( [EventMasterId], [EventCode], [ObjectId], [ObjectType], [IsActive], [CreatedDate], [CreatedBy] ) 
			SELECT (select top 1  EventMasterId  From EventMaster  em where  em.EventCode= #tempEventNotification.[EventCode] ), #tempEventNotification.[EventCode],#tempEventNotification.[ObjectId], #tempEventNotification.[ObjectType], 1, GETDATE(), #tempEventNotification.[CreatedBy]
			from    #tempEventNotification  
			   SET @EventNotificationId = @@IDENTITY

			  


			 SELECT @EventNotificationId as EventNotificationId FOR XML RAW('Json'),ELEMENTS
          
		  
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure ISP_EventNotification'
