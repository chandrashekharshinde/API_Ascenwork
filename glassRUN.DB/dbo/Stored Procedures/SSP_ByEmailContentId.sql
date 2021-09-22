
CREATE PROCEDURE [dbo].[SSP_ByEmailContentId] --0
@emailContentId BIGINT
AS


	SELECT [EmailContentId]
      ,[SupplierId]
      ,[CompanyId]
      ,[EmailEventId]
      ,[Subject]
      ,[EmailHeader]
      ,[EmailBody]
      ,[EmailFooter]
      ,[CCEmailAddress]	
      ,[UserProfileId]
	  ,[OtherEmailAdresses]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
	   FROM EmailContent  WHERE EmailContent.IsActive=1 AND EmailContent.EmailContentId=@emailContentId 
	
	
	--SELECT  [EmailRecepientId]
 --     ,[EmailEventId]
 --     ,[EmailContentId]
 --     ,[EmailAddress]
 --     ,[ToCC]
 --     ,[RoleId]
 --     ,[UserName]
 --     ,[IsActive] FROM [dbo].[EmailRecepient]
	--WHERE  EmailRecepient.IsActive=1 AND EmailRecepient.EmailContentId=@emailContentId 
