﻿CREATE  FUNCTION [dbo].[JULTODMY]  ( @JDATE AS float)
RETURNS DATETIME AS
BEGIN
set @JDATE=isnull(@JDATE,0)

RETURN  CONVERT(DATETIME, 
CONVERT(CHAR(4), convert(int,@JDATE) /1000 + 1900  )+'-'+ 

LTRIM(RTRIM(CONVERT(CHAR(2), datePART(month,dateadd(day,CONVERT(INT,RIGHT(RTRIM(LTRIM(@JDATE)),3))- 1,'01-01-'+convert(char,CONVERT(INT,@JDATE)/1000 + 1900)) ))))+ '-' + 

LTRIM(RTRIM(datename(day,dateadd(day,CONVERT(INT,RIGHT(RTRIM(LTRIM(@JDATE)),3))- 1,'01-01-'+convert(char,CONVERT(INT,@JDATE)/1000 + 1900)) ))))

END
