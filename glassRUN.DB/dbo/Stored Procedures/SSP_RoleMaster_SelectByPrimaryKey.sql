-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_RoleMaster_SelectByPrimaryKey] 
	-- Add the parameters for the stored procedure here
	@RoleMasterId INT
AS
BEGIN

SELECT CAST((SELECT  [RoleMasterId]
      ,[RoleName]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[CreatedFromIPAddress]
      ,[UpdatedDate]
      ,[UpdatedBy]
      ,[UpdatedFromIPAddress]

		   FROM RoleMaster   WHERE IsActive = 1 and RoleMasterId=@RoleMasterId 
	    FOR XML RAW('RoleMasterList'),ELEMENTS,ROOT('RoleMaster')) AS XML)

		END
