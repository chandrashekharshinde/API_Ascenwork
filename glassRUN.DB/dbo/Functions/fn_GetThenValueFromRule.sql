

Create FUNCTION [dbo].[fn_GetThenValueFromRule] 
(@ThenVlaue nvarchar(max))
RETURNS nvarchar(max)
BEGIN
 Declare @finalOuptput nvarchar(max)

set @ThenVlaue=REPLACE(@ThenVlaue,'''','')
set @ThenVlaue=REPLACE(@ThenVlaue,'{','')
set @ThenVlaue=REPLACE(@ThenVlaue,'}','')


 DECLARE @Text VARCHAR(MAX), @First VARCHAR(MAX), @Second VARCHAR(MAX)
SET @Text = @ThenVlaue
SET @First = '('
SET @Second = ')'

SELECT @finalOuptput=SUBSTRING(@Text, CHARINDEX(@First, @Text), CHARINDEX(@Second, @Text) - CHARINDEX(@First, @Text) + LEN(@Second))

Set @finalOuptput=REPLACE(@finalOuptput,'(','')
Set @finalOuptput=REPLACE(@finalOuptput,')','')
Set @finalOuptput=LTRIM(@finalOuptput)
Set @finalOuptput=RTRIM(@finalOuptput)

 Return @finalOuptput
END