CREATE PROCEDURE [dbo].[DSP_Login]
(
	@xmlDoc XML
)
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

		Declare @LoginId bigint
		Declare @PaymentPlanId bigint

		SELECT 
			@LoginId = tmp.[LoginId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[LoginId] bigint
        )tmp ;


		declare @currentstate bit
		declare @setstate bit
		set @currentstate = (select IsActive from login where  LoginId=@LoginId)

		if(@currentstate = 1)
		begin 
			set @setstate = 0
		end
		else
		begin
			set @setstate = 1
		end
			
		update Login set IsActive=@setstate,UpdatedDate=GETDATE() where LoginId=@LoginId
		update contactinformation set IsActive=@setstate,ModifiedDate=GETDATE() where ObjectId=@LoginId and ObjectType='Login'
		update documents set IsActive=@setstate,ModifiedDate=GETDATE() where ObjectId=@LoginId and ObjectType='Login'

	

	
	
		SELECT @LoginId as LoginId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
