CREATE PROCEDURE [dbo].[SSP_AllPlateNumberByCarrierId] --'<Json><ServicesAction>GetPlateNumberByCarrierId</ServicesAction><CarrierId>106</CarrierId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @carrierId bigint
Declare @roleId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @carrierId = tmp.[CarrierId],
 @roleId = tmp.[RoleId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CarrierId] bigint,
			[RoleId] bigint
           
			)tmp ;


if(@roleId=7 or @roleId = 2)
BEGIN
	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,TransportVehicleid as  [TransporterVehicleId]
      ,VehicleName as [TransporterVehicleName]
      ,VehicleRegistrationNumber as [TransporterVehicleRegistrationNumber]
      ,VehicleTypeId as [TransporterVehicleType]
      , (select top 1 ts.TruckCapacityWeight from TruckSize ts where ts.TruckSizeId=[TransportVehicle].TruckSizeId) as [TransporterVehicleCapacity]
      ,[TransporterId]
	  ,TruckSizeId
  FROM [TransportVehicle] WHERE IsActive = 1 
  --and TransporterId in (select LoginId from Login where ProfileId in ( select ProfileId from Profile where ReferenceId=@CarrierId))
  and TransporterId in(@CarrierId)
	FOR XML path('TransporterVehicleList'),ELEMENTS,ROOT('Json')) AS XML)
END	
ELSE
BEGIN
		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,TransportVehicleid as [TransporterVehicleId]
      ,VehicleName as [TransporterVehicleName]
      ,VehicleRegistrationNumber as [TransporterVehicleRegistrationNumber]
      ,VehicleTypeId as [TransporterVehicleType]
       , (select top 1 ts.TruckCapacityWeight from TruckSize ts where ts.TruckSizeId=[TransportVehicle].TruckSizeId) as[TransporterVehicleCapacity]
      ,[TransporterId]
	  ,TruckSizeId
  FROM [TransportVehicle] WHERE IsActive = 1 
  --and TransporterId in (select LoginId from Login where ProfileId in ( select ProfileId from Profile where ReferenceId=@CarrierId))
	FOR XML path('TransporterVehicleList'),ELEMENTS,ROOT('Json')) AS XML)
END

END
