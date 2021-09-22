CREATE FUNCTION [dbo].[fn_GetPaginationString]

(@PageSize INT,
@PageIndex INT)

RETURNS nvarchar(max)


BEGIN

declare @PaginationString nvarchar(max)=''

set @PaginationString = '('+CONVERT(NVARCHAR(10), @PageSize)+' = 0 OR tmp.[rownumber] BETWEEN ('+CONVERT(NVARCHAR(10), @PageIndex)+')  AND ('+CONVERT(NVARCHAR(10), @PageSize)+'))'

return @PaginationString


END
