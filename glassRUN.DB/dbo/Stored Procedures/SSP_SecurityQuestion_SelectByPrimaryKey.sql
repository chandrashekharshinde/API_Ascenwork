-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
cREATE PROCEDURE [dbo].[SSP_SecurityQuestion_SelectByPrimaryKey] 
	-- Add the parameters for the stored procedure here
	@SecurityQuestionId INT
AS
BEGIN

SELECT CAST((SELECT  [SecurityQuestionId]
      ,[Question]
      ,[IsUpperCaseAllowed]
      ,[IsLowerCaseAllowed]
      ,[IsNumberAllowed]
      ,[IsSpecialCharacterAllowed]
      ,[SpecialCharactersToBeExcluded]
      ,[MinimumUppercaseCharactersRequired]
      ,[MinimumLowercaseCharactersRequired]
      ,[MinimumSpecialCharactersRequired]
      ,[MinimumNumericsRequired]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[CreatedFromIPAddress]
      ,[UpdatedDate]
      ,[UpdatedBy]
      ,[UpdatedFromIPAddress]

		   FROM SecurityQuestion   WHERE IsActive = 1 and SecurityQuestionId=@SecurityQuestionId 
	    FOR XML RAW('SecurityQuestionList'),ELEMENTS,ROOT('SecurityQuestion')) AS XML)

		END
