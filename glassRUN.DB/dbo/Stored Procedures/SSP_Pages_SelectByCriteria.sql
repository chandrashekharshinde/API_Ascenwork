CREATE PROCEDURE [dbo].[SSP_Pages_SelectByCriteria]
(
@PageIndex INT,
@PageSize INT,
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'PageId'
)
AS

IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END

IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'PageId' END

BEGIN

Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)

	SET @sql = 'SELECT * FROM  dbo.Pages		  
		WHERE ' + @WhereExpression + ' ORDER BY '+@SortExpression+' ASC OFFSET ((' + CONVERT(NVARCHAR(10), @PageIndex) + ' * ' + CONVERT(NVARCHAR(10), @PageSize) + ')) ROWS FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

	PRINT @sql

	EXEC sp_executesql @sql

	SET @sqlTotalCount = 'SELECT Count(*) as TotalRowCount FROM  dbo.Pages
		WHERE ' + @WhereExpression + ' '

	PRINT @sqlTotalCount

	EXEC sp_executesql @sqlTotalCount
END
