CREATE PROCEDURE [dbo].[USP_PrinterBranchPlantMapping]

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
            DECLARE @PrinterBranchPlantMappingId bigint
            UPDATE dbo.PrinterBranchPlantMapping SET
			[BranchPlantCode]=tmp.[BranchPlantCode] ,
        	[PrinterName]=tmp.PrinterName ,
        	[PrinterPath]=tmp.PrinterPath ,
        	[NumberOfCopies]=tmp.NumberOfCopies ,
			[ModifiedBy]=tmp.CreatedBy,
			[ModifiedDate]=GETDATE(),
        	[IsActive]=1
            FROM OPENXML(@intpointer,'Json/PrinterBranchPlantMappingList',2)
			WITH
			(
            [PrinterBranchPlantMappingId] bigint,
           [BranchPlantCode] nvarchar(50),
            [PrinterName] nvarchar(200),           
            [PrinterPath] nvarchar(max),           
            [NumberOfCopies] bigint,      
			[CreatedBy] bigint,
			[ModifiedDate] datetime,     
            [IsActive] bit
           
            )tmp WHERE PrinterBranchPlantMapping.[PrinterBranchPlantMappingId]=tmp.[PrinterBranchPlantMappingId]
            SELECT @PrinterBranchPlantMappingId as PrinterBranchPlantMappingId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
