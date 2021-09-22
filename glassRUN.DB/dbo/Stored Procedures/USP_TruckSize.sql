CREATE PROCEDURE [dbo].[USP_TruckSize] --'<Json><ServicesAction>InsertTruck</ServicesAction><TruckSizeId>180</TruckSizeId><VehicleType>61</VehicleType><TruckSize>10 T</TruckSize><TruckCapacityPalettes>20.00</TruckCapacityPalettes><TruckCapacityWeight>20.00</TruckCapacityWeight><Height>0.00</Height><Width>0.00</Width><Length>0.00</Length><IsActive>true</IsActive><CreatedBy>478</CreatedBy></Json>'
 @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @TranName NVARCHAR(255) 
      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
	  DECLARE @TruckSizeId BIGINT

      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 

         

          UPDATE dbo.trucksize 
          SET    @TruckSizeId=tmp.[TruckSizeId],
		         [vehicletype] = tmp.[VehicleType], 
                 [trucksize] = tmp.[TruckSize], 
                 [truckcapacitypalettes] = tmp.truckcapacitypalettes, 
                 [truckcapacityweight] = tmp.truckcapacityweight, 
                 [isactive] = 1, 
                 [height] = tmp.[height], 
                 [width] = tmp.[width], 
                 [length] = tmp.[length], 
                 [updatedby] = tmp.[createdby] 
          FROM   OPENXML(@intpointer, 'Json', 2) 
                    WITH ( [TruckSizeId]           BIGINT, 
                           [VehicleType]           NVARCHAR(500), 
                           [TruckSize]             NVARCHAR(200), 
                           [TruckCapacityPalettes] Decimal(10,2), 
                           [TruckCapacityWeight]   Decimal(10,2), 
                           [IsActive]              Bit, 
                           [Height]                Decimal(10,2), 
                           [Width]                 Decimal(10,2), 
                           [Length]                Decimal(10,2), 
                           [CreatedBy]             BIGINT)tmp 
          WHERE  trucksize.[trucksizeid] = tmp.[TruckSizeId] 

		  
          SELECT @TruckSizeId AS TruckSizeId 
          FOR xml raw('Json'), elements 

          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 

          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END
