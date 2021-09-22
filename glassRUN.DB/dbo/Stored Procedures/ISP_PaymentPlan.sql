CREATE PROCEDURE [dbo].[ISP_PaymentPlan]
(
	@xmlDoc xml 
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

        INSERT INTO	[PaymentPlan]
        (
        	[PlanName],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        )
        SELECT
        	tmp.[PlanName],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	GETDATE()
		FROM OPENXML(@intpointer,'Json/PaymentPlanList',2)
        WITH
        (
            [PlanName] nvarchar(100),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
        )tmp
        
        DECLARE @PaymentPlanId bigint
	    SET @PaymentPlanId = @@IDENTITY
        
        --Add child table insert procedure when required.
    
  		SELECT @PaymentPlanId as PaymentPlanId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
