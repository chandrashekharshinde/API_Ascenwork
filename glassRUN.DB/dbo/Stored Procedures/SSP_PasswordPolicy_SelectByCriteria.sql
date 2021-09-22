CREATE PROCEDURE [dbo].[SSP_PasswordPolicy_SelectByCriteria] --0,10,'',''
@PageIndex INT,
@PageSize INT,
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'PassworPolicyId'
AS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END

IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'PasswordPolicyId' END
BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
	SET @sql = 'SELECT * FROM (SELECT 
		r.RoleMasterId,
	  r.RoleName,
      p.[PasswordPolicyId]
      ,[PasswordPolicyName]
      ,[IsUpperCaseAllowed]
      ,[IsLowerCaseAllowed]
      ,[IsNumberAllowed]
      ,[IsSpecialCharacterAllowed]
      ,[SpecialCharactersToBeExcluded]
      ,[MinimumUppercaseCharactersRequired]
      ,[MinimumLowercaseCharactersRequired]
      ,[MinimumSpecialCharactersRequired]
      ,[MinimumNumericsRequired]
      ,[PasswordExpiryPeriod]
      ,[NewPasswordShouldNotMatchNoOfLastPassword]
      ,[MinimumPasswordLength]
      ,[MaximumPasswordLength]
      ,[CanPasswordBeSameAsUserName]
      ,[NumberOfSecurityQuestionsForRegistration]
      ,[NumberOfSecurityQuestionsForRecovery]
      ,[OneTimePasswordExpireTime]
      ,p.[IsActive]


		   FROM [PasswordPolicy]  p inner Join RolePasswordPolicyMapping rpm on rpm.PasswordPolicyId=p.PasswordPolicyId inner join RoleMaster r on r.RoleMasterId=rpm.RoleMasterId) as BaseInfo

		WHERE ' + @WhereExpression + ' AND IsActive=1 ORDER BY '+@SortExpression+' ASC OFFSET ((' + CONVERT(NVARCHAR(10), @PageIndex) + ' * ' + CONVERT(NVARCHAR(10), @PageSize) + ')) ROWS FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

	PRINT @sql

	EXEC sp_executesql @sql

	SET @sqlTotalCount = 'SELECT  COUNT(*) AS TotalRowCount FROM (SELECT 
		r.RoleMasterId,
	  r.RoleName,
      p.[PasswordPolicyId]
      ,[PasswordPolicyName]
      ,[IsUpperCaseAllowed]
      ,[IsLowerCaseAllowed]
      ,[IsNumberAllowed]
      ,[IsSpecialCharacterAllowed]
      ,[SpecialCharactersToBeExcluded]
      ,[MinimumUppercaseCharactersRequired]
      ,[MinimumLowercaseCharactersRequired]
      ,[MinimumSpecialCharactersRequired]
      ,[MinimumNumericsRequired]
      ,[PasswordExpiryPeriod]
      ,[NewPasswordShouldNotMatchNoOfLastPassword]
      ,[MinimumPasswordLength]
      ,[MaximumPasswordLength]
      ,[CanPasswordBeSameAsUserName]
      ,[NumberOfSecurityQuestionsForRegistration]
      ,[NumberOfSecurityQuestionsForRecovery]
      ,[OneTimePasswordExpireTime]
      ,p.[IsActive]


		   FROM [PasswordPolicy] p inner Join RolePasswordPolicyMapping rpm on rpm.PasswordPolicyId=p.PasswordPolicyId inner join RoleMaster r on r.RoleMasterId=rpm.RoleMasterId) as BaseInfo
		WHERE ' + @WhereExpression + ' AND IsActive=1'

	PRINT @sqlTotalCount

	EXEC sp_executesql @sqlTotalCount
END
