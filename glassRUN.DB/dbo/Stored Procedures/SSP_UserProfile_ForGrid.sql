CREATE PROCEDURE [dbo].[SSP_UserProfile_ForGrid] --0,10,'',''
@PageIndex INT,
@PageSize INT,
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'u.ProfileId'
AS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END

IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'ProfileId' END
BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
	SET @sql = 'SELECT * FROM (SELECT  u.[ProfileId],
      l.RoleMasterId,
	  r.RoleName,
         [Name],
      [EmailId],
      [ContactNumber],
	  l.[UserName],
      u.[IsActive],
      u.[CreatedDate],
      u.[CreatedBy],
      u.[CreatedFromIPAddress],
      u.[UpdatedDate],
      u.[UpdatedBy],
      u.[UpdatedFromIPAddress]

		   FROM Profile u Inner join Login l on u.ProfileId=l.ProfileId inner join RoleMaster r on l.RoleMasterId = r.RoleMasterId) as BaseInfo
		  
		WHERE ' + @WhereExpression + ' AND IsActive=1  ORDER BY '+@SortExpression+' ASC OFFSET ((' + CONVERT(NVARCHAR(10), @PageIndex) + ' * ' + CONVERT(NVARCHAR(10), @PageSize) + ')) ROWS FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

	PRINT @sql

	EXEC sp_executesql @sql

	SET @sqlTotalCount = 'SELECT  COUNT(*) AS TotalRowCount FROM ( SELECT  u.[ProfileId],
      l.RoleMasterId,
	  r.RoleName,
      [Name],
      [EmailId],
      [ContactNumber],
	  [UserName],
      u.[IsActive],
      u.[CreatedDate],
      u.[CreatedBy],
      u.[CreatedFromIPAddress],
      u.[UpdatedDate],
      u.[UpdatedBy],
      u.[UpdatedFromIPAddress]

		   FROM Profile u Inner join Login l on u.ProfileId=l.ProfileId inner join RoleMaster r on l.RoleMasterId = r.RoleMasterId) as BaseInfo
		  
		WHERE ' + @WhereExpression + ' AND IsActive=1'

	PRINT @sqlTotalCount

	EXEC sp_executesql @sqlTotalCount
END
