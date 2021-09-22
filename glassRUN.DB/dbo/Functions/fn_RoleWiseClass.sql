CREATE FUNCTION [dbo].[fn_RoleWiseClass]
(@roleid bigint,
@statusId bigint
)
RETURNS nvarchar(max)
BEGIN
    RETURN (

isnull((select top 1 rws.Class from RoleWiseStatus rws join Resources r on rws.ResourceKey=r.ResourceKey where rws.RoleId=@roleid and rws.StatusId=@statusId),'')

		)
END
