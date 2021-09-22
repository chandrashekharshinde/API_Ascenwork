

CREATE PROCEDURE [dbo].[USP_WorkFlowStepRules]
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
			 DECLARE @WorkFlowStepRules bigint

        update [WorkFlowStepRules] set     
					@WorkFlowStepRules=tmp.[WorkFlowStepRulesId],
					
					[RuleDescription]=tmp.[RuleDescription] ,
					[WorkFlowCode]=tmp.[WorkFlowCode],
					[StatusCode]=tmp.[StatusCode],
					[WorkFlowRulesId]=tmp.[WorkFlowRulesId] ,
					[IsForNextStep]=tmp.[IsForNextStep] ,
					[IsActive]=tmp.[IsActive] 
            FROM OPENXML(@intpointer,'WorkFlowStepRules',2)
        WITH
        (
            
					[WorkFlowStepRulesId] bigint,
					[RuleDescription] nvarchar(100),
					[WorkFlowCode] nvarchar(100),
					[StatusCode] bigint,
					[WorkFlowRulesId] bigint,
					[IsForNextStep] bit,
					[IsActive] bit
        )tmp where WorkFlowStepRules.[WorkFlowStepRulesId]=tmp.[WorkFlowStepRulesId]

        
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