CREATE FUNCTION [dbo].[fn_GetItemSearchText]
(@SearchText nvarchar(max))
RETURNS nvarchar(100)
BEGIN
DECLARE @siteIds VARCHAR(255)
DECLARE @strngLen int
DECLARE @split TABLE(siteId VARCHAR(100))

SET @SearchText=LTRIM(RTRIM(@SearchText))

SET @siteIds = @SearchText

SET @strngLen = CHARINDEX(' ', @siteIds)

WHILE CHARINDEX(' ', @siteIds) > 0
BEGIN
    SET @strngLen = CHARINDEX(' ', @siteIds);

    INSERT INTO @split
    SELECT SUBSTRING(@siteIds,1,@strngLen - 1);

    SET @siteIds = SUBSTRING(@siteIds, @strngLen + 1, LEN(@siteIds));
END

INSERT INTO @split
SELECT @siteIds

DECLARE @categories varchar(200)
SET @categories = NULL
SELECT @categories = COALESCE(@categories + ' ','') + '"*'+siteId+'*"'
FROM @split

Set @categories=REPLACE(@categories,' ',' and ')
return @categories
END
