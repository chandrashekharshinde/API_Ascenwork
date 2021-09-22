Create PROCEDURE [dbo].[DSP_SecurityQuestion]

@Status INT  OUTPUT,
@SecurityQuestionId nvarchar(1000)

AS

DECLARE @Rowcount INT 
DECLARE @Count INT
    DECLARE @ID NVARCHAR(1000)='SecurityQuestionId='+ @SecurityQuestionId
EXECute CustomDelete '[dbo].[SecurityQuestion]',@ID,@Count output
SET @ROWCOUNT=@Count
SET  @Status =@ROWCOUNT


IF @ROWCOUNT =0
BEGIN
Update
	SecurityQuestion
    SET IsActive=0
WHERE

	[SecurityQuestionId] = @SecurityQuestionId

SET @Status =1
END 

ELSE 
BEGIN
SET @Status =0
END

SELECT @Status AS 'count'
