CREATE PROCEDURE [dbo].[SSP_LoadLoginDetailByLoginId] --'<Json><ServicesAction>LoadLoginDetailByLoginId</ServicesAction><LoginId>409</LoginId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @LoginId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @LoginId = tmp.[LoginId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[LoginId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  
l.[LoginId],
l.[Name],
        	
        	l.UserProfilePicture,
        
        	l.ReferenceId,
        	l.ReferenceType,
			l.[RoleMasterId],
			[UserName],
			rm.RoleName ,
			lu.Name  as 'CompanyTypeName',
			c.CompanyName  ,
			l.LicenseNumber,
			l.DefaultLanguage,
			l.LicenseType ,
			
(select cast ((SELECT  'true' AS [@json:Array]  ,ContactInformationId  , ObjectId  , ObjectType  , ContactType  , ContactPerson  as 'ContactPersonName'   , Contacts  as 'ContactPersonNumber' ,IsActive  , NEWID() as 'ContactinfoGUID'   , (select  LookUpId  from  LookUp  where name=ContactType)  as 'ContactTypeId' from ContactInformation  where ObjectId=l.LoginId  and ObjectType ='Login'
 FOR XML path('ContactInformationList'),ELEMENTS) AS xml)),
 
 
(select cast ((SELECT  'true' AS [@json:Array]  ,DocumentsId  , DocumentExtension  ,DocumentName,   DocumentBase64  , ObjectId  ,ObjectType   ,IsActive,DocumentTypeId  ,    (select  Name  from  LookUp  where LookUpId=DocumentTypeId)  as 'DocumentType' ,  NEWID() as 'DocumentinfoGUID'   from Documents  where ObjectId=l.LoginId   and ObjectType ='Login'
 FOR XML path('DocumentInformationList'),ELEMENTS) AS xml))

			
 from login l 
 left join RoleMaster rm on rm.RoleMasterId = l.RoleMasterId
 left join LookUp  lu on lu.LookUpId = l.ReferenceType
 left join Company  c on c.CompanyId  = l.ReferenceId

 where  l.IsActive=1 and l.LoginId=@LoginId
	FOR XML path('Login'),ELEMENTS,ROOT('Json')) AS XML)
END
