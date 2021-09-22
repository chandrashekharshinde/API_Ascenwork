CREATE PROCEDURE [dbo].[ISP_TransporterVehicle] --'<Json><ServicesAction>SaveTransportVehicle</ServicesAction><TransportVehicleList><TransporterVehicleId>0</TransporterVehicleId><TransporterVehicleName>dsfsdf</TransporterVehicleName><TransporterVehicleRegistrationNumber>5646</TransporterVehicleRegistrationNumber><CreatedBy>343</CreatedBy><IsActive>true</IsActive></TransportVehicleList></Json>'
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	SET @ErrSeverity = 15; 

		BEGIN TRY
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
			
                

		 INSERT INTO	[TransporterVehicle]
        (
		   [TransporterVehicleName]
		  ,[TransporterVehicleRegistrationNumber]
		  ,[TransporterVehicleType]
		  ,[TransporterVehicleCapacity]		
		  ,[TransporterId]
		  ,ProductType
		  ,GrossWeight
		  ,NumberOfCompartments
		  ,TruckSizeId  
		  ,RegisteredVehicleCertificateBlob
		  ,FormatType
		  ,[IsActive]
		  ,CreatedBy
		  ,CreatedDate
		
		  
        )

        SELECT
			tmp.[TransporterVehicleName],
        	tmp.[TransporterVehicleRegistrationNumber],
        	NULL,
        	NULL,   
			 tmp.[TransporterId],    
			 	NULL,
				NULL,
				NULL,
			tmp.[TruckSizeId],   
			tmp.RegisteredVehicleCertificateBlob,
			tmp.FormatType,
        	1,
			tmp.CreatedBy,
			GETDATE()
			 	
        	
            FROM OPENXML(@intpointer,'Json/TransportVehicleList',2)
        WITH
        (
            [TransporterVehicleName] nvarchar(50),
            [TransporterVehicleRegistrationNumber] nvarchar(50),
			[TransporterVehicleType] nvarchar(50),
			[TransporterVehicleCapacity] nvarchar(50),
            [TransporterId] bigint,
			ProductType nvarchar(200),
			GrossWeight decimal(10,2),
			NumberOfCompartments bigint,
            [TruckSizeId] bigint,
			RegisteredVehicleCertificateBlob nvarchar(max),
			FormatType nvarchar(50),
            [IsActive] bit,
			CreatedBy bigint,
			CreatedDate datetime
                 
            
            
        )tmp

		 DECLARE @TransportVehicle bigint
	    SET @TransportVehicle = @@IDENTITY

        --Add child table insert procedure when required.
    SELECT @TransportVehicle as TransportVehicle FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
