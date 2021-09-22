CREATE PROCEDURE [dbo].[DSP_EmailConfiguration] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @emailConfiguration bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @emailConfiguration = tmp.[EmailConfigurationId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EmailConfigurationId] bigint
           
			)tmp ;


			
Update EmailConfiguration SET IsActive=0 where [EmailConfigurationId]=@emailConfiguration
 SELECT @emailConfiguration as EmailConfiguration FOR XML RAW('Json'),ELEMENTS
END
