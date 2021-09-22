

CREATE View [dbo].[RoleWiseStatusView]    AS
select isnull(r.ResourceValue,rws.ResourceKey) as ResourceValue,rws.RoleId,rws.StatusId,r.CultureId,rws.Class from [dbo].RoleWiseStatus rws left join [dbo].Resources r on rws.ResourceKey=r.ResourceKey