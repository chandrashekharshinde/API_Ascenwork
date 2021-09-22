






























CREATE PROCEDURE [dbo].[ISP_CompanyTransporterMapping] @xmlDoc XML 
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

          INSERT INTO [dbo].[Route] 
					 (
					[CompanyId],
					[RouteNumber],
					[OriginId],
					[DestinationId],
					[TruckSizeId],
					[CarrierNumber],
					[IsActive],
					[CreatedBy],
					[CreatedDate]
					) 
          SELECT tmp.[companyid], 
		             null,
					 [OriginId],
					 [DestinationId],
					 [TruckSizeId],
                 tmp.[transporterid], 
                 tmp.[isactive], 
                 tmp.[createdby], 
                 Getdate() 
          FROM   OPENXML(@intpointer, 'Json/RouteList', 2) 
                    WITH ( [CompanyId]     BIGINT, 
                           [TransPorterId] BIGINT, 
						   [OriginId]   BIGINT,
						   [DestinationId] BIGINT,
						   [TruckSizeId] BIGINT,
                           [IsActive]      BIT, 
                           [CreatedBy]     NVARCHAR(100) )tmp 


          DECLARE @RouteId BIGINT 

          SET @RouteId = @@IDENTITY 

          --Add child table insert procedure when required.  
          SELECT @RouteId AS RouteId 
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
