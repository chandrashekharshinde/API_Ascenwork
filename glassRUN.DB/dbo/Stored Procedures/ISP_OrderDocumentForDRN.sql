
create PROCEDURE [dbo].[ISP_OrderDocumentForDRN]
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
			FROM OPENXML(@intpointer,'OrderDocument',2)
			WITH 
			(		
				 [OrderId] bigint,
			OrderProductId BIGINT,
            [DocumentTypeId] int,
            [DocumentFormat] nvarchar(50),
            [DocumentBlob] VARBINARY(max),
            [CreatedDate] DATETIME,
			[DocumentType] VARCHAR(max)
			)tmp



 DECLARE @OrderDocument BIGINT
 

 INSERT INTO [dbo].[OrderDocument]
			(
				[OrderId],
			OrderProductId,
        	[DocumentTypeId],
        	[DocumentFormat],
        	[DocumentBlob],
        	[CreatedDate]
			)
			SELECT
				#tmpOrderDocument.[OrderId],
				#tmpOrderDocument.[OrderProductId],
				(SELECT [dbo].[fn_LookupIdByValue](#tmpOrderDocument.DocumentType)),
				#tmpOrderDocument.DocumentFormat,
				#tmpOrderDocument.DocumentBlob,
				GETDATE()[CreatedDate]
				FROM #tmpOrderDocument
				left	JOIN dbo.OrderDocument od ON 
				 #tmpOrderDocument.[OrderId]=od.OrderId AND 
				  (SELECT [dbo].[fn_LookupIdByValue](#tmpOrderDocument.DocumentType)) = od.DocumentTypeId
			WHERE od.OrderDocumentId IS NULL 
			
			PRINT N'Insert OrderDocument'

			 SET @OrderDocument = @@IDENTITY




 UPDATE dbo.OrderDocument
			 SET CreatedDate=GETDATE(),
			 DocumentBlob =  #tmpOrderDocument.DocumentBlob ,
			 @OrderDocument =dbo.OrderDocument.OrderDocumentId
			FROM #tmpOrderDocument 
			WHERE  #tmpOrderDocument.DocumentType = (SELECT dbo.fn_LookupValueById(dbo.OrderDocument.DocumentTypeId))
			AND #tmpOrderDocument.[OrderId] = OrderDocument.OrderId
			AND dbo.OrderDocument.OrderDocumentId  IS NOT NULL
			PRINT N'update OrderDocument'

			


			DROP TABLE #tmpOrderDocument


      
        
        --Add child table insert procedure when required.
    
    SELECT @OrderDocument
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END