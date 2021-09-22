CREATE PROCEDURE [dbo].[USP_UpdatGateKeeperTruckOutDetails]-- '<Json><OrderId>76097</OrderId><OrderType>SO</OrderType><rownumber>1</rownumber><TotalCount>24</TotalCount><OrderNumber>Or0009</OrderNumber><TotalPrice>393800550.00</TotalPrice><SalesOrderNumber>Or0009</SalesOrderNumber><PurchaseOrderNumber>-</PurchaseOrderNumber><OrderDate>2018-01-19T05:10:05.477Z</OrderDate><DeliveryLocationName>HM-CTY TNHH SX DV TM XNK MINH QUANG</DeliveryLocationName><DeliveryLocation>1111026</DeliveryLocation><CompanyName>HM-CTY TNHH SX DV TM XNK MINH QUANG</CompanyName><ExpectedTimeOfDelivery>01/01/1900</ExpectedTimeOfDelivery><ReceivedCapacityPalettes>280</ReceivedCapacityPalettes><Capacity>450</Capacity><EnquiryAutoNumber>INQ010128</EnquiryAutoNumber><CurrentState>1104</CurrentState><Status>Truck In</Status><Class>AwaitingSONumber_Status</Class><OrderProductList><OrderProductId>77363</OrderProductId><OrderId>76097</OrderId><ProductCode>65205001</ProductCode><ProductType>9</ProductType><ProductQuantity>1100.00</ProductQuantity><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>0</UsedQuantityInOrder><ProductAvailableQuantity>-131</ProductAvailableQuantity><IsItemAvailableInStock>false</IsItemAvailableInStock></OrderProductList><OrderProductList><OrderProductId>77364</OrderProductId><OrderId>76097</OrderId><ProductCode>55909001</ProductCode><ProductType>9</ProductType><ProductQuantity>10.00</ProductQuantity><AssociatedOrder>0</AssociatedOrder><UsedQuantityInOrder>0</UsedQuantityInOrder><ProductAvailableQuantity>435</ProductAvailableQuantity></OrderProductList><ShipTo>256</ShipTo><SoldTo>191</SoldTo><StockLocationId>13</StockLocationId><BranchPlantName>6410</BranchPlantName><TruckInPlateNumberCheck>false</TruckInPlateNumberCheck><TruckOutPlateNumberCheck>false</TruckOutPlateNumberCheck><PreviousPlateNumber>178987</PreviousPlateNumber><TruckInPlateNumber>11111111</TruckInPlateNumber><PreviousTruckInPlateNumber>178987</PreviousTruckInPlateNumber><TruckOutPlateNumber>178987</TruckOutPlateNumber><PlateNumber>77557575</PlateNumber><TruckInDateTime>2018-01-30T08:22:01.07Z</TruckInDateTime><TruckOutDateTime>2018-01-30T08:23:58.443Z</TruckOutDateTime><EmptiesLimit>72000</EmptiesLimit><ActualEmpties>14882</ActualEmpties><TruckSizeId>36</TruckSizeId><TruckSize>H10</TruckSize><CompanyNameValue>HM</CompanyNameValue><IsAvailableStock>false</IsAvailableStock><IsGratisItemAvailable>false</IsGratisItemAvailable><LocationType>1</LocationType><UserId>285</UserId></Json>'
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
  DECLARE @ShipmentNumber nvarchar(250)
  Declare @orderLogistics bigint
  Declare @orderMovementId bigint
  declare @DeliveryPersonnelId nvarchar(250)
  DECLARE @userId bigint
  DECLARE @remark nvarchar(500)
   DECLARE @LoadNumber nvarchar(250)
   DECLARE @field1 nvarchar(50)
   Declare @PlateNumberBy nvarchar(100)

   EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
 
  SELECT @SalesOrderNumber = tmp.[SalesOrderNumber],
    @pickingDate=tmp.[PickingDate],
    @plateNumber=tmp.[PlateNumber],
    @locationType=tmp.[LocationType],
     @ShipmentNumber=tmp.[ShipmentNumber],
      @LoadNumber=tmp.[LoadNumber],
      @DeliveryPersonnelId = tmp.[DeliveryPersonnelId],
      @userId=tmp.UserId,
      @remark=tmp.Remarks,
    @PlateNumberBy = tmp.[PlateNumberBy],
	@field1=tmp.[Field1]

   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [SalesOrderNumber] NVARCHAR(50),
   [PickingDate] nvarchar(50),
   [PlateNumber] nvarchar(50),
   [LocationType] nvarchar(50),
   [ShipmentNumber] nvarchar(250),
   [LoadNumber] nvarchar(50),
   [DeliveryPersonnelId] nvarchar(250),
   UserId bigint,
   Remarks nvarchar(500),
   [PlateNumberBy] nvarchar(100),
   [Field1] nvarchar(100)

   )tmp 
     

DECLARE @orderId BIGINT
Declare @truckOutDateTime datetime
   SET @orderId=(SELECT OrderId FROM [ORDER] WHERE SalesOrderNumber=@SalesOrderNumber)
   SET @orderMovementId=(SELECT ordermovementid FROM OrderMovement WHERE OrderId=@orderId AND LocationType=@locationType)
   SET @orderLogistics=(SELECT OrderLogisticsId FROM [OrderLogistics] WHERE ordermovementid=(SELECT ordermovementid FROM OrderMovement WHERE OrderId=@orderId AND LocationType=@locationType))
   if @field1='SCO'
   BEGIN
   UPDATE [OrderLogistics] SET [TruckOutTime]=GETDATE(),TruckPlateNumber=@plateNumber,DeliveryPersonName=@DeliveryPersonnelId WHERE ordermovementid = (SELECT ordermovementid FROM OrderMovement WHERE OrderId=@orderId AND LocationType=@locationType)
	INSERT INTO [dbo].[OrderLogisticHistory]  ([OrderId],[UserId],[OrderLogisticId],[TruckId],[PlateNumber],
   [TransportVehicleId],[DeliveryPersonName],[OrderMovementId],PlateNumberBy,[Remark],[IsActive],[CreatedBy],[CreatedDate])
   SELECT   @orderId,@userId,@orderLogistics,NULL,@plateNumber,NULL,@DeliveryPersonnelId,@orderMovementId,@PlateNumberBy,@remark,1,1,getdate()
   END
   ELSE
   BEGIN
   UPDATE [OrderLogistics] SET [TruckOutTime]=GETDATE(),TruckPlateNumber=@plateNumber,DeliveryPersonnelId=@DeliveryPersonnelId WHERE ordermovementid = (SELECT ordermovementid FROM OrderMovement WHERE OrderId=@orderId AND LocationType=@locationType)
   UPDATE [OrderMovement] SET DeliveryPersonnelId=@DeliveryPersonnelId WHERE OrderId=@orderId AND LocationType=@locationType
    INSERT INTO [dbo].[OrderLogisticHistory]  ([OrderId],[UserId],[OrderLogisticId],[TruckId],[PlateNumber],
   [TransportVehicleId],[DeliveryPersonnelId],[OrderMovementId],PlateNumberBy,[Remark],[IsActive],[CreatedBy],[CreatedDate])
   SELECT   @orderId,@userId,@orderLogistics,NULL,@plateNumber,NULL,@DeliveryPersonnelId,@orderMovementId,@PlateNumberBy,@remark,1,1,getdate()

   END
   --UPDATE [OrderLogistics] SET [TruckOutTime]=GETDATE(),TruckPlateNumber=@plateNumber,DeliveryPersonnelId=@DeliveryPersonnelId WHERE ordermovementid = (SELECT ordermovementid FROM OrderMovement WHERE OrderId=@orderId AND LocationType=@locationType)


  


     update [Order] set CurrentState=1105 where OrderId=@orderId
      
   Select @truckOutDateTime=TruckOutTime from [OrderLogistics] where OrderMovementId in (SELECT top 1 ordermovementid FROM OrderMovement WHERE OrderId=@orderId AND LocationType=@locationType)
     SELECT @truckOutDateTime as TruckOutDateTime FOR XML RAW('Json'),ELEMENTS
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
