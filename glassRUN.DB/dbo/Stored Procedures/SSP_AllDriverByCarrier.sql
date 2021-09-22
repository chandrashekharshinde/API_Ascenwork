CREATE PROCEDURE [dbo].[SSP_AllDriverByCarrier] --'<Json><ServicesAction>LoadDriverByCarrier</ServicesAction><CarrierId>664</CarrierId></Json>'
(
@xmlDoc XML='<Json><CarrierId>0</CarrierId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @CarrierId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CarrierId = tmp.[CarrierId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CarrierId] bigint
			)tmp;

WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT 'true' AS [@json:Array],
l.LoginId as DeliveryPersonnelId,
			l.[Name],
			l.UserName as UserName,
        	
        	l.ReferenceId,
        	l.ReferenceType,
			[RoleMasterId],
			[PasswordSalt],
			[HashedPassword]
			
  FROM  Login l 
  where l.ReferenceId 
  in (@CarrierId) and RoleMasterId=8 and IsActive=1
	FOR XML path('ProfileList'),ELEMENTS,ROOT('Json')) AS XML)
END


