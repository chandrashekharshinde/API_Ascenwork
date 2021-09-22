-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.EmailConfiguration table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_EmailConfiguration] --'<Json><ServicesAction>SaveEmailConfiguration</ServicesAction><EmailConfigurationList><EmailConfigurationId>2</EmailConfigurationId><SmtpHost>smtp@gmail.com</SmtpHost><UserName>noreply.blankchq@gmail.com</UserName><Password>V@1bh@Vg</Password><EmailBodyType>html</EmailBodyType><FromEmail>nimesh@blankchq.com</FromEmail><PortNumber>587</PortNumber><EnableSSL>true</EnableSSL><CreatedBy>8</CreatedBy><IsActive>true</IsActive></EmailConfigurationList></Json>'

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
            DECLARE @EmailConfigurationId bigint
            UPDATE dbo.EmailConfiguration SET
			@EmailConfigurationId=tmp.EmailConfigurationId,
        	[SupplierId]=tmp.SupplierId ,
        	SmtpHost=tmp.SmtpHost ,
        	[FromEmail]=tmp.FromEmail ,
        	[UserName]=tmp.UserName ,
        	[Password]=tmp.Password ,
        	[EmailBodyType]=tmp.EmailBodyType ,
        	[PortNumber]=tmp.PortNumber ,
        	[EnableSSL]=tmp.EnableSSL ,
        	[EmailSignature]=tmp.EmailSignature ,
        	[IsActive]=tmp.IsActive ,        	
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedDate]=tmp.UpdatedDate
            FROM OPENXML(@intpointer,'Json/EmailConfigurationList',2)
			WITH
			(
			[EmailConfigurationId] bigint,
            [SupplierId] bigint,
            SmtpHost nvarchar(150),
            [FromEmail] nvarchar(150),
            [UserName] nvarchar(500),
            [Password] nvarchar(150),
            [EmailBodyType] nvarchar(150),
            [PortNumber] int,
            [EnableSSL] bit,
            [EmailSignature] nvarchar(4000),
            [IsActive] bit,
            [UpdatedBy] bigint,
            [UpdatedDate] datetime
            )tmp WHERE EmailConfiguration.[EmailConfigurationId]=tmp.[EmailConfigurationId]
           
            SELECT @EmailConfigurationId as EmailConfigurationId FOR XML RAW('Json'),ELEMENTS

            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
