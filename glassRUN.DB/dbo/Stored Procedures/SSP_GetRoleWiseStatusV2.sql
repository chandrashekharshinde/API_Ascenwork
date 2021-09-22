-- =============================================
-- AUTHOR:		<AUTHOR,,ALOK>
-- CREATE DATE: <Tuesday ,Febuary 04,2020,>
-- DESCRIPTION:	<GET LOOKUP DETAILS ,>
-- =============================================
Create PROCEDURE [dbo].[SSP_GetRoleWiseStatusV2]
	@RoleId bigint,
	@CultureId bigint
AS
BEGIN
	

   select  rws.Class ,r.ResourceValue,Rwsv.StatusId
   from RoleWiseStatusView Rwsv join RoleWiseStatus rws  on Rwsv.Roleid=rws.RoleId and Rwsv.StatusId=rws.StatusId
   join Resources r
    on rws.ResourceKey=r.ResourceKey  where rws.RoleId=@roleid  and r.CultureId = @CultureId
	 
END