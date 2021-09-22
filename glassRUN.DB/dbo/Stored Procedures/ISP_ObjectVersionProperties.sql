-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Thursday, September 21, 2017
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.ObjectVersionProperties table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_ObjectVersionProperties]
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

        INSERT INTO	[ObjectVersionProperties]
        (
        	[ObjectId],
        	[ObjectPropertyId],
        	[Mandatory],
        	[ValidationExpression],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        	
        )

        SELECT
        	tmp.[ObjectId],
        	tmp.[ObjectPropertyId],
        	tmp.[Mandatory],
        	tmp.[ValidationExpression],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	tmp.[CreatedDate]
        	
            FROM OPENXML(@intpointer,'ObjectVersionProperties',2)
        WITH
        (
            [ObjectId] bigint,
            [ObjectPropertyId] bigint,
            [Mandatory] bit,
            [ValidationExpression] nvarchar(250),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
           
        )tmp
        
        DECLARE @ObjectVersionProperties bigint
	    SET @ObjectVersionProperties = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @ObjectVersionProperties
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
