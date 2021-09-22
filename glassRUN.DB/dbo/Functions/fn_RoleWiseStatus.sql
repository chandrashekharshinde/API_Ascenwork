CREATE FUNCTION [dbo].[fn_RoleWiseStatus]
(@roleid bigint,
@statusId bigint,
@CultureId bigint
)
RETURNS nvarchar(max)
BEGIN
    RETURN (

isnull((select top 1 ResourceValue from RoleWiseStatusView where (RoleId=@roleid or @roleid=0) and StatusId=@statusId and CultureId = @CultureId),'-')

  )
END
