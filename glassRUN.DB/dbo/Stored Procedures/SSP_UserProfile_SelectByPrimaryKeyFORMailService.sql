
-- Server : BITPL-PC7 -- 

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_UserProfile_SelectByPrimaryKeyFORMailService] --227,'PR'
	-- Add the parameters for the stored procedure here
	@ProfileId INT
	,@EventType nvarchar(150)
AS
BEGIN


SELECT CAST((SELECT  p.[ProfileId]
      ,l.[Name]    
	  
      ,[EmailId]
	 ,UserName
      ,[ContactNumber]
      ,en.[Password] as 'Password'
	  ,HashedPassword
	    ,p.[CreatedBy]
      ,p.[CreatedDate]
  FROM [Profile] p Left join Login l on l.ProfileId =p.ProfileId
  LEFT JOIN EmailNotification en ON p.ProfileId= en.ObjectId WHERE p.IsActive = 1 and p.ProfileId=@ProfileId AND en.IsSent=0 And EventType=@EventType
	    FOR XML RAW('ProfileList'),ELEMENTS,ROOT('Profile')) AS XML)

		END