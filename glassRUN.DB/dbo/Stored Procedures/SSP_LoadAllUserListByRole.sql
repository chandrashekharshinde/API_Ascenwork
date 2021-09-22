CREATE PROCEDURE [dbo].[SSP_LoadAllUserListByRole]-- '<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><ProfileId>390</ProfileId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @profileId bigint
Declare @RoleMasterId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @profileId = tmp.[ProfileId],
	   @RoleMasterId=tmp.[RoleMasterId]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ProfileId] bigint,
			[RoleMasterId] bigint
			)tmp ;
			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,
		p.[ProfileId]
		,l.LoginId as Id
      ,l.[Name]
      ,[EmailId]
      ,[ContactNumber]
      ,l.[UserProfilePicture]
      ,[ParentUser]
      ,l.[ReferenceId]
      ,l.[ReferenceType]
	  ,l.UserName from Profile p inner join Login l on p.ProfileId=l.ProfileId
	  where (l.RoleMasterId=@RoleMasterId or @RoleMasterId=0)
	FOR XML path('ProfileList'),ELEMENTS,ROOT('Json')) AS XML)
END
