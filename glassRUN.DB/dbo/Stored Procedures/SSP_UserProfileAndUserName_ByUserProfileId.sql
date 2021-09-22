-- =============================================
-- Author:		Vinod
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_UserProfileAndUserName_ByUserProfileId] 
	-- Add the parameters for the stored procedure here
	@ProfileId bigint
AS
BEGIN

SELECT CAST((SELECT u.[ProfileId]
      ,[RoleMasterId]
      ,l.[Name]
      ,[EmailId]
      ,[ContactNumber]
	  ,UserName
      ,u.[IsActive]
      ,u.[CreatedDate]
      ,u.[CreatedBy]

      ,u.[UpdatedDate]
      ,u.[UpdatedBy]
 FROM dbo.Profile u  Inner Join Login l On u.ProfileId = l.ProfileId WHERE u.IsActive = 1 and l.IsActive = 1 and u.ProfileId =@ProfileId
	    FOR XML RAW('ProfileList'),ELEMENTS,ROOT('Profile')) AS XML)

		END