
CREATE PROCEDURE [dbo].[USP_WorkFlowStep]
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
			 DECLARE @WorkFlowStep bigint

        update [WorkFlowStep] set     
					@WorkFlowStep=tmp.[WorkFlowStepId],
					
					[WorkFlowCode]=tmp.[WorkFlowCode] ,
					[ActivityName]=tmp.[ActivityName] ,
					[StatusCode]=tmp.[StatusCode] ,
					[ActivityFormMappingId]=tmp.[ActivityFormMappingId] ,
					[FormName]=tmp.[FormName] ,
					[SequenceNo]=tmp.[SequenceNo] ,
					[IsAutomated]=tmp.[IsAutomated] ,
					[IsActive]=tmp.[IsActive] 
            FROM OPENXML(@intpointer,'Json/WorkflowStepList',2)
        WITH
        (
            
					[WorkFlowStepId] bigint,
					[WorkFlowCode] nvarchar(100),
					[ActivityName] nvarchar(100),
					[StatusCode] bigint,
					[ActivityFormMappingId] bigint,
					[FormName] nvarchar(50),
					[SequenceNo] bigint,
					[IsAutomated] bit,
					[IsActive] bit
        )tmp where WorkFlowStep.[WorkFlowStepId]=tmp.[WorkFlowStepId]

        
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