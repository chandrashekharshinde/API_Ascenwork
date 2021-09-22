CREATE PROCEDURE [dbo].[SSP_UpdatePlateNumberAndStatus] --'<Json><ServicesAction>AllocatePlateNumberToOrder</ServicesAction><SalesOrderNumber>So0001</SalesOrderNumber><PlateNumber>1234</PlateNumber></Json>'
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



		DECLARE @SalesOrderNumber nvarchar(150)
		DECLARE @plateNumber nvarchar(150)
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
	
		SELECT @SalesOrderNumber = tmp.[SalesOrderNumber],
				@plateNumber=tmp.[PlateNumber]
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[SalesOrderNumber] NVARCHAR(50),
			[PlateNumber] nvarchar(50)
			)tmp 


			SELECT OrderId,OrderNumber,TruckSizeId,ROW_NUMBER() OVER (ORDER BY OrderId) AS rownum INTO #tmpTable FROM dbo.[Order] WHERE SalesOrderNumber=@SalesOrderNumber	
			
			
			DECLARE @totalRecords BIGINT
		DECLARE @RecordCount BIGINT
		DECLARE @orderId bigint
		SELECT @RecordCount = 1
		SELECT @totalRecords = COUNT([OrderNumber]) FROM #tmpTable
		WHILE (@RecordCount <= @totalRecords)
		BEGIN
			SET @orderId=(SELECT OrderId FROM #tmpTable WHERE rownum=@RecordCount)
				INSERT INTO [dbo].[orderMovement]  ([OrderId],LocationType,[IsActive],[CreatedBy],[CreatedDate])
				SELECT  	#tmpTable.OrderId,2,1,1,getdate()
				FROM #tmpTable WHERE rownum=@RecordCount
				DECLARE @orderMovementId bigint
				SELECT  @orderMovementId  = @@IDENTITY 


				INSERT INTO [dbo].[OrderLogistics]  ([OrderMovementId],[TruckPlateNumber],[IsActive],[CreatedBy],[CreatedDate])
				SELECT  	@orderMovementId,@plateNumber,1,1,getdate()
				
				DECLARE @OrderLogisticsId bigint
				SELECT  @OrderLogisticsId  = @@IDENTITY 


		SELECT OrderProductId ,ROW_NUMBER() OVER (ORDER BY OrderProductId) AS rownum1 INTO #tmpOrderProduct FROM dbo.[OrderProduct] WHERE OrderId=@orderId	
		DECLARE @orderProductId bigint
		DECLARE @totalRecords1 BIGINT
		DECLARE @RecordCount1 BIGINT
		SELECT @RecordCount1 = 1
		SELECT @totalRecords1 = COUNT(OrderProductId) FROM #tmpOrderProduct
			WHILE (@RecordCount1 <= @totalRecords1)
		BEGIN
		SET @orderProductId=(SELECT OrderProductId FROM #tmpOrderProduct WHERE rownum1=@totalRecords1)

			INSERT INTO [dbo].OrderProductMovement  (OrderId,OrderProductId,OrderMovementId,[IsActive],[CreatedBy],[CreatedDate])
			Select	@orderId ,@orderProductId,@orderMovementId,1,1,GETDATE()
				FROM #tmpOrderProduct WHERE rownum1=@totalRecords1
				set @RecordCount1=@RecordCount1+1
		END

				DROP TABLE #tmpOrderProduct
			

set @RecordCount=@RecordCount+1
		END	

		
		DROP TABLE #tmpTable
			
			
	


        
     
        

	
    
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
