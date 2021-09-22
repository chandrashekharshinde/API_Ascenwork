-- =============================================
-- AUTHOR:		<AUTHOR,,ALOK>
-- CREATE DATE: <MONDAY ,FEBUARY 03,2020,>
-- DESCRIPTION:	<GET GET PAGE CONTROLS>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetPageControlsV2]
	-- ADD THE PARAMETERS FOR THE STORED PROCEDURE HERE
	 @Roleid NVARCHAR(100)
AS
BEGIN

  
	-- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING WITH SELECT STATEMENTS.
	SET NOCOUNT ON;

    -- SELECT STATEMENTS FOR PROCEDURE HERE
	SELECT    ps.sortingparametersid
			 ,pc.[controlname]
			 ,pc.[resourcekey]     
			 ,rwla.accessid
			 ,pc.[datasource]
			 ,rwla.roleid
			 ,rwla.loginid
			 , '' as PageName
			 ,'' As PageUrl
			 ,pc.ismandatory
			 ,pc.validationexpression
			 ,pc.[controltype]
  FROM [DBO].[PAGECONTROL] PC  WITH (NOLOCK)
			 left join pagesortingmapping ps  WITH (NOLOCK) on ps.pageid=pc.pageid   
			 left join rolewisefieldaccess rwla  WITH (NOLOCK)  on rwla.pageid=pc.pageid 			  
			 where rwla.RoleId=@Roleid and pc.isactive=1
			  
END
