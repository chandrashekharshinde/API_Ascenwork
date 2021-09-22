Create PROCEDURE [dbo].[USP_SetupStepCompleteInLogin] --'<Json><ServicesAction>UpdateLoginStepSteps</ServicesAction><LoginId>10621</LoginId><CompletedSetupStep>6</CompletedSetupStep><IsStepCompleted>1</IsStepCompleted></Json>'

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
            DECLARE @LoginId bigint
		

            UPDATE dbo.Login SET     
			@LoginId = tmp.[LoginId],    
			    CompletedSetupStep=tmp.[CompletedSetupStep],
			    IsStepCompleted = tmp.[IsStepCompleted] ,       
			    UpdatedDate  = GETDATE()    
         
            FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [LoginId] bigint,
   [CompletedSetupStep] bigint ,
   [IsStepCompleted] nvarchar(10)
         
            )  tmp WHERE Login.LoginId=tmp.LoginId
			  
             SELECT @LoginId as LoginId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
  END TRY
  BEGIN CATCH
  SELECT @ErrMsg = ERROR_MESSAGE();
  RAISERROR(@ErrMsg, @ErrSeverity, 1);
  RETURN; 
  END CATCH
END


--select LoginId,IsStepCompleted,CompletedSetupStep,UpdatedDate from login where LoginId = 10621

--update login set IsStepCompleted = NULL,CompletedSetupStep=NULL where LoginId = 10621