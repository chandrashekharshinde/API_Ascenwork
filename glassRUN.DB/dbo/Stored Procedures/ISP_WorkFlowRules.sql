
CREATE PROCEDURE [dbo].[ISP_WorkFlowRules] --'<Json><ServicesAction>InsertWorkFlowStep</ServicesAction><WorkflowStepList><StatusCode>1</StatusCode><ActivityName>Enquiry</ActivityName><WorkFlowCode>ds</WorkFlowCode><IsAutomated>0</IsAutomated><ActivityFormMappingId>1</ActivityFormMappingId><FormName>EnquiryForm.html</FormName><SequenceNo>1</SequenceNo><IsActive>true</IsActive><WorkFlowStepRulesList><StatusCode>1</StatusCode><WorkFlowCode>ds</WorkFlowCode><WorkFlowRulesId>18</WorkFlowRulesId></WorkFlowStepRulesList></WorkflowStepList><WorkflowStepList><StatusCode>2</StatusCode><ActivityName>Enquiry Approval By Sales Admin</ActivityName><WorkFlowCode>ds</WorkFlowCode><IsAutomated>0</IsAutomated><ActivityFormMappingId>0</ActivityFormMappingId><FormName /><SequenceNo>1</SequenceNo><IsActive>true</IsActive></WorkflowStepList><WorkflowStepList><StatusCode>3</StatusCode><ActivityName>Enquiry Approval By Delivery Manager</ActivityName><WorkFlowCode>ds</WorkFlowCode><IsAutomated>0</IsAutomated><ActivityFormMappingId>0</ActivityFormMappingId><FormName /><SequenceNo>1</SequenceNo><IsActive>true</IsActive></WorkflowStepList></Json>'
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


		SELECT * INTO #WorkFlowRules
			
				
        FROM OPENXML(@intpointer,'Json/WorkFlowRulesList',2)
        WITH
        (
            
					
					[RuleDescription] nvarchar(100),
					[WorkFlowCode] nvarchar(100),
					[RulesId] bigint,
					[IsForNextStep] bit,
					[IsActive] bit
        )tmp
		--select TOP 1 WorkFlowCode from #WorkFlowRules
		delete from WorkFlowRules where WorkFlowCode = (select TOP 1 WorkFlowCode from #WorkFlowRules)
		

        INSERT INTO	WorkFlowRules
        (
			
					
					[RuleDescription] ,
					[WorkFlowCode],
					[RulesId] ,
					[IsForNextStep] ,
					[IsActive] 
        )

        SELECT
			
					
						
					tmp.[RuleDescription] ,
					tmp.[WorkFlowCode],
					tmp.[RulesId] ,
					tmp.[IsForNextStep] ,
					tmp.[IsActive] 
					FROM #WorkFlowRules tmp

					

        
        DECLARE @WorkFlowRulesId bigint
	    SET @WorkFlowRulesId = @@IDENTITY
        
        --Add child table insert procedure when required.
		
    SELECT @WorkFlowRulesId
	
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
