CREATE FUNCTION [dbo].[fn_GetUserAndDimensionAndPageWiseWhereClause]
(@userId bigint,
@pageName nvarchar(250)
)
RETURNS nvarchar(max)


BEGIN

Declare @ReturnValue nvarchar(max)=''
Declare @temTable table(
Id INT IDENTITY(1,1) PRIMARY KEY,
TextValue Nvarchar(500),
PageNameValue nvarchar(500)

)


declare @roleId bigint


set @roleId = (select RoleMasterId  From Login  where LoginId=@userId)



 insert into @temTable
	(
		
		TextValue,
		PageNameValue
	)
select distinct
	
	 dsm.DimensionName,
	 dsm.PageName
FROM DimensionSPMapping dsm join UserDimensionMapping udm on udm.DimensionName=dsm.DimensionName where dsm.IsActive=1 and udm.IsActive=1 and dsm.PageName=@pageName and (udm.UserId= @userId  or udm.rolemasterid=@roleId)




DECLARE @ID bigint=1
WHILE @ID <= (SELECT Count(Id) FROM @temTable)
begin 


----insert   data for IN opertor Type
declare @InCount bigint

set   @InCount =(SELECT count(*) FROM UserDimensionMapping udm   join  @temTable  d on d.TextValue  =udm.DimensionName  and  d.Id = @ID
where udm.DimensionName=TextValue  and udm.PageName = PageNameValue and  udm.IsActive=1 and    udm.OperatorType=1  and  (udm.UserId= @userId  or udm.rolemasterid=@roleId) )



if(@InCount > 0)
begin

select  @ReturnValue = @ReturnValue+ ' And '+TextValue+' in ('+ IsNull(
	(select
STUFF((SELECT ','''+udm.DimensionValue+''''
FROM UserDimensionMapping udm 
where udm.DimensionName=TextValue  and udm.PageName = PageNameValue and  udm.IsActive=1 and    udm.OperatorType=1  and  (udm.UserId= @userId  or udm.rolemasterid=@roleId)
 FOR XML PATH(''), TYPE).value('.','nvarchar(max)'), 1, 1, ''))
	,'')+')'
	from @temTable where Id=@ID

end

----insert   data for NOT IN opertor Type
declare @NotInCount bigint

set   @NotInCount =(SELECT count(*) FROM UserDimensionMapping udm   join  @temTable d on d.TextValue  =udm.DimensionName  and  d.Id = @ID
where udm.DimensionName=TextValue  and udm.PageName = PageNameValue and  udm.IsActive=1 and    udm.OperatorType=0  and  (udm.UserId= @userId  or udm.rolemasterid=@roleId)  )



if(@NotInCount > 0)
begin

select  @ReturnValue = @ReturnValue+ ' And '+TextValue+' not in ('+ IsNull(
	(select
STUFF((SELECT ','''+udm.DimensionValue+''''
FROM UserDimensionMapping udm 
where udm.DimensionName=TextValue  and udm.PageName = PageNameValue and  udm.IsActive=1 and    udm.OperatorType=0  and  (udm.UserId= @userId  or udm.rolemasterid=@roleId)
 FOR XML PATH(''), TYPE).value('.','nvarchar(max)'), 1, 1, ''))
	,'')+')'
	from @temTable where Id=@ID

end



	


	SET @ID = @ID + 1
end






return isnull(@ReturnValue,'')
End