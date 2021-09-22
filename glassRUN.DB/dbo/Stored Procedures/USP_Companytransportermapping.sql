
create PROCEDURE [dbo].[USP_Companytransportermapping] @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @TranName NVARCHAR(255) 
      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
	  DECLARE @CompanyTransporterMappingId BIGINT

      SET @ErrSeverity = 15; 

      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 

         

          UPDATE [dbo].[companytransportermapping] 
          SET    @CompanyTransporterMappingId=tmp.[CompanyTransporterMappingId],
		        [companyid]=tmp.[CompanyId], 
                [transporterid]=tmp.[TransporterId], 
                [isactive]=tmp.[IsActive], 
                [UpdatedBy]=tmp.[CreatedBy], 
                [UpdatedDate]=GETDATE()
          FROM   OPENXML(@intpointer, 'Json', 2) 
                    WITH ( [CompanyTransporterMappingId]     BIGINT,
					       [CompanyId]     BIGINT, 
                           [TransporterId] BIGINT, 
                           [IsActive]      BIT, 
                           [CreatedBy]     NVARCHAR(100) )tmp 
          WHERE  Companytransportermapping.[CompanyTransporterMappingId] = tmp.[CompanyTransporterMappingId] 

		  
          SELECT @CompanyTransporterMappingId AS CompanyTransporterMappingId 
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
