CREATE PROCEDURE [dbo].[SSP_SecurityQuestion_SelectByCriteria] --0,10,'',''
@PageIndex INT,
@PageSize INT,
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'SecurityQuestionId'
AS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END

IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'SecurityQuestionId' END
BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
	SET @sql = 'SELECT * FROM (SELECT  s.[SecurityQuestionId],
		r.RoleMasterId,
		RoleSecurityQuestionMappingId,
		r.RoleName
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
      ,s.[IsActive]


		   FROM SecurityQuestion s Inner join [RoleSecurityQuestionMapping] l on s.SecurityQuestionId=l.SecurityQuestionId inner join RoleMaster r on l.RoleMasterId = r.RoleMasterId)as BaseInfo
		  
		WHERE ' + @WhereExpression + ' AND IsActive=1  ORDER BY '+@SortExpression+' ASC OFFSET ((' + CONVERT(NVARCHAR(10), @PageIndex) + ' * ' + CONVERT(NVARCHAR(10), @PageSize) + ')) ROWS FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

	PRINT @sql

	EXEC sp_executesql @sql

	SET @sqlTotalCount = 'SELECT  COUNT(*) AS TotalRowCount FROM (SELECT  s.[SecurityQuestionId]
		RoleMasterId,
		RoleSecurityQuestionMappingId,
	r.RoleName
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
      ,s.[IsActive]

 FROM SecurityQuestion s Inner join [RoleSecurityQuestionMapping] l on s.SecurityQuestionId=l.SecurityQuestionId inner join RoleMaster r on l.RoleMasterId = r.RoleMasterId)as BaseInfo
 WHERE ' + @WhereExpression + ' AND IsActive=1 '

	PRINT @sqlTotalCount

	EXEC sp_executesql @sqlTotalCount
END
