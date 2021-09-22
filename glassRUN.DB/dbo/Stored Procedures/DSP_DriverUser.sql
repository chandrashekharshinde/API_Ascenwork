Create PROCEDURE [dbo].[DSP_DriverUser] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @userId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @userId = tmp.[UserId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[UserId] bigint
           
			)tmp ;


			
Update Profile SET IsActive=0 where ProfileId=@userId
update Login set IsActive=0 where ProfileId=@userId
 SELECT @userId as UserId FOR XML RAW('Json'),ELEMENTS
END
