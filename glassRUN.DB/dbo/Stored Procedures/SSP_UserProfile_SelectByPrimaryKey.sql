-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_UserProfile_SelectByPrimaryKey] --98
	-- Add the parameters for the stored procedure here
	@ProfileId nvarchar(250)
AS
BEGIN

--SELECT CAST((SELECT  p.[ProfileId]
--      ,l.[Name]
--      ,[EmailId]
--	  ,l.PasswordSalt
--	  ,l.HashedPassword
--      ,[ContactNumber]
--      ,p.[IsActive]
--      ,p.[CreatedDate]
--      ,p.[CreatedBy]
--      ,p.[UpdatedDate]
--      ,p.[UpdatedBy]

--  FROM [Profile] p inner join Login l on l.ProfileId=p.ProfileId WHERE p.IsActive = 1 and p.ProfileId=@ProfileId 
--	    FOR XML RAW('ProfileList'),ELEMENTS,ROOT('Profile')) AS XML)

SELECT CAST((SELECT l.LoginId As [ProfileId]
      ,c.ContactPerson As [Name]
      ,c.Contacts AS [EmailId]
      ,l.PasswordSalt
	  ,l.HashedPassword
      ,l.[IsActive]
      ,l.[CreatedDate]
      ,l.[CreatedBy]
	  ,l.UserName
	  ,l.[GUID]
 FROM dbo.[Login] l inner join ContactInformation c on c.ObjectId=l.LoginId and c.ObjectType = 'Login' and c.ContactType = 'Email' 
 WHERE l.IsActive = 1 and l.[GUID]=@ProfileId
	    FOR XML RAW('ProfileList'),ELEMENTS,ROOT('Profile')) AS XML)

		END