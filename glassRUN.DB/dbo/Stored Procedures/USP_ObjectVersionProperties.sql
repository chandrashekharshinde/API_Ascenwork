CREATE PROCEDURE [dbo].[USP_ObjectVersionProperties]

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
            DECLARE @ObjectVersionPropertiesId bigint
            UPDATE dbo.ObjectVersionProperties SET
        	[ObjectId]=tmp.ObjectId ,
        	[ObjectPropertyId]=tmp.ObjectPropertyId ,
        	[Mandatory]=tmp.Mandatory ,
        	[ValidationExpression]=tmp.ValidationExpression ,
        	[IsActive]=tmp.IsActive ,        	
        	[ModifiedBy]=tmp.ModifiedBy ,
        	[ModifiedDate]=tmp.ModifiedDate
            FROM OPENXML(@intpointer,'ObjectVersionProperties',2)
			WITH
			(
            [ObjectVersionPropertiesId] bigint,
           
            [ObjectId] bigint,
           
            [ObjectPropertyId] bigint,
           
            [Mandatory] bit,
           
            [ValidationExpression] nvarchar(250),
           
            [IsActive] bit,           
           
            [ModifiedBy] bigint,
           
            [ModifiedDate] datetime
           
            )tmp WHERE ObjectVersionProperties.[ObjectVersionPropertiesId]=tmp.[ObjectVersionPropertiesId]
            SELECT  @ObjectVersionPropertiesId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
