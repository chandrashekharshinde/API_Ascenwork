Create FUNCTION [dbo].[DMYTOJUL]  ( @DDATE AS DATETIME )
RETURNS FLOAT AS
BEGIN
-- BY NDQUANG
-- NORMAL DATE TO JULIAN DATE
RETURN (year(@DDATE)-1900)*1000 + datediff(d, cast('01/01/'+ cast(year(@DDATE)as varchar) as smalldatetime), @DDATE)+1

END
