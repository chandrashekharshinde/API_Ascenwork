-- =============================================
-- Author:		Vinod
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_AllUserDetails] 
	-- Add the parameters for the stored procedure here
	(
@xmlDoc XML
)
AS

DECLARE @intPointer INT;

Declare @profileId bigint
BEGIN
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
	   
	 
	   @profileId = tmp.[ProfileId]
	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ProfileId] bigint
			
			
           
			)tmp;



			 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  SELECT CAST((SELECT u.[ProfileId]
      ,[RoleMasterId]
      ,l.[Name]
      ,[EmailId]
      ,[ContactNumber]
	  ,UserName
      ,u.[IsActive]
      ,u.[CreatedDate]
      ,u.[CreatedBy]
	  ,u.LicenseNumber
	  ,u.DriverId
	  ,u.UserProfilePicture
      ,u.[UpdatedDate]
      ,u.[UpdatedBy]
 FROM dbo.Profile u  Inner Join Login l On u.ProfileId = l.ProfileId WHERE u.IsActive = 1 and l.IsActive = 1 and u.ProfileId =@profileId
	    FOR XML RAW('ProfileList'),ELEMENTS,ROOT('Profile')) AS XML)


		END