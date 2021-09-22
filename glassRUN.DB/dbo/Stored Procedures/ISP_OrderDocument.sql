
 
CREATE PROCEDURE [dbo].[ISP_OrderDocument]
@xmlDoc xml 
AS 
 BEGIN 
		SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	DECLARE @DocumentTypeId BIGINT; 


	SET @ErrSeverity = 15; 

		BEGIN TRY
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


			SELECT * INTO #tmpOrderDocument
			FROM OPENXML(@intpointer,'Json/OrderDocumentList',2)
			WITH 
			(		
				 [OrderId] bigint,
			OrderProductId BIGINT,
            [DocumentTypeId] int,
            [FileFormat] nvarchar(50),
            [FileSrc] VARBINARY(max),
            [DocumentDescription] nvarchar(max),
            [CreatedDate] DATETIME
			)tmp



 DECLARE @OrderDocument BIGINT
 

 INSERT INTO [dbo].[OrderDocument]
			(
				[OrderId],
			OrderProductId,
        	[DocumentTypeId],
        	[DocumentFormat],
        	[DocumentDescription],
        	[DocumentBlob],
        	[CreatedDate]
			)
			SELECT
				#tmpOrderDocument.[OrderId],
				#tmpOrderDocument.[OrderProductId],
				#tmpOrderDocument.[DocumentTypeId],
				#tmpOrderDocument.[FileFormat],
				#tmpOrderDocument.[DocumentDescription],
				#tmpOrderDocument.[FileSrc],
				GETDATE()[CreatedDate]
				FROM #tmpOrderDocument
				
			
			PRINT N'Insert OrderDocument'

			 SET @OrderDocument = @@IDENTITY




    
	 SELECT @OrderDocument as OrderDocument FOR XML RAW('Json'),ELEMENTS
    
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
