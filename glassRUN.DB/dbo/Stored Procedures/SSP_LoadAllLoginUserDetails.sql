CREATE PROCEDURE [dbo].[SSP_LoadAllLoginUserDetails]-- '<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><ProfileId>390</ProfileId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @profileId bigint
Declare @roleId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @profileId = tmp.[ProfileId],
		@roleId=tmp.RoleId
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ProfileId] bigint,
           RoleId bigint
			)tmp ;
			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,
l.[ProfileId]
      ,l.[Name]  
	  ,l.LoginId as Id
      
      
      ,l.[UserProfilePicture]
      
      ,l.[ReferenceId]
      ,l.[ReferenceType]
	  ,l.UserName from Login l where l.RoleMasterId=@roleId
	FOR XML path('ProfileList'),ELEMENTS,ROOT('Json')) AS XML)
END
