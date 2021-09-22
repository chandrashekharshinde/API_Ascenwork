-- =============================================
-- Author:		Vinod
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_UserProfile_SelectByEmailAndPhone] 
	-- Add the parameters for the stored procedure here
	@Email nvarchar(250),
	@PhoneNo nvarchar(50),
	@userName nvarchar(50)
AS
BEGIN

--SELECT CAST((SELECT p.[ProfileId]
--      ,l.[Name]
--      ,[EmailId]
--      ,[ContactNumber]
--      ,p.[IsActive]
--      ,p.[CreatedDate]
--      ,p.[CreatedBy]
--	  ,l.UserName
--      ,p.[UpdatedDate]
--      ,p.[UpdatedBy]
-- FROM dbo.[Profile] p inner join Login l on l.ProfileId=p.ProfileId WHERE p.IsActive = 1 and p.EmailId=@Email OR  p.ContactNumber=@PhoneNo OR l.UserName=@userName
--	    FOR XML RAW('ProfileList'),ELEMENTS,ROOT('Profile')) AS XML)

SELECT CAST((
SELECT l.LoginId As [ProfileId]
      ,c.ContactPerson As [Name]
      ,c.Contacts AS [EmailId]
      --,[ContactNumber]
      ,l.[IsActive]
      ,l.[CreatedDate]
      ,l.[CreatedBy]
	  ,l.UserName
 FROM dbo.[Login] l inner join ContactInformation c on c.ObjectId=l.LoginId and c.ObjectType = 'Login' and c.ContactType = 'Email' 
 WHERE l.IsActive = 1 and l.UserName=@userName
	    FOR XML RAW('ProfileList'),ELEMENTS,ROOT('Profile')) AS XML)

		END