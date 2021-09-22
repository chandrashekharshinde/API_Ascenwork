Create PROCEDURE [dbo].[ISP_PlateNumberDriverMapping] --'<Json><ServicesAction>SaveTransportVehicle</ServicesAction><TransportVehicleList><TransporterVehicleId>0</TransporterVehicleId><TransporterVehicleName>dsfsdf</TransporterVehicleName><TransporterVehicleRegistrationNumber>5646</TransporterVehicleRegistrationNumber><CreatedBy>343</CreatedBy><IsActive>true</IsActive></TransportVehicleList></Json>'
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
			
                

		 INSERT INTO	[PlateNumberDriverMapping]
        (
		   [PlateNumber]
		  ,[DriverId]		  
		  ,[Active]
		  ,CreatedBy
		  ,CreatedDate
		
		  
        )

        SELECT
			tmp.[PlateNumber],
        	tmp.[DriverId],        	
        	1,
			tmp.CreatedBy,
			GETDATE()
			 	
        	
            FROM OPENXML(@intpointer,'Json/PlateNumberDriverMappingList',2)
        WITH
        (
            [PlateNumber] nvarchar(50),           
            [DriverId] bigint,			
            [IsActive] bit,
			CreatedBy bigint,
			CreatedDate datetime
                 
            
            
        )tmp

		 DECLARE @PlateNumberDriverMapping bigint
	    SET @PlateNumberDriverMapping = @@IDENTITY

        --Add child table insert procedure when required.
    SELECT @PlateNumberDriverMapping as PlateNumberDriverMapping FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
