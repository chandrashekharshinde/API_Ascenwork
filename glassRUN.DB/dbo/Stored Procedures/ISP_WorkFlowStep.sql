
CREATE PROCEDURE [dbo].[ISP_WorkFlowStep]-- '<Json><ServicesAction>InsertWorkFlowStep</ServicesAction><WorkflowStepList><StatusCode>1</StatusCode><ActivityName>Enquiry</ActivityName><WorkFlowCode></WorkFlowCode><IsAutomated>0</IsAutomated><ActivityFormMappingId>1</ActivityFormMappingId><FormName>EnquiryForm.html</FormName><SequenceNo>1</SequenceNo><IsActive>true</IsActive><WorkFlowStepRulesList><StatusCode>1</StatusCode><WorkFlowCode>ds</WorkFlowCode><WorkFlowRulesId>12</WorkFlowRulesId></WorkFlowStepRulesList></WorkflowStepList><WorkflowStepList><StatusCode>2</StatusCode><ActivityName>Enquiry Approval By Sales Admin</ActivityName><WorkFlowCode></WorkFlowCode><IsAutomated>0</IsAutomated><ActivityFormMappingId>0</ActivityFormMappingId><FormName /><SequenceNo>1</SequenceNo><IsActive>true</IsActive></WorkflowStepList><WorkflowStepList><StatusCode>3</StatusCode><ActivityName>Enquiry Approval By Delivery Manager</ActivityName><WorkFlowCode></WorkFlowCode><IsAutomated>0</IsAutomated><ActivityFormMappingId>0</ActivityFormMappingId><FormName /><SequenceNo>1</SequenceNo><IsActive>true</IsActive></WorkflowStepList><WorkflowStepList><StatusCode>4</StatusCode><ActivityName>Enquiry</ActivityName><WorkFlowCode></WorkFlowCode><IsAutomated>0</IsAutomated><ActivityFormMappingId>0</ActivityFormMappingId><FormName /><SequenceNo>1</SequenceNo><IsActive>true</IsActive></WorkflowStepList></Json>'
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


		SELECT * INTO #WorkflowStep
			
				
        FROM OPENXML(@intpointer,'Json/WorkflowStepList',2)
        WITH
        (
            
					
					[WorkFlowCode] nvarchar(100),
					[ActivityName] nvarchar(100),
					[StatusCode] bigint,
					[ActivityFormMappingId] bigint,
					[FormName] nvarchar(50),
					[SequenceNo] bigint,
					[IsAutomated] bit,
					[IsActive] bit
        )tmp
		select TOP 1 WorkFlowCode from #WorkflowStep
		delete from [WorkFlowStep] where WorkFlowCode = (select TOP 1 WorkFlowCode from #WorkflowStep)
		delete from [WorkFlowStepRules] where WorkFlowCode = (select TOP 1 WorkFlowCode from #WorkflowStep)

        INSERT INTO	[WorkFlowStep]
        (
			
					
					[WorkFlowCode] ,
					[ActivityName] ,
					[StatusCode] ,
					[ActivityFormMappingId] ,
					[FormName] ,
					[SequenceNo] ,
					[IsAutomated] ,
					[IsActive] 
        )

        SELECT
			
					
					tmp.[WorkFlowCode] ,
					tmp.[ActivityName] ,
					tmp.[StatusCode] ,
					tmp.[ActivityFormMappingId] ,
					tmp.[FormName] ,
					tmp.[SequenceNo] ,
					tmp.[IsAutomated] ,
					tmp.[IsActive] 
					FROM #WorkflowStep tmp

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
            FROM OPENXML(@intpointer,'Json/WorkflowStepList/WorkFlowStepRulesList',2)
        WITH
        (
            
					[RuleDescription] nvarchar(100),
					[WorkFlowCode] nvarchar(100),
					[StatusCode] bigint,
					[WorkFlowRulesId] bigint,
					[IsForNextStep] bit,
					[IsActive] bit
        )tmp

     --       FROM OPENXML(@intpointer,'Json/WorkflowStepList',2)
     --   WITH
     --   (
            
					
					--[WorkFlowCode] nvarchar(100),
					--[ActivityName] nvarchar(100),
					--[StatusCode] bigint,
					--[ActivityFormMappingId] bigint,
					--[FormName] nvarchar(50),
					--[SequenceNo] bigint,
					--[IsAutomated] bit,
					--[IsActive] bit
     --   )tmp
        
        DECLARE @WorkFlowStep bigint
	    SET @WorkFlowStep = @@IDENTITY
        
        --Add child table insert procedure when required.
		
    SELECT @WorkFlowStep
	
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
