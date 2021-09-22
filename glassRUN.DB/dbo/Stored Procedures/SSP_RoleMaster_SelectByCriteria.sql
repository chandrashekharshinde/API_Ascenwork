CREATE PROCEDURE [dbo].[SSP_RoleMaster_SelectByCriteria] --0,10,'',''
@PageIndex INT,
@PageSize INT,
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'RoleMasterId'
AS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END

IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'RoleMasterId' END
BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
	SET @sql = 'SELECT * FROM (SELECT RoleMasterId,
	  RoleName,
      [IsActive],
      [CreatedDate],
      [CreatedBy],
      [CreatedFromIPAddress],
      [UpdatedDate],
      [UpdatedBy],
      [UpdatedFromIPAddress]

		   FROM RoleMaster ) as BaseInfo
		  
		WHERE ' + @WhereExpression + ' AND IsActive=1 ORDER BY '+@SortExpression+' ASC OFFSET ((' + CONVERT(NVARCHAR(10), @PageIndex) + ' * ' + CONVERT(NVARCHAR(10), @PageSize) + ')) ROWS FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

	PRINT @sql

	EXEC sp_executesql @sql

	SET @sqlTotalCount = 'SELECT  COUNT(*) AS TotalRowCount FROM ( SELECT  RoleMasterId,
	  RoleName,
      [IsActive],
      [CreatedDate],
      [CreatedBy],
      [CreatedFromIPAddress],
      [UpdatedDate],
      [UpdatedBy],
      [UpdatedFromIPAddress]

		   FROM RoleMaster ) as BaseInfo
		WHERE ' + @WhereExpression + ' AND IsActive=1'

	PRINT @sqlTotalCount

	EXEC sp_executesql @sqlTotalCount
END
