-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.PasswordHistory table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_PasswordHistory]-- '<PasswordHistory xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><ObjectId>0</ObjectId><TotalCount>0</TotalCount><ObjectType>0</ObjectType><CurrentState>0</CurrentState><CurrentUser>0</CurrentUser><OfficeID>0</OfficeID><IsActive>true</IsActive><CreatedBy>422</CreatedBy><CreatedDate>2019-02-04T15:46:04.917233+05:30</CreatedDate><CreatedFromIPAddress>12.56546.23</CreatedFromIPAddress><PasswordHistoryId>0</PasswordHistoryId><ProfileId>422</ProfileId><HashedPassword>cNeats/euGaA84MzxL83J7/u9SH1OZPHYDmt0L8TV5M=</HashedPassword><PasswordSalt>591193132</PasswordSalt><GUID>b73b77ae-cd1d-4cd4-92fa-0200a9af95f7</GUID></PasswordHistory>'
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

        INSERT INTO	[PasswordHistory]
        (
        	[ProfileId],
        	[HashedPassword],
        	[PasswordSalt],
        	[PasswordChangedDate],
        	[PasswordResetBy],
        	[EmailAddress],
        	[PhoneNo],
        	[OneTimePassword],
        	[IsActive],
        	[CreatedDate],
        	[CreatedBy],
        	[CreatedFromIPAddress],
        	[UpdatedDate],
        	[UpdatedBy],
        	[UpdatedFromIPAddress],
			ResetPasswordCode,
			[GUID]
        )

        SELECT
        	tmp.[ProfileId],
        	tmp.[HashedPassword],
        	tmp.[PasswordSalt],
        	tmp.[PasswordChangedDate],
        	tmp.[PasswordResetBy],
        	tmp.[EmailAddress],
        	tmp.[PhoneNo],
        	tmp.[OneTimePassword],
        	tmp.[IsActive],
        	tmp.[CreatedDate],
        	tmp.[CreatedBy],
        	tmp.[CreatedFromIPAddress],
        	tmp.[UpdatedDate],
        	tmp.[UpdatedBy],
        	tmp.[UpdatedFromIPAddress],
			tmp.ResetPasswordCode,
			tmp.GUID
            FROM OPENXML(@intpointer,'PasswordHistory',2)
        WITH
        (
            [ProfileId] bigint,
            [HashedPassword] nchar(10),
            [PasswordSalt] nvarchar(100),
            [PasswordChangedDate] datetime,
            [PasswordResetBy] nvarchar(50),
            [EmailAddress] nvarchar(150),
            [PhoneNo] nvarchar(50),
            [OneTimePassword] nvarchar(50),
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [CreatedFromIPAddress] nvarchar(20),
            [UpdatedDate] datetime,
            [UpdatedBy] bigint,
            [UpdatedFromIPAddress] nvarchar(20),
			ResetPasswordCode nvarchar(200),
			GUID nvarchar(200)
        )tmp
        
        DECLARE @PasswordHistory bigint
	    SET @PasswordHistory = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @PasswordHistory
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END