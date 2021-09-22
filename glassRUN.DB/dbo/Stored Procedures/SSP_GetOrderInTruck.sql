CREATE PROCEDURE [dbo].[SSP_GetOrderInTruck] --'<Json><ServicesAction>GetOrderInTruck</ServicesAction><StockLocationCode>6432</StockLocationCode><TruckInDeatilsId>0</TruckInDeatilsId></Json>'
@xmlDoc xml 
AS 
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
		Declare @PlateNumber nvarchar(50)
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	SET @ErrSeverity = 15; 

	BEGIN TRY
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

	Select * into #tempTruckInDeatils FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            [PlateNumber] nvarchar(100) ,
			[TruckInDeatilsId] bigint ,
			[DriverName] nvarchar(500) ,
			[StockLocationCode] nvarchar(max),
			[OrderNumber] nvarchar(max)
        )


        
            
        
DECLARE @TruckInDeatilsId BIGINT=0
DECLARE @StockLocationCode nvarchar(max)
DECLARE @OrderNumber nvarchar(max)=''
SELECT @TruckInDeatilsId=tmp.[TruckInDeatilsId],
		@PlateNumber=tmp.[PlateNumber],
		@StockLocationCode=tmp.[StockLocationCode],
		@OrderNumber=tmp.OrderNumber 
		from #tempTruckInDeatils tmp

    
;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT 'true' AS [@json:Array],@TruckInDeatilsId as TruckInDeatilsId,
 [OrderId]
      ,[OrderNumber]
      ,[ModifiedDate]
      ,[TotalPrice]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[OrderDate]
      ,[LocationName]
      ,[DeliveryLocation]
      ,[CompanyName]
      ,[CompanyMnemonic]
      ,[SupplierName]
      ,[SupplierCode]
      ,[CarrierNumberValue]
      ,[BranchPlantName]
      ,[BranchPlantCode]
      ,[DeliveryLocationBranchName]
      ,[PlateNumberData]
      ,[DeliveryPersonName]
      ,[PlateNumber]
      ,[PreviousPlateNumber]
      ,[DriverName]
      ,[CarrierNumber]
      ,[TruckRemark]
      ,[DeliveredDate]
      ,[PlanCollectionDate]
      ,[PlanDeliveryDate]
	  ,[CollectedDate]
     , (select cast ((SELECT  'true' AS [@json:Array]  ,(Select top 1 i.ItemName from Item i where i.ItemCode=t1.ProductCode) as ProductName,  t1.OrderId,t1.OrderProductId,t1.ItemType,ProductCode,isnull(t1.LotNumber,t1.OrderProductId) as LotNumber,isnull(ProductQuantity,0) as Quantity,isnull(CollectedQuantity,0) as CollectedQuantity ,isnull(DeliveredQuantity,0) as DeliveredQuantity
		FROM OrderProduct t1 
		WHERE t1.IsActive=1 and t1.OrderId=o.OrderId
FOR XML path('ProductInfo'),ELEMENTS) AS xml))
FROM [dbo].[OrderGridViewNew] o where 
o.OrderNumber in (Select tid.OrderNumber from TruckInOrder tid where isnull(tid.IsLoadedInTruck,1)=1 and  tid.TruckInDeatilsId=@TruckInDeatilsId)
or o.OrderNumber=@OrderNumber
FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)








  
		EXEC sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END