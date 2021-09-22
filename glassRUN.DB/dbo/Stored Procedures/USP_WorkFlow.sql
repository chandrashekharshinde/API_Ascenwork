CREATE PROCEDURE [dbo].[USP_WorkFlow] --'<Json><WorkFlowId>1</WorkFlowId><ServicesAction>UpdateWorkflow</ServicesAction><WorkFlowCode>ds</WorkFlowCode><WorkFlowName>sdsd</WorkFlowName><WorkFlowRule>sd</WorkFlowRule><FromDate>23/11/2018</FromDate><ToDate>30/11/2018</ToDate><CreatedBy>8</CreatedBy><ModifiedBy>8</ModifiedBy><IsActive>true</IsActive></Json>'
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
			 DECLARE @WorkFlow bigint

        update [WorkFlow] set     
					@WorkFlow=tmp.[WorkFlowId],
					[WorkFlowCode]=tmp.[WorkFlowCode] ,
					[WorkFlowName]=tmp.[WorkFlowName] ,
					[WorkFlowRule]=tmp.[WorkFlowRule] ,
					[ProcessType]=tmp.[ProcessType],
					[CompanyId]=tmp.[CompanyId] ,
					[IsActive]=tmp.[IsActive] ,
					[FromDate] = Case When tmp.[FromDate] = '' then null else tmp.[FromDate] end,
					[ToDate] = Case When tmp.[ToDate] = '' then null else tmp.[ToDate] end
				
            FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            
					[WorkFlowId] bigint,
					[WorkFlowCode] nvarchar(50),
					[WorkFlowName] nvarchar(100),
					[WorkFlowRule] nvarchar(500),
					[CompanyId] bigint,
					[ProcessType] bigint,
					[FromDate] datetime,
					[ToDate] datetime,
					[IsActive] bit
        )tmp where WorkFlow.[WorkFlowId]=tmp.[WorkFlowId]

        
        --Add child table insert procedure when required.

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

		DROP table #WorkFlowRules




	 SELECT  WorkFlowId,[WorkFlowName],[WorkFlowCode] from [WorkFlow] where Workflowid = @WorkFlow  FOR XML RAW('Json'),ELEMENTS
    --EXEC SSP_WorkFlowById @WorkFlow
	--SELECT Convert(nvarchar(10),@WorkFlow)
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
