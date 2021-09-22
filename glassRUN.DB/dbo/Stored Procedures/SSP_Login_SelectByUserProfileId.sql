-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_Login_SelectByUserProfileId] 
	-- Add the parameters for the stored procedure here
	@ProfileId NVARCHAR(500)
	--@PasswordSalt INT,
	--@HashedPassword NVARCHAR(100)
AS
BEGIN

SELECT CAST((SELECT LoginId ,
       ProfileId ,
       UserName ,
       HashedPassword ,
       PasswordSalt ,
       LoginAttempts ,
       AccessKey ,
       LastLogin ,
       ExpiryDate ,
       LastPasswordChange ,
       ChangePasswordonFirstLoginRequired ,
       IsActive ,
       CreatedDate ,
       CreatedBy ,
       CreatedFromIPAddress ,
       UpdatedDate ,
	   GUID,
       UpdatedBy ,
	   	   RoleMasterId,
       UpdatedFromIPAddress FROM dbo.Login WHERE IsActive = 1 and GUID=@ProfileId --AND PasswordSalt=@PasswordSalt AND HashedPassword=@HashedPassword
	    FOR XML RAW('LoginList'),ELEMENTS,ROOT('Login')) AS XML)

		END