Create PROCEDURE [dbo].[SSP_LoadTransportVehicleByTransportVehicleId] --'<Json><OrderId>75994</OrderId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @transporterVehicleId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @transporterVehicleId = tmp.[TransporterVehicleId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[TransporterVehicleId] bigint
			)tmp;

			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array], TransporterVehicleId,RegisteredVehicleCertificateBlob as DocumentBlob,FormatType as DocumentFormat
			   		FROM TransporterVehicle  WHERE  TransporterVehicleId = @transporterVehicleId 
	FOR XML path('OrderDocumentList'),ELEMENTS,ROOT('Json')) AS XML)
END
