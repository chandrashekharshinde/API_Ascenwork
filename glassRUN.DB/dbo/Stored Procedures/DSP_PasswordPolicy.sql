Create PROCEDURE [dbo].[DSP_PasswordPolicy]

@Status INT  OUTPUT,
@PasswordPolicyId nvarchar(1000),
@RolePasswordPolicyMappingId nvarchar(1000)


AS

DECLARE @Rowcount INT 
DECLARE @Count INT
    DECLARE @ID NVARCHAR(1000)='PasswordPolicyId='+ @PasswordPolicyId
EXECute CustomDelete '[dbo].[PasswordPolicy]',@ID,@Count output
SET @ROWCOUNT=@Count
SET  @Status =@ROWCOUNT


IF @ROWCOUNT =0
BEGIN
Update
	[PasswordPolicy]
    SET IsActive=0
WHERE

	PasswordPolicyId = @PasswordPolicyId

	Update
	RolePasswordPolicyMapping
    SET IsActive=0
WHERE

	RolePasswordPolicyMappingId = @RolePasswordPolicyMappingId

SET @Status =1
END 

ELSE 
BEGIN
SET @Status =0
END

SELECT @Status AS 'count'
