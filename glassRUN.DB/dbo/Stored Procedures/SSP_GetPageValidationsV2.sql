-- =============================================
-- AUTHOR:		<AUTHOR,,ALOK>
-- CREATE DATE: <MONDAY ,FEBUARY 04,2020,>
-- DESCRIPTION:	<GET GET PAGE Validations>
-- =============================================
Create PROCEDURE [dbo].[SSP_GetPageValidationsV2] 
	-- Add the parameters for the stored procedure here
	 @CompanyId NVARCHAR(100)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 
	 SELECT 
       pc.PageId  
	  ,p.PageName
	  ,'' as PageUrl
	  ,RWLA.RoleId
	  ,RWLA.LoginId
  	   ,sm.SettingValue
	   ,sm.SettingParameter
	  ,pc.[IsActive] 		
  FROM PageControl pc 
  with (NOLOCK)
			 INNER JOIN pages p ON p.PAGEID=PC.PAGEID
   inner JOIN ROLEWISEFIELDACCESS RWLA ON RWLA.PAGEID=PC.PAGEID
     
	left join SettingMaster sm on sm.CompanyId=@CompanyId
   WHERE pc.IsActive = 1  
 
END


 
 
 
