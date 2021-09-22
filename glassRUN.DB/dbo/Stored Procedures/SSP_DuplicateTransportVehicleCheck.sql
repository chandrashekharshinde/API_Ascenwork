CREATE PROCEDURE [dbo].[SSP_DuplicateTransportVehicleCheck] --'<Json><ServicesAction>DuplicateTransporterCheck</ServicesAction><TransportVehicleId>104</TransportVehicleId><VehicleRegistrationNumber>456yfd</VehicleRegistrationNumber><TransporterId>668</TransporterId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @TransportVehicleId bigint
Declare @VehicleRegistrationNumber nvarchar(50)
Declare @TransporterId nvarchar(50)

Declare @IsValid bigint

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @TransportVehicleId = tmp.[TransportVehicleId],
@VehicleRegistrationNumber = tmp.[VehicleRegistrationNumber],
@TransporterId = tmp.[TransporterId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[TransportVehicleId] bigint,
						[VehicleRegistrationNumber] nvarchar(50),
						[TransporterId] nvarchar(50)
           
			)tmp ;


			 if ((select count(*) from [TransportVehicle] wac where wac.VehicleRegistrationNumber = @VehicleRegistrationNumber and wac.TransporterId = @TransporterId and wac.TransportVehicleId <> @TransportVehicleId and wac.isactive = 1) = 0 )
    BEGIN
     set @IsValid=0
    end
     else
     BEGIN
      set @IsValid=1
     end

 SELECT @IsValid as IsValid FOR XML RAW('Json'),ELEMENTS
END
