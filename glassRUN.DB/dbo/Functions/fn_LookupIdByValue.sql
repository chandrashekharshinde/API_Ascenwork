CREATE FUNCTION [dbo].[fn_LookupIdByValue] 
(@code NVARCHAR(100) )
RETURNS BIGINT
BEGIN
    RETURN (

SELECT TOP 1 LookupID FROM dbo.Lookup WHERE Code = @code

		)
END
