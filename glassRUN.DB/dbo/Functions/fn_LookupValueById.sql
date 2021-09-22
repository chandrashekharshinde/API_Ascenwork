Create FUNCTION [dbo].[fn_LookupValueById]
(@id int)
RETURNS nvarchar(100)
BEGIN
    RETURN (

SELECT TOP 1 Name FROM dbo.Lookup WHERE LookupID = @id

		)
END
