
CREATE PROCEDURE [dbo].[SSP_CustomerApp_CustomerProfile] 
@xmlDoc XML


AS

BEGIN
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(4000);
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
@username = tmp.[userName]
FROM OPENXML(@intpointer,'Json',2)
WITH
(
userName nvarchar(max)

)tmp;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array],
c.CompanyName as Name,
c.CompanyMnemonic as Code,
c.AddressLine1 as AddressLine1,
c.AddressLine2 as AddressLine2,
c.AddressLine3 as AddressLine3,
c.[State],
c.[Country],
c.[City],
c.[PostCode] as Pincode,
(select top 1 ContactPerson from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='MobileNo') ContactPerson,
(select top 1 Contacts from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='MobileNo') Phone,
(select top 1 Contacts from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Email') EmailId,
l.UserProfilePicture
From Login l left join RoleMaster r on l.RoleMasterId=r.RoleMasterId 
left join company c on c.CompanyId=l.ReferenceId
WHERE l.IsActive=1
And Username= @username 
FOR XML path('UserDetails'),ELEMENTS,ROOT('Json')) AS XML)
END
