CREATE PROCEDURE [dbo].[USP_CustomerApp_UploadPhoto]  
  @xmlDoc XML 
AS 
  BEGIN 
      SET arithabort ON 

      DECLARE @ErrMsg NVARCHAR(2048) 
      DECLARE @ErrSeverity INT; 
      DECLARE @intPointer INT; 
      DECLARE @LoginId BIGINT 

      SET @ErrSeverity = 15; 
	  SET @LoginId=0;
      BEGIN try 
          EXEC Sp_xml_preparedocument 
            @intpointer output, 
            @xmlDoc 
			

				UPDATE [dbo].[Login] 
					SET @LoginId=tmp.[UserId],
					UserProfilePicture= tmp.[Photo],
					[UpdatedDate] = Getdate(),
					[UpdatedBy]=tmp.[CreatedBy]
                
				FROM   OPENXML(@intpointer, 'Json', 2) 
				WITH (
					[UserId] bigint,
					[Photo] nvarchar(max),
					CreatedBy bigint,
					[UserName] nvarchar(2000)
					)tmp  WHERE [Login].[LoginId]=tmp.[UserId];

					print @LoginId;
			WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
			SELECT CAST((SELECT   'true' AS [@json:Array],
            @LoginId AS UserId , (case when (@LoginId=0 or @LoginId='') then 'Failed' else 'Success'end) as Status
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