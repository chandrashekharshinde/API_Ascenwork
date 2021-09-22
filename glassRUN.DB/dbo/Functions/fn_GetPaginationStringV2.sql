create FUNCTION [dbo].[fn_GetPaginationStringV2]

(@PageSize INT,
@PageIndex INT)

RETURNS nvarchar(max)


BEGIN

declare @PaginationString nvarchar(max)=''

set @PaginationString = '('+CONVERT(NVARCHAR(10), @PageSize)+' = 0 OR tmp.[rownumber] BETWEEN ('+CONVERT(NVARCHAR(10), @PageSize)+' * ('+CONVERT(NVARCHAR(10), @PageIndex)+'-1) + 1)  AND ('+CONVERT(NVARCHAR(10), @PageIndex)+' * '+CONVERT(NVARCHAR(10), @PageSize)+')	)';

return @PaginationString


END
