-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.EmailVariable table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_EmailVariable]
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

        INSERT INTO	[EmailVariable]
        (
        	[SupplierId],
        	[EmailEventId],
        	[VariableName],
        	[VariableDescription],
        	[InformationFrom],
        	[TableName],
        	[ColumnName],
        	[MasterColumnName],
        	[WhereCondition],
        	[GetValueFrom],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate],
        	[UpdatedBy],
        	[UpdatedDate]
        )

        SELECT
        	tmp.[SupplierId],
        	tmp.[EmailEventId],
        	tmp.[VariableName],
        	tmp.[VariableDescription],
        	tmp.[InformationFrom],
        	tmp.[TableName],
        	tmp.[ColumnName],
        	tmp.[MasterColumnName],
        	tmp.[WhereCondition],
        	tmp.[GetValueFrom],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	tmp.[CreatedDate],
        	tmp.[UpdatedBy],
        	tmp.[UpdatedDate]
            FROM OPENXML(@intpointer,'EmailVariable',2)
        WITH
        (
            [SupplierId] bigint,
            [EmailEventId] bigint,
            [VariableName] nvarchar(50),
            [VariableDescription] nvarchar(1000),
            [InformationFrom] nvarchar(100),
            [TableName] nvarchar(50),
            [ColumnName] nvarchar(100),
            [MasterColumnName] nvarchar(50),
            [WhereCondition] nvarchar(150),
            [GetValueFrom] nvarchar(100),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime,
            [UpdatedBy] bigint,
            [UpdatedDate] datetime
        )tmp
        
        DECLARE @EmailVariable bigint
	    SET @EmailVariable = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @EmailVariable
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
