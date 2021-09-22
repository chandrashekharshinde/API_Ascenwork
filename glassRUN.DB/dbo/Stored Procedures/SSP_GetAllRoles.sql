-- =============================================
-- Author:		Vinod
-- Create date: 28/12/2015
-- Description:	SSP_RoleMaster_SelectByPrimaryKey
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetAllRoles] 
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
  FROM [RoleMaster] WHERE IsActive = 1
	    FOR XML RAW('RoleMasterList'),ELEMENTS,ROOT('RoleMaster')) AS XML)

		END
