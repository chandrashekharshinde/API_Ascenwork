CREATE FUNCTION [dbo].[fn_GetListOfItems]
(@skuCode nvarchar(max))
RETURNS nvarchar(max)

BEGIN

declare @S varchar(max)
set @S =@skuCode
DECLARE @value varchar(8000)=''
DECLARE @value1 varchar(8000)=''
while len(@S) > 0
begin
  set @value =Isnull((select convert(nvarchar(max),I.ItemId) from Item I where I.ItemCode in (left(@S, charindex(',', @S+',')-1))),'0')
 if @value='0'
 begin
 set  @value1='0'
 break;
 end 

 if @value1=''
 begin
 set  @value1=@value
 end
 else
  set  @value1=@value1+','+@value


  set @S = stuff(@S, 1, charindex(',', @S+','), '')
end
 return @value1
END
