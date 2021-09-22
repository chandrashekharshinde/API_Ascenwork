Create FUNCTION [dbo].[fn_ShortCodeLookupValueById]
(@id int)
RETURNS nvarchar(100)
BEGIN
    RETURN (

SELECT TOP 1 ShortCode FROM dbo.Lookup WHERE LookupID = @id

		)
END
