CREATE PROCEDURE [dbo].[DSP_UserProfile]

@Status INT  OUTPUT,
@UserProfileId nvarchar(1000)

AS

DECLARE @Rowcount INT 
DECLARE @Count INT
    DECLARE @ID NVARCHAR(1000)='UserProfileId='+ @UserProfileId
EXECute CustomDelete '[dbo].[UserProfile]',@ID,@Count output
SET @ROWCOUNT=@Count
SET  @Status =@ROWCOUNT


IF @ROWCOUNT =0
BEGIN
Update
	UserProfile
    SET IsActive=0
WHERE

	ProfileId = @UserProfileId

	Update
	[Login]
    SET IsActive=0
WHERE

	ProfileId = @UserProfileId

SET @Status =1
END 

ELSE 
BEGIN
SET @Status =0
END

SELECT @Status AS 'count'
