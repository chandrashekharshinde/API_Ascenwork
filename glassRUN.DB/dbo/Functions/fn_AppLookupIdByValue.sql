CREATE FUNCTION [dbo].[fn_AppLookupIdByValue] 
(@code NVARCHAR(100) )
RETURNS BIGINT
BEGIN
    RETURN (

SELECT TOP 1 LookupID FROM dbo.Applookup WHERE Code = @code

		)
END
