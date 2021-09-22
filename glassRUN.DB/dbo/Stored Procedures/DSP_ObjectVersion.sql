Create PROCEDURE [dbo].[DSP_ObjectVersion]

@Status INT  OUTPUT,
@objectVersionId nvarchar(1000)

AS

DECLARE @Rowcount INT 
DECLARE @Count INT
    DECLARE @ID NVARCHAR(1000)='ObjectVersionId='+ @objectVersionId
EXECute CustomDelete '[dbo].[ObjectVersion]',@ID,@Count output
SET @ROWCOUNT=@Count
SET  @Status =@ROWCOUNT


IF @ROWCOUNT =0
BEGIN
UPDATE ObjectVersion SET IsActive=0 WHERE ObjectVersionId = @objectVersionId

	UPDATE ObjectVersionDefaults SET IsActive=0 WHERE ObjectVersionId = @objectVersionId

	UPDATE ObjectVersionProperties SET IsActive=0 WHERE ObjectVersionId = @objectVersionId

SET @Status =1
END 

ELSE 
BEGIN
SET @Status =0
END

SELECT @Status AS 'count'
