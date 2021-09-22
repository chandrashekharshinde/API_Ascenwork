-----------------------------------------------------------------
-- SELECT PAGED
-- Date Created: Monday, June 13, 2016
-- Created By:   Manas
-- Procedure to Select Paged entries in the dbo.CultureMaster table.
-----------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_CultureMaster_SelectPaged]

@PageIndex int,
@PageSize int,
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'CultureMasterId'

AS

--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'CultureMasterId' END

-- ISSUE QUERY
DECLARE @sql nvarchar(4000)

SET @sql = '

SELECT
	[CultureMasterId],
	[CultureName],
	[CultureCode],
	[Description],
	[Active],
	[CreatedBy],
	[CreatedDate],
	[UpdatedBy],
	[UpdatedDate]
FROM
   (
	SELECT
		[CultureMasterId],
		[CultureName],
		[CultureCode],
		[Description],
		[Active],
		[CreatedBy],
		[CreatedDate],
		[UpdatedBy],
		[UpdatedDate],
        ROW_NUMBER() OVER(ORDER BY ' + @SortExpression + ') as RowNum
    FROM
		[CultureMaster]
	WHERE IsActive=1  and
		' + @WhereExpression + '
	) as BaseInfo
WHERE  IsActive=1  and
	RowNum BETWEEN ' + CONVERT(nvarchar(10), (@PageIndex * @PageSize) - @PageSize + 1) + 
            ' AND (' + CONVERT(nvarchar(10), (@PageIndex * @PageSize) - @PageSize) + ' + ' 
            + CONVERT(nvarchar(10), @PageSize) + ')

--GET THE TOTAL ROW COUNT
SELECT Count(CultureMasterId) AS TotalRows FROM [CultureMaster] WHERE  IsActive=1  and ' + @WhereExpression + '
'

-- Execute the SQL query
EXEC sp_executesql @sql
