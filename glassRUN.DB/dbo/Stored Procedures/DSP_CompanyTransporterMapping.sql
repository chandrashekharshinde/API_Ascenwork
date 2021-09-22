CREATE PROCEDURE [dbo].[DSP_CompanyTransporterMapping] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @CompanyId bigint
Declare @IsActive bit


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyId = tmp.[CompanyId],
@IsActive=tmp.[IsActive]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint,
           [IsActive] bit
			)tmp ;


			
Update Route SET IsActive=@IsActive where RouteId=@CompanyId
 SELECT @CompanyId as CompanyId FOR XML RAW('Json'),ELEMENTS
END
