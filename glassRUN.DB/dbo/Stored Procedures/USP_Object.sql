CREATE PROCEDURE [dbo].[USP_Object]

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
            DECLARE @ObjectId bigint
            UPDATE dbo.Object SET
        	[ObjectName]=tmp.ObjectName ,
        	[IsActive]=tmp.IsActive ,        	
        	[ModifiedBy]=tmp.ModifiedBy ,
        	[ModifiedDate]=tmp.ModifiedDate
            FROM OPENXML(@intpointer,'Object',2)
			WITH
			(
            [ObjectId] bigint,
           
            [ObjectName] nvarchar(250),
           
            [IsActive] bit,           
           
           
            [ModifiedBy] bigint,
           
            [ModifiedDate] datetime
           
            )tmp WHERE Object.[ObjectId]=tmp.[ObjectId]
            SELECT  @ObjectId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
