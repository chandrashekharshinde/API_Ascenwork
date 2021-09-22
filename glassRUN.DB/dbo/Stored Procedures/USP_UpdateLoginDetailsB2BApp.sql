CREATE PROCEDURE [dbo].[USP_UpdateLoginDetailsB2BApp] 
@xmlDoc XML 
AS 
BEGIN 
SET arithabort ON 

DECLARE @ErrMsg NVARCHAR(2048) 
DECLARE @ErrSeverity INT; 
DECLARE @intPointer INT; 

Declare @LoginId bigint;

SET @ErrSeverity = 15; 

BEGIN try 
EXEC Sp_xml_preparedocument 
@intpointer output, 
@xmlDoc 

		Update [Login] 
		set @LoginId=tmp.[LoginId],
		[CompletedSetupStep] = tmp.[CompletedSetupStep],
		[IsStepCompleted] = tmp.[IsStepCompleted],
		UpdatedBy = tmp.[UpdatedBy],
		UpdatedDate = GETDATE() 
		FROM OPENXML(@intpointer,'Json/LoginDetailsList',2)
		WITH
		(
		[LoginId] bigint,
		[CompletedSetupStep] int,
		[IsStepCompleted] bit,
		[UpdatedBy] bigint
		)tmp WHERE [Login].[LoginId]=tmp.[LoginId];
					 
		
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array],
@LoginId AS LoginId ,'Success' as Status
FOR XML path('ServicesAction'),ELEMENTS,ROOT('Json')) AS XML)

EXEC Sp_xml_removedocument 
@intPointer 
END try 

BEGIN catch 
SELECT @ErrMsg = Error_message(); 
RAISERROR(@ErrMsg,@ErrSeverity,1); 

RETURN; 
END catch 
END