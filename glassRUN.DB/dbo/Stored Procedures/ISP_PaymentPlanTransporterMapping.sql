CREATE PROCEDURE [dbo].[ISP_PaymentPlanTransporterMapping]
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

        INSERT INTO	[PaymentPlanTransporterMapping]
        (
        	[PaymentPlanId],
        	[TransporterId]
        )
        SELECT
        	tmp.[PaymentPlanId],
        	tmp.[TransporterId]
		FROM OPENXML(@intpointer,'Json/PaymentPlanTransporterMappingList',2)
        WITH
        (
            [PaymentPlanId] bigint,
            [TransporterId] bigint
        )tmp
        
        DECLARE @PaymentPlanTransporterMappingId bigint
	    SET @PaymentPlanTransporterMappingId = @@IDENTITY
        
        --Add child table insert procedure when required.
    
  		SELECT @PaymentPlanTransporterMappingId as PaymentPlanTransporterMappingId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 	

    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END
