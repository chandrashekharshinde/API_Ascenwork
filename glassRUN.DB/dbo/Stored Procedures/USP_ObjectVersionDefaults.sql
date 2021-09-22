CREATE PROCEDURE [dbo].[USP_ObjectVersionDefaults]

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
            DECLARE @ObjectVersionDefaultsId bigint
            UPDATE dbo.ObjectVersionDefaults SET
        	[ObjectId]=tmp.ObjectId ,
        	[ObjectPropertyId]=tmp.ObjectPropertyId ,
        	[DefaultValue]=tmp.DefaultValue ,
        	[IsActive]=tmp.IsActive ,        	
        	[ModifiedBy]=tmp.ModifiedBy ,
        	[ModifiedDate]=tmp.ModifiedDate
            FROM OPENXML(@intpointer,'ObjectVersionDefaults',2)
			WITH
			(
            [ObjectVersionDefaultsId] bigint,
           
            [ObjectId] bigint,
           
            [ObjectPropertyId] bigint,
           
            [DefaultValue] nvarchar(500),
           
            [IsActive] bit,          
          
           
            [ModifiedBy] bigint,
           
            [ModifiedDate] datetime
           
            )tmp WHERE ObjectVersionDefaults.[ObjectVersionDefaultsId]=tmp.[ObjectVersionDefaultsId]
            SELECT  @ObjectVersionDefaultsId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
