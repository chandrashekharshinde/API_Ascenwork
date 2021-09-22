Create PROCEDURE [dbo].[SSP_Profile_ByProfileId] --1
@profileId BIGINT
AS
BEGIN

	SELECT [ProfileId]
      ,[Name]
      ,[EmailId]
      ,[ContactNumber]
      ,[UserProfilePicture]
      ,[IsActive]
      ,[CreatedDate]
      ,[CreatedBy]
      ,[CreatedFromIPAddress]
      ,[UpdatedDate]
      ,[UpdatedBy]
      ,[UpdatedFromIPAddress]
	FROM [dbo].Profile
	 WHERE (ProfileId=@profileId OR @profileId=0) AND IsActive=1
	FOR XML RAW('Profile'),ELEMENTS
	
	
	
END
