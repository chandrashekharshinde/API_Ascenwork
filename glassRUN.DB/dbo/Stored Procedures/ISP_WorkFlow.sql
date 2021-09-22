CREATE PROCEDURE [dbo].[ISP_WorkFlow] --'<Json><WorkFlowId>0</WorkFlowId><ServicesAction>InsertWorkflow</ServicesAction><WorkFlowCode>3</WorkFlowCode><WorkFlowName>3</WorkFlowName><CreatedBy>8</CreatedBy><ModifiedBy>8</ModifiedBy><IsActive>true</IsActive></Json>'
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

        INSERT INTO	[WorkFlow]
        (
			
					[WorkFlowCode] ,
					[WorkFlowName] ,
					[WorkFlowRule] ,
					[CompanyId] ,
					[ProcessType],
					[FromDate],
					[ToDate],
					[IsActive] 
        )

        SELECT
			
					tmp.[WorkFlowCode] ,
					tmp.[WorkFlowName] ,
					tmp.[WorkFlowRule] ,
					tmp.[CompanyId] ,
					tmp.[ProcessType],
					Case When isnull(tmp.[FromDate],'') = '' then getdate() else tmp.[FromDate] end,
					Case When isnull(tmp.[ToDate],'') = '' then DATEADD(YEAR,50,getdate()) else tmp.[ToDate] end,
					tmp.[IsActive] 
            FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            
					[WorkFlowCode] nvarchar(50),
					[WorkFlowName] nvarchar(100),
					[WorkFlowRule] nvarchar(500),
					[FromDate] datetime,
					[ToDate] datetime,
					[CompanyId] bigint,
					[ProcessType] bigint,
					[IsActive] bit
        )tmp

		
        DECLARE @WorkFlow bigint
        
	    SET @WorkFlow = @@IDENTITY
		--Insert into Worklfow Rules


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
        
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
