-- =============================================
-- Author:		Vinod
-- Create date: 02-04-2016
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SSP_PasswordHistory_ByCode]-- 2
	-- Add the parameters for the stored procedure here
	@ResetPasswordCode nvarchar(200)
AS
BEGIN

SELECT CAST((SELECT  
		[PasswordHistoryId]
      ,[ProfileId]
      ,[LoginId]
      ,[HashedPassword]
      ,[PasswordSalt]
      ,[PasswordChangedDate]
      ,[PasswordResetBy]
      ,[EmailAddress]
      ,[PhoneNo]
      ,[OneTimePassword]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[CreatedFromIPAddress]
      ,[UpdatedDate]
      ,[UpdatedBy]
      ,[UpdatedFromIPAddress]
      ,[ResetPasswordCode]
 From PasswordHistory Where ResetPasswordCode=@ResetPasswordCode
	    FOR XML RAW('PasswordHistoryList'),ELEMENTS,ROOT('PasswordHistory')) AS XML)

		END
