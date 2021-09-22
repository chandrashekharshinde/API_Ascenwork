-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.Login table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_UpdatePassword] --'<Json><ServicesAction>UpdatePassword</ServicesAction><LoginId>478</LoginId><Password>123456789</Password><HashedPassword>D4xgbJaeGE+Nl0L9bNkuyOkCoax9lTphPcr1z/y7ZQM=</HashedPassword><PasswordSalt>-943560744</PasswordSalt></Json>'

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 
	Declare @guid nvarchar(500)
	BEGIN TRY

			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
            DECLARE @LoginId bigint
            UPDATE dbo.Login SET
			
			@LoginId=tmp.[LoginId],
        	
        	[HashedPassword]=tmp.HashedPassword ,
        	[PasswordSalt]=tmp.PasswordSalt ,
        	
        	[ChangePasswordonFirstLoginRequired]=0 ,        	
        	[UpdatedDate]=getdate() 
        	
        	
            FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
            [LoginId] bigint,
           
            
           
            [HashedPassword] nvarchar(50),
           
            [PasswordSalt] int,
           
           
           
            [UpdatedDate] datetime
           
           
           
            )tmp WHERE Login.[LoginId]=tmp.[LoginId] --Login.[GUID]=tmp.[GUID]

			--update Login set GUId=NULL where GUID=@guid
			--SELECT  @LoginId
            SELECT  @@ROWCOUNT
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_Login'
