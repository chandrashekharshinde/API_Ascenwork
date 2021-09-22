Create PROCEDURE [dbo].[ISP_Resource]
@CultureId int,
@PageName nvarchar(max) ,
@ResourceType nvarchar(max) ,
@ResourceKey nvarchar(max) ,
@ResourceValue nvarchar(max) ,
@VersionNo nvarchar(max) ,
@IsActive bit
AS 
 BEGIN 
Declare @ResourceCount bigint=0


select @ResourceCount=count(ResourceId) from Resources where ResourceKey=@ResourceKey and PageName=@PageName  

if @ResourceCount =0 
begin

INSERT INTO [dbo].[Resources]([CultureId],[PageName],[ResourceType],[ResourceKey],[ResourceValue],[VersionNo],[IsActive]) VALUES(@CultureId,@PageName,@ResourceType,@ResourceKey,@ResourceValue,@VersionNo,@IsActive)

end
else
begin

select ResourceKey= @ResourceKey ,PageName=@PageName  from Resources where ResourceKey=@ResourceKey and PageName=@PageName  
Update [dbo].[Resources] set [ResourceValue]=@ResourceValue where ResourceKey=@ResourceKey and PageName=@PageName 

end
END
