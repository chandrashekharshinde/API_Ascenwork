-- =============================================
-- AUTHOR:		<AUTHOR,,ALOK>
-- CREATE DATE: <Tuesday ,Febuary 04,2020,>
-- DESCRIPTION:	<GET LOOKUP DETAILS ,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetCultureConfigurationsV2]
	-- Add the parameters for the stored procedure here
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT [CultureMasterId]
      ,[CultureName]
      ,[CultureCode]
      ,[Description]
      ,[Active]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
	  ,CompanyId
  FROM [dbo].[CultureMaster]  with (NOLOCK) where [Active]=1
	 
END