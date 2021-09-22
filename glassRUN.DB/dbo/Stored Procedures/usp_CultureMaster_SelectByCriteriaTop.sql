-----------------------------------------------------------------
-- SELECT BY CRITERIA Top
-- Date Created: Monday, June 13, 2016
-- Created By:   Manas
-- Procedure to Select entries by custom criteria in the dbo.CultureMaster table.
-----------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_CultureMaster_SelectByCriteriaTop]
@TopNumber nvarchar(10) ='1',
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'CultureMasterId'

AS

--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'CultureMasterId' END

-- ISSUE QUERY
DECLARE @sql nvarchar(4000)

SET @sql = '

SELECT top '+ @TopNumber + ' 
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
	[CultureMaster]
WHERE  IsActive=1  and ' + @WhereExpression + '
ORDER BY ' + @SortExpression

-- Execute the SQL query
EXEC sp_executesql @sql
