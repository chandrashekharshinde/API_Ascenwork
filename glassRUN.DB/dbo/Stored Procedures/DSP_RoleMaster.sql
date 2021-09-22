CREATE PROCEDURE [dbo].[DSP_RoleMaster]

@Status INT  OUTPUT,
@RoleMasterId nvarchar(1000)

AS

DECLARE @Rowcount INT 
DECLARE @Count INT
    DECLARE @ID NVARCHAR(1000)='RoleMasterId='+ @RoleMasterId
EXECute CustomDelete '[dbo].[RoleMaster]',@ID,@Count output
SET @ROWCOUNT=@Count
SET  @Status =@ROWCOUNT


IF @ROWCOUNT =0
BEGIN
Update
	RoleMaster
    SET IsActive=0
WHERE

	RoleMasterId = @RoleMasterId

SET @Status =1
END 

ELSE 
BEGIN
SET @Status =0
END

SELECT @Status AS 'count'
