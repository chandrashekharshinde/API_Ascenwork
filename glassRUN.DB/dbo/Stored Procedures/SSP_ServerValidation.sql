CREATE PROCEDURE [dbo].[SSP_ServerValidation] --'<Json><ServicesAction>LoadEnquiryByEnquiryId</ServicesAction><EnquiryId>1625</EnquiryId><RoleId>3</RoleId><CultureId>1101</CultureId></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
Declare @servicesAction nvarchar(250)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @servicesAction = tmp.[ServicesAction]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ServicesAction] nvarchar(250)
           
			)tmp ;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((SELECT top 1 ServicesURL,

	   (select cast ((SELECT  'true' AS [@json:Array] ,
		validate.IsActive,
		PropertyName,
		
		ValidationExpression,
		ResourceValue
		
		
		FROM servervalidation validate
		  join
		  Resources res 
		  on validate.ResourceKey=res.ResourceKey and  ServicesAction=@servicesAction
 FOR XML path('ServerValidationList'),ELEMENTS) AS xml))

	FROM ServiceConfiguration where IsActive = 1 and ServicesAction = @servicesAction
	FOR XML path(''),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END