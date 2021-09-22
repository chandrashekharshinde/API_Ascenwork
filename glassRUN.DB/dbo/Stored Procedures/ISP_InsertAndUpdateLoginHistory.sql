
CREATE PROCEDURE [dbo].[ISP_InsertAndUpdateLoginHistory] --'<Rules><RuleId>0</RuleId><RuleType>2</RuleType><RuleName>''Allocation ==1111026 for  ( ''{Item.SKUCode}'' == ''65105011'')''</RuleName><RuleText>if ''{Company.CompanyMnemonic}'' ==''1111026'' &amp; ( ''{Item.SKUCode}'' == ''65105011'') Then {Rule.Result} = literal(''{780}'')</RuleText><SKUCode>65105011</SKUCode><CompanyType>1111026</CompanyType><Remarks>ItemAllocation</Remarks><ShipTo>0</ShipTo><SequenceNumber>0</SequenceNumber><FromDate>2019-07-01T00:00:00</FromDate><ToDate>2019-07-01T00:00:00</ToDate><CreatedBy>0</CreatedBy><CreatedDate>2019-07-01T18:06:47.3952565+05:30</CreatedDate><IsActive>1</IsActive><SequenceNo>0</SequenceNo><AddOrDelete>Y</AddOrDelete><Description>PROM125</Description></Rules>'
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


        
        Select * Into #tempLoginHistory  FROM OPENXML(@intpointer,'Json/LoginHistoryList',2)
        WITH
        (
		[LoginId] bigint,
		[Username] nvarchar(100) ,
		[LogoutType] nvarchar(100) ,
		[LoggingInTime] nvarchar(100) ,
		[LoggingOutTime] nvarchar(100) ,
		[DeviceLoggingInTime] nvarchar(100) ,
		[DeviceLoggingOutTime] nvarchar(100) ,
		[AddFrom] nvarchar(50) ,
		[MACAddress] nvarchar(100) ,
		[LoginReason] nvarchar(100) ,
		[LogoutReason] nvarchar(100) ,
		[LoginStatus] nvarchar(50) ,
		[LoginNetworkStatus] bit ,
		[LogoutNetworkStatus] bit ,
		[LogOutLatitude] nvarchar(50) ,
		[LogOutLongitude] nvarchar(50) ,
		[LoginLatitude] nvarchar(50) ,
		[LoginLongitude] nvarchar(50) ,
		[LoggingInDeviceUniqueId] nvarchar(100) ,
		[LogoutDeviceUniqueId] nvarchar(100) ,
		[Guid] nvarchar(100) ,
		[IsActive] bit,
		[CreatedDate] nvarchar(100),
		[CreatedBy] bigint,
		[CreatedFromIPAddress] nvarchar(20) ,
		[UpdatedDate] nvarchar(100) ,
		[UpdatedBy] bigint ,
		[UpdatedFromIPAddress] nvarchar(20) 
        )tmp
        
		  --Select * from #tempLoginHistory

		Update [dbo].[LoginHistory] set 

        [dbo].[LoginHistory].LogoutReason = tmp.LogoutReason,
        [dbo].[LoginHistory].LoggingOutTime =tmp.LoggingOutTime,
        [dbo].[LoginHistory].DeviceLoggingOutTime = tmp.DeviceLoggingOutTime,
        [dbo].[LoginHistory].LogoutNetworkStatus = tmp.LogoutNetworkStatus,
        [dbo].[LoginHistory].UpdatedDate =tmp.UpdatedDate,
        [dbo].[LoginHistory].UpdatedBy =tmp.UpdatedBy,
        [dbo].[LoginHistory].LogOutLatitude = tmp.LogOutLatitude,
        [dbo].[LoginHistory].LogOutLongitude =  tmp.LogOutLongitude,
        [dbo].[LoginHistory].UpdatedFromIPAddress =  tmp.UpdatedFromIPAddress,
        [dbo].[LoginHistory].LogoutDeviceUniqueId =  tmp.LogoutDeviceUniqueId
		from #tempLoginHistory tmp where tmp.[Guid]=isnull([dbo].[LoginHistory].[Guid],'-')




		INSERT INTO [dbo].[LoginHistory]
           ([LoginId]
           ,[Username]
           ,[LogoutType]
           ,[LoggingInTime]
           ,[LoggingOutTime]
           ,[DeviceLoggingInTime]
           ,[DeviceLoggingOutTime]
           ,[AddFrom]
           ,[MACAddress]
           ,[LoginReason]
           ,[LogoutReason]
           ,[LoginStatus]
           ,[LoginNetworkStatus]
           ,[LogoutNetworkStatus]
           ,[LogOutLatitude]
           ,[LogOutLongitude]
           ,[LoginLatitude]
           ,[LoginLongitude]
           ,[LoggingInDeviceUniqueId]
           ,[LogoutDeviceUniqueId]
           ,[Guid]
           ,[IsActive]
           ,[CreatedDate]
           ,[CreatedBy]
           ,[CreatedFromIPAddress]
           ,[UpdatedDate]
           ,[UpdatedBy]
           ,[UpdatedFromIPAddress]
		   )
		   Select tmp.[LoginId]
           ,tmp.[Username]
           ,tmp.[LogoutType]
           ,tmp.[LoggingInTime]
           ,Case when tmp.[LoggingOutTime] ='01/Jan/1900' then null else tmp.[LoggingOutTime] end 
           ,tmp.[DeviceLoggingInTime]
           ,Case when tmp.[DeviceLoggingOutTime] ='01/Jan/1900' then null else tmp.[DeviceLoggingOutTime] end
           ,tmp.[AddFrom]
           ,tmp.[MACAddress]
           ,tmp.[LoginReason]
           ,tmp.[LogoutReason]
           ,tmp.[LoginStatus]
           ,tmp.[LoginNetworkStatus]
           ,tmp.[LogoutNetworkStatus]
           ,tmp.[LogOutLatitude]
           ,tmp.[LogOutLongitude]
           ,tmp.[LoginLatitude]
           ,tmp.[LoginLongitude]
           ,tmp.[LoggingInDeviceUniqueId]
           ,tmp.[LogoutDeviceUniqueId]
           ,tmp.[Guid]
           ,tmp.[IsActive]
           ,tmp.[CreatedDate]
           ,tmp.[CreatedBy]
           ,tmp.[CreatedFromIPAddress]
		    ,Case when tmp.[UpdatedDate] ='01/Jan/1900' then null else tmp.[UpdatedDate] end
           ,tmp.[UpdatedBy]
           ,tmp.[UpdatedFromIPAddress] from #tempLoginHistory tmp where tmp.[Guid] not in (Select isnull(lh.[Guid],'-') from LoginHistory lh)
		
    
    SELECT 1 as LoginHistory FOR XML RAW('Json'),ELEMENTS
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END