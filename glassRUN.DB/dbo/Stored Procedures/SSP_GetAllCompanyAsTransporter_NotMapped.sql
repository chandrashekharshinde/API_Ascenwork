
Create PROCEDURE [dbo].[SSP_GetAllCompanyAsTransporter_NotMapped]
(
	@xmlDoc XML
)
AS
BEGIN
	
	-- exec [dbo].[SSP_GetAllCompanyAsTransporter_NotMapped] '<Json><PaymentPlanId>0</PaymentPlanId></Json>'

	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	SET @ErrSeverity = 15; 

	BEGIN TRY
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

		Declare @PaymentPlanId bigint

		SELECT 
			@PaymentPlanId = tmp.[PaymentPlanId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PaymentPlanId] bigint
		)tmp ;
			
				
		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
		SELECT CAST((
			SELECT DISTINCT
			'true' AS [@json:Array] ,
			[CompanyId],
			[CompanyName]
		FROM [dbo].[Company]
		WHERE IsActive=1
		And CompanyType=28
		And CompanyId Not In (Select TransporterId From PaymentPlanTransporterMapping Where PaymentPlanId=@PaymentPlanId)
	FOR XML path('CompanyList'),ELEMENTS,ROOT('Json')) AS XML)

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
