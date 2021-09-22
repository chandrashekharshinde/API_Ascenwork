CREATE PROCEDURE [dbo].[ISP_ContactInformation] --'<Json><ServicesAction>SaveTransportVehicle</ServicesAction><TransportVehicleList><TransporterVehicleId>0</TransporterVehicleId><TransporterVehicleName>dsfsdf</TransporterVehicleName><TransporterVehicleRegistrationNumber>5646</TransporterVehicleRegistrationNumber><CreatedBy>343</CreatedBy><IsActive>true</IsActive></TransportVehicleList></Json>'
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
			
                

		 INSERT INTO	[ContactInformation]
        (
	   [ObjectId]
	   ,[ObjectType]
      ,[ContactType]
      ,[ContactPerson]
      ,[Contacts]
      ,[Purpose]
      ,[CreatedBy]
      ,[CreatedDate]     
      ,[IsActive]
		
		  
        )

        SELECT
			tmp.[ObjectId],
			tmp.ObjectType,
        	tmp.[ContactType],
        	tmp.[ContactPerson],
        	tmp.[Contacts],   			
			 tmp.Purpose,
			tmp.CreatedBy,
			GETDATE(),
			1
			 	
        	
            FROM OPENXML(@intpointer,'Json/ContactInformationList',2)
        WITH
        (
            [ObjectId] bigint,
			ObjectType nvarchar(50),			
            [ContactType] nvarchar(50),			
			[ContactPerson] nvarchar(500),
			[Contacts] nvarchar(50),
            Purpose bigint,			
            [IsActive] bit,
			CreatedBy bigint,
			CreatedDate datetime
            
        )tmp

		 DECLARE @ContactInformation bigint
	    SET @ContactInformation = @@IDENTITY

        --Add child table insert procedure when required.
    SELECT @ContactInformation as ContactInformation FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
