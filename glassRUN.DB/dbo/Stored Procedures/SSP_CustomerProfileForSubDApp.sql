CREATE PROCEDURE [dbo].[SSP_CustomerProfileForSubDApp] 
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
l.LoginId As UserId,
l.UserName,
trim(substring(l.[Name],1,PATINDEX('% %',l.[Name]))) as FirstName,
trim(SUBSTRING(l.[Name],patindex('% %',l.[Name]),LEN(l.[Name]))) as LastName,
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
--(select top 1 Contacts from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='MobileNo') Phone,
(select top 1 CASE WHEN (SELECT Count(*) FROM STRING_SPLIT(Contacts, '-')) = 1 THEN (SELECT value FROM STRING_SPLIT(Contacts, '-'))
ELSE (SELECT top 1 value FROM STRING_SPLIT(Contacts, '-') order by 1 desc) END
 from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='MobileNo') Phone,
 (select top 1 CASE WHEN (SELECT Count(*) FROM STRING_SPLIT(Contacts, '-')) = 1 THEN ''
ELSE (SELECT top 1 value FROM STRING_SPLIT(Contacts, '-')) END
 from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='MobileNo') CountryCode,
(select top 1 Contacts from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Email') EmailId,
(select top 1 Contacts from ContactInformation where ObjectId=c.CompanyId and ObjectType='Company' and ContactType='Photo') As UserProfilePicture
From Login l left join RoleMaster r on l.RoleMasterId=r.RoleMasterId 
left join company c on c.CompanyId=l.ReferenceId
WHERE l.IsActive=1
And l.Username= @username 
FOR XML path('UserDetails'),ELEMENTS,ROOT('Json')) AS XML)
END