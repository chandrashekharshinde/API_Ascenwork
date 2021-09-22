CREATE  PROCEDURE [dbo].[SSP_UserDetailForSendingMail] --10043
@userId BIGINT
AS
BEGIN

SELECT u.UserId,u.Username,u.PasswordSalt,u.HashedPAssword,ud.EmailAddress as UserEmailAddress ,ud.FirstName +' '+ ud.LastName AS UserFullName FROM dbo.Users u JOIN dbo.UserDetails ud ON u.UserId = ud.UserID 
WHERE  u.UserId = @userId
FOR XML RAW('Users'),ELEMENTS

 END
