Create PROCEDURE [dbo].[USP_UpdatReceivingLocationCapacity] --'<Json><TotalCount>2</TotalCount><SalesOrderNumber>So0001</SalesOrderNumber><ShipTo>DeliveryLocation1</ShipTo><SoldTo>DeliveryLocation1</SoldTo><TruckSize>TZ1</TruckSize><ExpectedTimeOfDelivery>2017-07-07T00:00:00</ExpectedTimeOfDelivery><CurrentState>4</CurrentState><_x0024__x0024_hashKey>object:134</_x0024__x0024_hashKey><PlateNumber>54466464</PlateNumber></Json>'
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



		DECLARE @deliveryLocationId bigint
		DECLARE @capacity decimal(18,2)
		
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
	
		SELECT @deliveryLocationId = tmp.[DeliveryLocationId],
				@capacity=tmp.[Capacity]
				
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[DeliveryLocationId] bigint,
			[Capacity] decimal(18,2)
			
			)tmp 
					


			update DeliveryLocation Set Capacity=@capacity where DeliveryLocationId=@deliveryLocationId
					
					SELECT @deliveryLocationId as DeliveryLocationId FOR XML RAW('Json'),ELEMENTS
		

	
    
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
