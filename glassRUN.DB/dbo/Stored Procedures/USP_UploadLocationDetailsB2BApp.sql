CREATE PROCEDURE [dbo].[USP_UploadLocationDetailsB2BApp]  
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
      DECLARE @LocationId BIGINT 

      SET @ErrSeverity = 15; 
	  SET @LocationId=0;
      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 
			

				UPDATE [dbo].[Location] 
					SET @LocationId=1,
					[ShipTo]= tmp.[ShipTo],
					[BillTo] = tmp.[BillTo],
					[ModifiedDate] = GETDATE(),
					[ModifiedBy]=tmp.[Createdby]
                
				FROM   OPENXML(@intpointer, 'Json/LocationList', 2) 
				WITH (
					[LocationId] bigint,
					[ShipTo] bit,
					[BillTo] bit,
					Createdby bigint
					)tmp  WHERE [Location].[LocationId]=tmp.[LocationId];

					print @LocationId;
			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
			SELECT CAST((SELECT   'true' AS [@json:Array],
            @LocationId AS UserId , (case when (@LocationId=0 or @LocationId='') then 'Failed' else 'Success'end) as Status
          FOR XML path('userId'),ELEMENTS,ROOT('Json')) AS XML)

          EXEC Sp_xml_removedocument 
            @intPointer 
      END try 

      BEGIN catch 
          SELECT @ErrMsg = Error_message(); 
          RAISERROR(@ErrMsg,@ErrSeverity,1); 

          RETURN; 
      END catch 
  END