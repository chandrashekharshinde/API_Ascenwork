CREATE PROCEDURE [dbo].[USP_GUIDInLogin] 

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
            DECLARE @ProfileId bigint

            UPDATE dbo.Login SET
   @ProfileId=tmp.[ProfileId],         
         GUID=tmp.[GUID],         
         UpdatedDate  = GETDATE()    
         
            FROM OPENXML(@intpointer,'Login',2)
   WITH
   (
   [UserName] nvarchar(200) ,
   [GUID] nvarchar(max) ,
   [ProfileId] bigint
         
            )  tmp WHERE Login.UserName=tmp.UserName   
             SELECT @ProfileId as ProfileId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
  END TRY
  BEGIN CATCH
  SELECT @ErrMsg = ERROR_MESSAGE();
  RAISERROR(@ErrMsg, @ErrSeverity, 1);
  RETURN; 
  END CATCH
END