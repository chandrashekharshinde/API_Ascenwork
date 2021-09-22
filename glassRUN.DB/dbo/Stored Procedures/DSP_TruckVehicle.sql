Create PROCEDURE [dbo].[DSP_TruckVehicle] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @transportVehicleId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @transportVehicleId = tmp.[TransportVehicleId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[TransportVehicleId] bigint
           
			)tmp ;


			
Update TransporterVehicle SET IsActive=0 where TransporterVehicleId=@transportVehicleId
 SELECT @transportVehicleId as TruckSize FOR XML RAW('Json'),ELEMENTS
END
