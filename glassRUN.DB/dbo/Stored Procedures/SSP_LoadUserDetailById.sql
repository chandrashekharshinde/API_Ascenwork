CREATE PROCEDURE [dbo].[SSP_LoadUserDetailById]-- '<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><ProfileId>390</ProfileId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @profileId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @profileId = tmp.[ProfileId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ProfileId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,
p.ProfileId,
l.Name,
ContactNumber,
l.UserProfilePicture,
EmailId,
p.LicenseNumber,
DriverId,
l.UserName as UserName,
l.LoginId,
l.RoleMasterId,
( Select CAST((Select 'true' AS [@json:Array]  ,[DocumentsId]
      ,[DocumentName]
      ,[DocumentExtension]
      ,[DocumentBase64]
      ,[ObjectId]
      ,[ObjectType]
      ,[SequenceNo]
      
	  From Documents  where ObjectId in (p.ProfileId) and ObjectType = 'Profile' and IsActive = 1
    
	 FOR XML path('DocumentsList'),ELEMENTS) AS xml))
  FROM [Profile] p join Login l on p.ProfileId = l.ProfileId WHERE p.IsActive = 1 and p.ProfileId=@profileId
	FOR XML path('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
END