CREATE PROCEDURE [dbo].[USP_UpdatePickingNumberDetails]-- '<Json><ServicesAction>UpdatePlateNumberDetails</ServicesAction><SalesOrderNumber>So0001</SalesOrderNumber><PlateNumber>fhfhf</PlateNumber><LocationType>2</LocationType></Json>'
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
		DECLARE @pickingDate nvarchar(150)
		DECLARE @plateNumber nvarchar(150)
		DECLARE @locationType nvarchar(150)
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
	
		SELECT @SalesOrderNumber = tmp.[SalesOrderNumber],
				@pickingDate=tmp.[PickingDate],
				@plateNumber=tmp.[PlateNumber],
				@locationType=tmp.[LocationType]
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[SalesOrderNumber] NVARCHAR(50),
			[PickingDate] nvarchar(50),
			[PlateNumber] nvarchar(50),
			[LocationType] nvarchar(50)
			)tmp 


			SELECT TOP 1 OrderId,OrderNumber,TruckSizeId,ROW_NUMBER() OVER (ORDER BY OrderId) AS rownum INTO #tmpTable FROM dbo.[Order] WHERE SalesOrderNumber=@SalesOrderNumber			
			
	
			DECLARE @orderId bigint	
			SET @orderId=(SELECT OrderId FROM #tmpTable)
			UPDATE [OrderLogistics] SET [TruckPlateNumber]=@plateNumber WHERE ordermovementid = (SELECT ordermovementid FROM OrderMovement WHERE OrderId=@orderId AND LocationType=@locationType)
					
				
		

	
    
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
