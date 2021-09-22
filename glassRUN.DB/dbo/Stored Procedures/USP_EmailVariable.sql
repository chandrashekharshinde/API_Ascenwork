-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.EmailVariable table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_EmailVariable]

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
            DECLARE @EmailVariableId bigint
            UPDATE dbo.EmailVariable SET
        	[SupplierId]=tmp.SupplierId ,
        	[EmailEventId]=tmp.EmailEventId ,
        	[VariableName]=tmp.VariableName ,
        	[VariableDescription]=tmp.VariableDescription ,
        	[InformationFrom]=tmp.InformationFrom ,
        	[TableName]=tmp.TableName ,
        	[ColumnName]=tmp.ColumnName ,
        	[MasterColumnName]=tmp.MasterColumnName ,
        	[WhereCondition]=tmp.WhereCondition ,
        	[GetValueFrom]=tmp.GetValueFrom ,
        	[IsActive]=tmp.IsActive ,
        	[CreatedBy]=tmp.CreatedBy ,
        	[CreatedDate]=tmp.CreatedDate ,
        	[UpdatedBy]=tmp.UpdatedBy ,
        	[UpdatedDate]=tmp.UpdatedDate
            FROM OPENXML(@intpointer,'EmailVariable',2)
			WITH
			(
			[EmailVariableId] BIGINT,
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
            )tmp WHERE EmailVariable.[EmailVariableId]=tmp.[EmailVariableId]
            SELECT  @EmailVariableId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_EmailVariable'
