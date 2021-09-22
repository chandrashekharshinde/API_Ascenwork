CREATE PROCEDURE [dbo].[ISP_WorkFlowStepRules]
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

        INSERT INTO	[WorkFlowStepRules]
        (
			
					
					[RuleDescription] ,
					[WorkFlowCode],
					[StatusCode],
					[WorkFlowRulesId] ,
					[IsForNextStep] ,
					[IsActive] 
        )

        SELECT
					tmp.[RuleDescription] ,
					tmp.[WorkFlowCode],
					tmp.[StatusCode],
					tmp.[WorkFlowRulesId] ,
					tmp.[IsForNextStep] ,
					tmp.[IsActive] 
            FROM OPENXML(@intpointer,'WorkFlowStepRules',2)
        WITH
        (
            
					[RuleDescription] nvarchar(100),
					[WorkFlowCode] nvarchar(100),
					[StatusCode] bigint,
					[WorkFlowRulesId] bigint,
					[IsForNextStep] bit,
					[IsActive] bit
        )tmp
        
        DECLARE @WorkFlowStepRules bigint
	    SET @WorkFlowStepRules = @@IDENTITY
        
        --Add child table insert procedure when required.
		
    SELECT @WorkFlowStepRules
	
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END