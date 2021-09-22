
CREATE PROCEDURE [dbo].[ISP_TruckSize] --'<Json><ServicesAction>InsertTruck</ServicesAction><TruckSizeId>0</TruckSizeId><VehicleType>56</VehicleType><TruckSize>4</TruckSize><TruckCapacityPalettes></TruckCapacityPalettes><TruckCapacityWeight>1.8</TruckCapacityWeight><Height>1</Height><Width>23</Width><Length>5</Length><IsActive>true</IsActive><CreatedBy>409</CreatedBy></Json>'
  
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @TranName NVARCHAR(255) 
      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 

      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 

          INSERT INTO [dbo].[trucksize] 
                      ([vehicletype], 
                       [trucksize], 
                       [truckcapacitypalettes], 
                       [truckcapacityweight], 
                       [isactive], 
                       [height], 
                       [width], 
                       [length], 
                       [CreatedBy], 
                       [CreatedDate]) 
          SELECT tmp.[vehicletype], 
                 tmp.[trucksize], 
                 ISNULL(tmp.[truckcapacitypalettes],0), 
                 ISNULL(tmp.[truckcapacityweight],0), 
                 tmp.[isactive], 
                 ISNULL(tmp.[height],0), 
                 ISNULL(tmp.[width], 0),
                 ISNULL(tmp.[length],0), 
                 tmp.[CreatedBy], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json', 2) 
                    WITH ( [VehicleType]           NVARCHAR(500), 
                           [TruckSize]             NVARCHAR(200), 
                           [TruckCapacityPalettes] decimal(18,2), 
                           [TruckCapacityWeight]   decimal(18,2), 
                           [IsActive]              NVARCHAR(max), 
                           [Height]                decimal(18,2), 
                           [Width]                 decimal(18,2), 
                           [Length]                decimal(18,2), 
                           [CreatedBy]            NVARCHAR(100) )tmp 

          DECLARE @TruckSizeId BIGINT 

          SET @TruckSizeId = @@IDENTITY 

          --Add child table insert procedure when required. 
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
