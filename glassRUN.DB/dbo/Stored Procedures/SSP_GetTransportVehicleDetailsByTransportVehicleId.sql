CREATE PROCEDURE [dbo].[SSP_GetTransportVehicleDetailsByTransportVehicleId] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

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


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,[TransporterVehicleId]
      ,[TransporterVehicleName]
      ,[TransporterVehicleRegistrationNumber]
      ,[TransporterVehicleType]
      ,[TransporterVehicleCapacity]
      ,[TransporterId]
      ,[ProductType]
      ,[GrossWeight]
      ,[NumberOfCompartments]
      ,[TruckSizeId]
	  ,[IsActive]
				   FROM [TransporterVehicle]  
	  WHERE IsActive = 1 and [TransporterVehicleId]=@transportVehicleId
	FOR XML path('TransportVehicleList'),ELEMENTS,ROOT('Json')) AS XML)
END
