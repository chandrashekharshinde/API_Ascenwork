




CREATE PROCEDURE [dbo].[SSP_AllPlateNumberForSecurityApp] --'<Json><ServicesAction>GetPlateNumberByCarrierId</ServicesAction><CarrierId>106</CarrierId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @carrierId bigint
Declare @PlateNumber nvarchar(max)=''
Declare @roleId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @carrierId = tmp.[CarrierId],
@roleId = tmp.[RoleId],
@PlateNumber=tmp.[PlateNumber]

FROM OPENXML(@intpointer,'Json',2)
WITH
(
[CarrierId] bigint,
[RoleId] bigint,
[PlateNumber] nvarchar(max)
)tmp ;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  top 10 'true' AS [@json:Array] 
,TransportVehicleid as [TransporterVehicleId]
,[TransporterId]
,VehicleName as [TransporterVehicleName]
,VehicleRegistrationNumber + ISNULL(' (' + (select top 1 ts.TruckSize from TruckSize ts where ts.TruckSizeId=[TransportVehicle].TruckSizeId) + ')','') as [TransporterVehicleRegistrationNumber]
,VehicleRegistrationNumber as PlateNumber
,VehicleTypeId as [TransporterVehicleType]
, (select top 1 ts.TruckCapacityWeight from TruckSize ts where ts.TruckSizeId=[TransportVehicle].TruckSizeId) as[TransporterVehicleCapacity]

,TruckSizeId
,(select cast ((SELECT distinct 'true' AS [@json:Array] , pnd.[DriverId] from PlateNumberDriverMapping pnd where pnd.Active=1 and pnd.[PlateNumber]=[TransportVehicle].VehicleRegistrationNumber
FOR XML path('DriverList'),ELEMENTS) AS XML)) 
,(select cast ((SELECT distinct 'true' AS [@json:Array] , tv.TransporterId,c.CompanyId,c.[CompanyName]+' ('+ISNULL(c.[CompanyMnemonic],'-')+')' as [Name] from [TransportVehicle] tv join Company c on tv.TransporterId=c.Companyid where tv.IsActive=1 and tv.VehicleRegistrationNumber=[TransportVehicle].VehicleRegistrationNumber
FOR XML path('CarrierList'),ELEMENTS) AS XML)) 
FROM [TransportVehicle] WHERE IsActive = 1 
and TransportVehicleId not in (select isnull(TruckId,0) from TruckInDeatils where TruckOutDataTime is null)
and TransportVehicleId in ( select lu.TransportVehicleId from (Select tv.TransportVehicleId,Row_Number () OVER ( partition by VehicleRegistrationNumber
 ORDER BY VehicleRegistrationNumber
 ) as rownumber  from TransportVehicle tv where
 (VehicleRegistrationNumber like '%'+@PlateNumber+'%' or @PlateNumber='') and tv.IsActive=1  ) as lu where rownumber=1) 
FOR XML path('TransporterVehicleList'),ELEMENTS,ROOT('Json')) AS XML)


END
