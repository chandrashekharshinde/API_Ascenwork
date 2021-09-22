-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_RoleMaster_SelectAll] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT  'true' AS [@json:Array], [RoleMasterId]
      ,[RoleName]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[CreatedFromIPAddress]
      ,[UpdatedDate]
      ,[UpdatedBy]
      ,[UpdatedFromIPAddress]

		   FROM RoleMaster   WHERE IsActive = 1-- and RoleMasterId=@RoleMasterId 
	    FOR XML path('RoleMasterList'),ELEMENTS,ROOT('Json')) AS XML)

		END