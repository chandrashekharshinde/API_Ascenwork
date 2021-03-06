-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_SecurityQuestionAnswer_SelectByUserProfileId] 
	-- Add the parameters for the stored procedure here
	@ProfileId NVARCHAR(50)
AS
BEGIN

SELECT CAST((SELECT sq.SecurityQuestionId AS 'SecurityQuestionId',
                    sq.Question AS 'Question',
                    usq.UserSecurityQuestionId AS 'UserSecurityQuestionId' ,
                    usq.ProfileId AS 'ProfileId',
					usq.Answer AS 'Answer' 
					FROM dbo.SecurityQuestion sq INNER JOIN dbo.UserSecurityQuestion usq 
					ON usq.SecurityQuestionId = sq.SecurityQuestionId  WHERE usq.ProfileId=@ProfileId AND  sq.IsActive = 1 AND usq.IsActive=1 and usq.ProfileId=@ProfileId --AND PasswordSalt=@PasswordSalt AND HashedPassword=@HashedPassword
	    FOR XML RAW('SecurityQuestionList'),ELEMENTS,ROOT('SecurityQuestion')) AS XML)

		END
