-- =============================================
-- author:		<author,,alok>
-- create date: <monday ,january 28,2020,>
-- description:	<get languageresources ,>
-- =============================================
CREATE procedure [dbo].[SSP_GetLanguageResourcesV2]
	-- add the parameters for the stored procedure here
	 
as
begin
	-- set nocount on added to prevent extra result sets from
	-- interfering with select statements.
	set nocount on;

    -- select statements for procedure here
		select resourceid,cultureid 
							,pagename
							,resourcetype
							,resourcekey
							,resourcevalue
							,isapp
							, versionno from resources  with (nolock) where isactive=1
	 
end
