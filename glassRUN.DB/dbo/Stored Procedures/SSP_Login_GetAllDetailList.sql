CREATE PROCEDURE [dbo].[SSP_Login_GetAllDetailList] --'<Json><ServicesAction>LoadAllDriverList</ServicesAction></Json>'
(
@xmlDoc XML='<Json><CarrierId>0</CarrierId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @CarrierId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


	
	  

	
	  


 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT  'true' AS [@json:Array],p.ProfileId,
l.LoginId as DeliveryPersonnelId,
			(l.[Name] +  ' ('+ ISNULL(DriverId,'') +')' ) as Name,
			l.UserName as UserName,
        	[EmailId],
        	[ContactNumber],
        	p.LicenseNumber,
        	ParentUser,
        	l.ReferenceId,
        	l.ReferenceType,
			[RoleMasterId],
			
			[PasswordSalt],
			[HashedPassword],
			p.UpdatedDate,
			p.CreatedDate
  FROM Profile p join Login l on l.ProfileId = p.ProfileId where p.IsActive = 1 
	FOR XML path('ProfileList'),ELEMENTS,ROOT('Json')) AS XML)
END