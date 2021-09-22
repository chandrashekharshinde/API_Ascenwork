CREATE PROCEDURE [dbo].[ISP_UserDetailDeviceTokenMapping]--'<UserDetailDeviceTokenMapping xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><UserDetailDeviceTokenMappingId>0</UserDetailDeviceTokenMappingId><UserId>15</UserId><DeviceType>ANDROID</DeviceType><DeviceToken /><IsExpired>false</IsExpired><VendorId>6b356755575fce31</VendorId><PushNotificationType>CustomerApp</PushNotificationType><IsActive>false</IsActive><CreatedDate>0001-01-01T00:00:00</CreatedDate><CreatedBy>0</CreatedBy></UserDetailDeviceTokenMapping>'
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

				--------------------OrderMovement Start---------------------------
			SELECT * INTO #tmpUserDetailDeviceTokenMapping
			FROM OPENXML(@intpointer,'Json',2)
			WITH 
			(	
				
				[UserId] [bigint]  ,
				[DeviceType] NVARCHAR(150),
				[DeviceToken] NVARCHAR(500),
				[IsExpired] [bit]  ,
				[VendorId] NVARCHAR(150),
				[PushNotificationType] NVARCHAR(150)
				)tmp



				--SELECT * from #tmpUserDetailDeviceTokenMapping
				---------------------update all device token by device token in   UserDetailDeviceTokenMapping


--------------delete   UserDetailDeviceTokenMapping


--declare @UpdateDevicToken   NVARCHAR(500) ;



--set  @UpdateDevicToken  = ( SELECT	top 1	#tmpUserDetailDeviceTokenMapping.DeviceToken FROM #tmpUserDetailDeviceTokenMapping)






				delete UserDetailDeviceTokenMapping  
				where UserDetailDeviceTokenMappingId  in (
				
				SELECT
						uddtm.UserDetailDeviceTokenMappingId
						FROM #tmpUserDetailDeviceTokenMapping
						LEFT JOIN dbo.UserDetailDeviceTokenMapping  uddtm
						ON #tmpUserDetailDeviceTokenMapping.UserId = uddtm.UserId
						and  #tmpUserDetailDeviceTokenMapping.DeviceType = uddtm.DeviceType
						and #tmpUserDetailDeviceTokenMapping.PushNotificationType = uddtm.PushNotificationType
					)





---------------------------insert  UserDetailDeviceTokenMapping


				INSERT INTO [dbo].[UserDetailDeviceTokenMapping]
					(
					    [UserId],
						[DeviceType],
						[DeviceToken],
						[IsExpired],
						[VendorId],
						[PushNotificationType],
						[IsActive]	,
						CreatedDate,
						CreatedBy
					)
					SELECT
						#tmpUserDetailDeviceTokenMapping.UserId,
						#tmpUserDetailDeviceTokenMapping.DeviceType,
						#tmpUserDetailDeviceTokenMapping.DeviceToken,
						#tmpUserDetailDeviceTokenMapping.IsExpired,
						#tmpUserDetailDeviceTokenMapping.VendorId,
						#tmpUserDetailDeviceTokenMapping.PushNotificationType,
					    1,           
						GETDATE(),
						1
						FROM #tmpUserDetailDeviceTokenMapping

						LEFT JOIN dbo.UserDetailDeviceTokenMapping  uddtm
						ON #tmpUserDetailDeviceTokenMapping.UserId = uddtm.UserId
						and  #tmpUserDetailDeviceTokenMapping.DeviceToken = uddtm.DeviceToken
						and  #tmpUserDetailDeviceTokenMapping.DeviceType = uddtm.DeviceType
						and #tmpUserDetailDeviceTokenMapping.PushNotificationType = uddtm.PushNotificationType
						where  (#tmpUserDetailDeviceTokenMapping.DeviceToken IS not NULL and #tmpUserDetailDeviceTokenMapping.DeviceToken ! ='' )
						and  uddtm.UserDetailDeviceTokenMappingId is null
             


						
        DECLARE @UserDetailDeviceTokenMappingId bigint
	    SET @UserDetailDeviceTokenMappingId = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @UserDetailDeviceTokenMappingId
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END