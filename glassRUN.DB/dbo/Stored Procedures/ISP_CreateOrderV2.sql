
CREATE PROCEDURE [dbo].[ISP_CreateOrderV2] --'<Json><EnquiryId>1</EnquiryId><ShipTo>525</ShipTo><SoldTo>547</SoldTo><OrderType>SO</OrderType><TruckSizeId>15</TruckSizeId><ExpectedTimeOfDelivery>27/10/2018</ExpectedTimeOfDelivery><PromisedDate>27/10/2018</PromisedDate><IsRecievingLocationCapacityExceed>0</IsRecievingLocationCapacityExceed><CurrentState>1</CurrentState><NumberOfPalettes>8.00</NumberOfPalettes><TruckWeight>7.16</TruckWeight><SourceReferenceNumber>INQ000001</SourceReferenceNumber><DeliveryLocationCode></DeliveryLocationCode><CompanyMnemonic></CompanyMnemonic><OrderTime></OrderTime><OrderDate></OrderDate><OrderProductList><ProductCode>55909001</ProductCode><ProductType>9</ProductType><ProductQuantity>8.00</ProductQuantity><UnitPrice>0.0000</UnitPrice><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.0000</DepositeAmount><ItemType>0</ItemType></OrderProductList><OrderProductList><ProductCode>65801001</ProductCode><ProductType>9</ProductType><ProductQuantity>70.00</ProductQuantity><UnitPrice>636364.0000</UnitPrice><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.0000</DepositeAmount><ItemType>32</ItemType></OrderProductList><OrderProductList><ProductCode>65801011</ProductCode><ProductType>9</ProductType><ProductQuantity>410.00</ProductQuantity><UnitPrice>636364.0000</UnitPrice><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.0000</DepositeAmount><ItemType>32</ItemType></OrderProductList><Field3>26/10/2018 00:00:00</Field3><JdeBatchGeneratorId>5</JdeBatchGeneratorId><OrderedBy>OM</OrderedBy><OrderTakenBy>OM</OrderTakenBy><CreatedBy>8</CreatedBy><ServicesAction>GetOrderNumberFromThirthParty</ServicesAction><ReferenceNumber>2016273179</ReferenceNumber></Json>'
@xmlDoc xml
AS 
 BEGIN 
 SET ARITHABORT ON 
 DECLARE @TranName NVARCHAR(255) 
 DECLARE @ErrMsg NVARCHAR(2048) 
 DECLARE @ErrSeverity INT; 
 DECLARE @intPointer INT; 
 DECLARE @orderId bigint;
Declare @enquiryId bigint;
Declare @CreatedBy bigint;
Declare @CollectionId bigint=0
Declare @DestinationId bigint=0
Declare @TruckSizeId bigint=0
Declare @CompanyId bigint=0
Declare @CarrierNumber nvarchar(100)='0'
 SET @ErrSeverity = 15;


  BEGIN TRY
  BEGIN TRAN
   EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


  select * into #tmpOrder
           FROM  OPENXML(@intpointer, 'Order', 2) WITH ( 
		   [CompanyId] bigint,
		  [CompanyCode] nvarchar(250) ,
		  [OrderNumber] nvarchar(100) ,
		  [EnquiryId] bigint,
		  [PickDateTime] datetime ,
		  [ExpectedTimeOfDelivery] datetime ,
		  [CarrierETA] datetime ,
		  [CarrierETD] datetime ,
		  [OrderDate] datetime ,
		  [TruckSizeId] bigint,
		  [SoldTo] bigint,
		  [SoldToCode] nvarchar(250) ,
		  [SoldToName] nvarchar(250) ,
		  [ShipTo] bigint,
		  [ShipToCode] nvarchar(250) ,
		  [ShipToName] nvarchar(250) ,
		  [PrimaryAddressId] bigint,
		  [SecondaryAddressId] bigint,
		  [PrimaryAddress] nvarchar(500) ,
		  [SecondaryAddress] nvarchar(500) ,
		  [ModeOfDelivery] nvarchar(200) ,
		  [OrderType] nvarchar(200) ,
		  [PurchaseOrderNumber] nvarchar(200) ,
		  [SalesOrderNumber] nvarchar(200) ,
		  [PickNumber] nvarchar(200) ,
		  [Remarks] nvarchar(max) ,
		  [PreviousState] bigint,
		  [CurrentState] bigint,
		  [NextState] bigint,
		  [IsRecievingLocationCapacityExceed] bit ,
		  [IsPickConfirmed] bit ,
		  [IsPrintPickSlip] bit ,
		  [IsSTOTUpdated] bit ,
		  [StockLocationId] nvarchar(50) ,
		  [CreatedBy] bigint ,
		  [CreatedDate] datetime ,
		  [ModifiedBy] bigint,
		  [ModifiedDate] datetime ,
		  [IsActive] bit ,
		  [SequenceNo] bigint,
		  [CarrierNumber] nvarchar(50) ,
		  [CarrierCode] nvarchar(250) ,
		  [CarrierName] nvarchar(250) ,
		  [PalletSpace] decimal(18, 2) ,
		  [NumberOfPalettes] decimal(18, 2) ,
		  [TruckWeight] decimal(18, 2) ,
		  [Description1] nvarchar(500) ,
		  [Description2] nvarchar(500) ,
		  [OrderedBy] nvarchar(50) ,
		  [GratisCode] nvarchar(50) ,
		  [Province] nvarchar(50) ,
		  [InvoiceNumber] nvarchar(150) ,
		  [Field1] nvarchar(500) ,
		  [Field2] nvarchar(500) ,
		  [Field3] nvarchar(500) ,
		  [Field4] nvarchar(500) ,
		  [Field5] nvarchar(500) ,
		  [Field6] nvarchar(500) ,
		  [Field7] nvarchar(500) ,
		  [Field8] nvarchar(500) ,
		  [Field9] nvarchar(500) ,
		  [Field10] nvarchar(500) ,
		  [LoadNumber] nvarchar(500) ,
		  [ReferenceNumber] nvarchar(100) ,
		  [HoldStatus] nvarchar(150) ,
		  [RedInvoiceNumber] nvarchar(200) ,
		  [SI] nvarchar(250) ,
		  [OI] nvarchar(250) ,
		  [ReferenceForSIOI] nvarchar(250) ,
		  [IsSIOI] bigint,
		  [IsSendToWMS] bit ,
		  [ParentOrderId] bigint,
		  [IsInventoryTransfer] bit ,
		  [DiscountPercent] decimal(18, 2) ,
		  [DiscountAmount] decimal(18, 2) ,
		  [TotalDiscountAmount] decimal(18, 2) ,
		  [TruckBranchPlantLocationId] bigint,
		  [TotalAmount] decimal(18, 2) ,
		  [PresellerCode] nvarchar(100) ,
		  [PresellerName] nvarchar(500) ,
		  [IsLockFromWMS] bigint,
		  [IsVatIntegrationProcessed] bit ,
		  [TotalDepositeAmount] decimal(18, 2) ,
		  [TotalTaxAmount] decimal(18, 2) ,
		  [TotalQuantity] decimal(18, 2) ,
		  [TotalPrice] decimal(18, 2) ,
		  [TotalVolume] decimal(18, 2) ,
		  [TotalWeight] decimal(18, 2) ,
		  [NumberOfCrate] bigint,
		  [PaymentTerm] bigint,
		  [IsSelfCollect] bit ,
		  [BillTo] bigint,
		  [BillToCode] nvarchar(200) ,
		  [BillToName] nvarchar(200) ,
		  [CollectionLocationId] bigint,
		  [CollectionLocationCode] nvarchar(200) ,
		  [CollectionLocationName] nvarchar(200) ,
		  [TruckSize] nvarchar(50)  )tmp 


    select * into #tmpOrderProduct
   FROM OPENXML(@intpointer,'Order/OrderProductList',2)
        WITH
        (
		[CompanyId] bigint,
	[CompanyCode] nvarchar(250) ,
	[OrderId] bigint ,
	[OrderNumber] nvarchar(100) ,
	[ProductCode] nvarchar(200) ,
	[ProductName] nvarchar(250) ,
	[ParentProductCode] nvarchar(250) ,
	[ProductType] nvarchar(200) ,
	[ProductQuantity] decimal(10, 2) ,
	[UnitPrice] decimal(18, 4) ,
	[TotalUnitPrice] decimal(18, 4) ,
	[EffectiveDate] datetime ,
	[DepositeAmount] decimal(10, 2) ,
	[ShippableQuantity] decimal(10, 2) ,
	[BackOrderQuantity] decimal(10, 2) ,
	[CancelledQuantity] decimal(10, 2) ,
	[ReturnQuantity] decimal(10, 2) ,
	[AssociatedOrder] nvarchar(100) ,
	[ItemType] bigint,
	[Remarks] nvarchar(max) ,
	[CreatedBy] bigint ,
	[CreatedDate] datetime ,
	[ModifiedBy] bigint,
	[ModifiedDate] datetime ,
	[IsActive] bit ,
	[LineNumber] bigint,
	[InvoiceNumber] nvarchar(150) ,
	[Field1] nvarchar(500) ,
	[Field2] nvarchar(500) ,
	[Field3] nvarchar(500) ,
	[Field4] nvarchar(500) ,
	[Field5] nvarchar(500) ,
	[Field6] nvarchar(500) ,
	[Field7] nvarchar(500) ,
	[Field8] nvarchar(500) ,
	[Field9] nvarchar(500) ,
	[Field10] nvarchar(500) ,
	[DiscountPercent] decimal(18, 2) ,
	[DiscountAmount] decimal(18, 2) ,
	[IsProductShipConfirmed] bit ,
	[ReferenceOrderId] bigint,
	[ReferenceOrderProductId] bigint,
	[OrderProductGuid] nvarchar(350) ,
	[PalletNumber] nvarchar(250) ,
	[ReplacementParentProductId] bigint,
	[IsReplaceable] bit ,
	[LotNumber] nvarchar(250) ,
	[CollectedQuantity] decimal(18, 2) ,
	[DeliveredQuantity] decimal(18, 2) ,
	[LastStatus] bigint,
	[NextStatus] bigint,
	[StockLocationCode] nvarchar(250) ,
	[StockLocationName] nvarchar(250) ,
	[TotalVolume] decimal(18, 2) ,
	[TotalWeight] decimal(18, 2) ,
	[IsGRN] bit ,
	[SignalValue] bigint,
	[PackingItemCount] decimal(18, 2) ,
	[PackingItemCode] nvarchar(200) ,
	[IsPackingItem] bit, 
    [UOM] varchar(50)

           )tmp

		INSERT INTO [dbo].[Order]
           ([CompanyId]
           ,[CompanyCode]
           ,[OrderNumber]
           ,[EnquiryId]
           ,[PickDateTime]
           ,[ExpectedTimeOfDelivery]
           ,[CarrierETA]
           ,[CarrierETD]
           ,[OrderDate]
           ,[TruckSizeId]
           ,[SoldTo]
           ,[SoldToCode]
           ,[SoldToName]
           ,[ShipTo]
           ,[ShipToCode]
           ,[ShipToName]
           ,[PrimaryAddressId]
           ,[SecondaryAddressId]
           ,[PrimaryAddress]
           ,[SecondaryAddress]
           ,[ModeOfDelivery]
           ,[OrderType]
           ,[PurchaseOrderNumber]
           ,[SalesOrderNumber]
           ,[PickNumber]
           ,[Remarks]
           ,[PreviousState]
           ,[CurrentState]
           ,[NextState]
           ,[IsRecievingLocationCapacityExceed]
           ,[IsPickConfirmed]
           ,[IsPrintPickSlip]
           ,[IsSTOTUpdated]
           ,[StockLocationId]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[ModifiedBy]
           ,[ModifiedDate]
           ,[IsActive]
           ,[SequenceNo]
           ,[CarrierNumber]
           ,[CarrierCode]
           ,[CarrierName]
           ,[PalletSpace]
           ,[NumberOfPalettes]
           ,[TruckWeight]
           ,[Description1]
           ,[Description2]
           ,[OrderedBy]
           ,[GratisCode]
           ,[Province]
           ,[InvoiceNumber]
           ,[Field1]
           ,[Field2]
           ,[Field3]
           ,[Field4]
           ,[Field5]
           ,[Field6]
           ,[Field7]
           ,[Field8]
           ,[Field9]
           ,[Field10]
           ,[LoadNumber]
           ,[ReferenceNumber]
           ,[HoldStatus]
           ,[RedInvoiceNumber]
           ,[SI]
           ,[OI]
           ,[ReferenceForSIOI]
           ,[IsSIOI]
           ,[IsSendToWMS]
           ,[ParentOrderId]
           ,[IsInventoryTransfer]
           ,[DiscountPercent]
           ,[DiscountAmount]
           ,[TotalDiscountAmount]
           ,[TruckBranchPlantLocationId]
           ,[TotalAmount]
           ,[PresellerCode]
           ,[PresellerName]
           ,[IsLockFromWMS]
           ,[IsVatIntegrationProcessed]
           ,[TotalDepositeAmount]
           ,[TotalTaxAmount]
           ,[TotalQuantity]
           ,[TotalPrice]
           ,[TotalVolume]
           ,[TotalWeight]
           ,[NumberOfCrate]
           ,[PaymentTerm]
           ,[IsSelfCollect]
           ,[BillTo]
           ,[BillToCode]
           ,[BillToName]
           ,[CollectionLocationId]
           ,[CollectionLocationCode]
           ,[CollectionLocationName]
           ,[TruckSize])

		   Select tmp.[CompanyId]
           ,tmp.[CompanyCode]
           ,tmp.[OrderNumber]
           ,tmp.[EnquiryId]
           ,tmp.[PickDateTime]
           ,tmp.[ExpectedTimeOfDelivery]
           ,tmp.[CarrierETA]
           ,tmp.[CarrierETD]
           ,tmp.[OrderDate]
           ,tmp.[TruckSizeId]
           ,tmp.[SoldTo]
           ,tmp.[SoldToCode]
           ,tmp.[SoldToName]
           ,tmp.[ShipTo]
           ,tmp.[ShipToCode]
           ,tmp.[ShipToName]
           ,tmp.[PrimaryAddressId]
           ,tmp.[SecondaryAddressId]
           ,tmp.[PrimaryAddress]
           ,tmp.[SecondaryAddress]
           ,tmp.[ModeOfDelivery]
           ,tmp.[OrderType]
           ,tmp.[PurchaseOrderNumber]
           ,tmp.[SalesOrderNumber]
           ,tmp.[PickNumber]
           ,tmp.[Remarks]
           ,tmp.[PreviousState]
           ,tmp.[CurrentState]
           ,tmp.[NextState]
           ,tmp.[IsRecievingLocationCapacityExceed]
           ,tmp.[IsPickConfirmed]
           ,tmp.[IsPrintPickSlip]
           ,tmp.[IsSTOTUpdated]
           ,tmp.[StockLocationId]
           ,tmp.[CreatedBy]
           ,GETDATE()
           ,NULL
           ,NULL
           ,tmp.[IsActive]
           ,tmp.[SequenceNo]
           ,tmp.[CarrierNumber]
           ,tmp.[CarrierCode]
           ,tmp.[CarrierName]
           ,tmp.[PalletSpace]
           ,tmp.[NumberOfPalettes]
           ,tmp.[TruckWeight]
           ,tmp.[Description1]
           ,tmp.[Description2]
           ,tmp.[OrderedBy]
           ,tmp.[GratisCode]
           ,tmp.[Province]
           ,tmp.[InvoiceNumber]
           ,tmp.[Field1]
           ,tmp.[Field2]
           ,tmp.[Field3]
           ,tmp.[Field4]
           ,tmp.[Field5]
           ,tmp.[Field6]
           ,tmp.[Field7]
           ,tmp.[Field8]
           ,tmp.[Field9]
           ,tmp.[Field10]
           ,tmp.[LoadNumber]
           ,tmp.[ReferenceNumber]
           ,tmp.[HoldStatus]
           ,tmp.[RedInvoiceNumber]
           ,tmp.[SI]
           ,tmp.[OI]
           ,tmp.[ReferenceForSIOI]
           ,tmp.[IsSIOI]
           ,tmp.[IsSendToWMS]
           ,tmp.[ParentOrderId]
           ,tmp.[IsInventoryTransfer]
           ,tmp.[DiscountPercent]
           ,tmp.[DiscountAmount]
           ,tmp.[TotalDiscountAmount]
           ,tmp.[TruckBranchPlantLocationId]
           ,tmp.[TotalAmount]
           ,tmp.[PresellerCode]
           ,tmp.[PresellerName]
           ,tmp.[IsLockFromWMS]
           ,tmp.[IsVatIntegrationProcessed]
           ,tmp.[TotalDepositeAmount]
           ,tmp.[TotalTaxAmount]
           ,tmp.[TotalQuantity]
           ,tmp.[TotalPrice]
           ,tmp.[TotalVolume]
           ,tmp.[TotalWeight]
           ,tmp.[NumberOfCrate]
           ,tmp.[PaymentTerm]
           ,tmp.[IsSelfCollect]
           ,tmp.[BillTo]
           ,tmp.[BillToCode]
           ,tmp.[BillToName]
           ,tmp.[CollectionLocationId]
           ,tmp.[CollectionLocationCode]
           ,tmp.[CollectionLocationName]
           ,tmp.[TruckSize] from #tmpOrder tmp
						
	 SELECT  @orderId  = @@IDENTITY  

	 INSERT INTO [dbo].[OrderProduct]
           ([CompanyId]
           ,[CompanyCode]
           ,[OrderId]
           ,[OrderNumber]
           ,[ProductCode]
           ,[ProductName]
           ,[ParentProductCode]
           ,[ProductType]
           ,[ProductQuantity]
           ,[UnitPrice]
           ,[TotalUnitPrice]
           ,[EffectiveDate]
           ,[DepositeAmount]
           ,[ShippableQuantity]
           ,[BackOrderQuantity]
           ,[CancelledQuantity]
           ,[ReturnQuantity]
           ,[AssociatedOrder]
           ,[ItemType]
           ,[Remarks]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[ModifiedBy]
           ,[ModifiedDate]
           ,[IsActive]
           ,[LineNumber]
           ,[InvoiceNumber]
           ,[Field1]
           ,[Field2]
           ,[Field3]
           ,[Field4]
           ,[Field5]
           ,[Field6]
           ,[Field7]
           ,[Field8]
           ,[Field9]
           ,[Field10]
           ,[DiscountPercent]
           ,[DiscountAmount]
           ,[IsProductShipConfirmed]
           ,[ReferenceOrderId]
           ,[ReferenceOrderProductId]
           ,[OrderProductGuid]
           ,[PalletNumber]
           ,[ReplacementParentProductId]
           ,[IsReplaceable]
           ,[LotNumber]
           ,[CollectedQuantity]
           ,[DeliveredQuantity]
           ,[LastStatus]
           ,[NextStatus]
           ,[StockLocationCode]
           ,[StockLocationName]
           ,[TotalVolume]
           ,[TotalWeight]
           ,[IsGRN]
           ,[SignalValue]
           ,[PackingItemCount]
           ,[PackingItemCode]
           ,[IsPackingItem]
           ,[UOM])
		Select tmp.[CompanyId]
           ,tmp.[CompanyCode]
           ,@orderId
           ,tmp.[OrderNumber]
           ,tmp.[ProductCode]
           ,tmp.[ProductName]
           ,tmp.[ParentProductCode]
           ,tmp.[ProductType]
           ,tmp.[ProductQuantity]
           ,tmp.[UnitPrice]
           ,tmp.[TotalUnitPrice]
           ,tmp.[EffectiveDate]
           ,tmp.[DepositeAmount]
           ,tmp.[ShippableQuantity]
           ,tmp.[BackOrderQuantity]
           ,tmp.[CancelledQuantity]
           ,tmp.[ReturnQuantity]
           ,tmp.[AssociatedOrder]
           ,tmp.[ItemType]
           ,tmp.[Remarks]
           ,tmp.[CreatedBy]
           ,GETDATE()
           ,NULL
           ,NULL
           ,tmp.[IsActive]
           ,tmp.[LineNumber]
           ,tmp.[InvoiceNumber]
           ,tmp.[Field1]
           ,tmp.[Field2]
           ,tmp.[Field3]
           ,tmp.[Field4]
           ,tmp.[Field5]
           ,tmp.[Field6]
           ,tmp.[Field7]
           ,tmp.[Field8]
           ,tmp.[Field9]
           ,tmp.[Field10]
           ,tmp.[DiscountPercent]
           ,tmp.[DiscountAmount]
           ,tmp.[IsProductShipConfirmed]
           ,tmp.[ReferenceOrderId]
           ,tmp.[ReferenceOrderProductId]
           ,tmp.[OrderProductGuid]
           ,tmp.[PalletNumber]
           ,tmp.[ReplacementParentProductId]
           ,tmp.[IsReplaceable]
           ,tmp.[LotNumber]
           ,tmp.[CollectedQuantity]
           ,tmp.[DeliveredQuantity]
           ,tmp.[LastStatus]
           ,tmp.[NextStatus]
           ,tmp.[StockLocationCode]
           ,tmp.[StockLocationName]
           ,tmp.[TotalVolume]
           ,tmp.[TotalWeight]
           ,tmp.[IsGRN]
           ,tmp.[SignalValue]
           ,tmp.[PackingItemCount]
           ,tmp.[PackingItemCode]
           ,tmp.[IsPackingItem],tmp.[UOM] from #tmpOrderProduct tmp

				--------------------------New Logic-----------------------------

				Select @enquiryId=tmp.[EnquiryId],@CreatedBy=tmp.[CreatedBy] from #tmpOrder tmp

				--update [Order] set [OrderNumber] =(Select Top 1 Replace(EnquiryAutoNumber,'INQ','') from enquiry where EnquiryId=@enquiryId) where EnquiryId=@enquiryId


				-----------add event notfication for   order created --------

				INSERT INTO [EventNotification] ( [EventMasterId], [EventCode], [ObjectId], [ObjectType], [IsActive], [CreatedDate], [CreatedBy] ) 
			     select (select EventMasterId  From EventMaster where EventCode='OrderCreated' and IsActive=1 ), 'OrderCreated', @orderId , 'Order',1 , GETDATE(), @CreatedBy 
				------


				------ insert in notes from enquiry table -----------
				INSERT INTO [dbo].[Notes]

						([RoleId] ,[ObjectId],[ObjectType],[Note],[IsActive],[CreatedBy],[CreatedDate])
						SELECT tmp1.[RoleId], @orderId, 1221, tmp1.[Note], 1,tmp1.[CreatedBy],GETDATE() 	
						FROM OPENXML(@intpointer,'Order/NoteList',2)
						WITH ([RoleId] bigint, [ObjectId] bigint,[ObjectType] bigint,[Note] NVARCHAR(max),[CreatedBy] bigint)tmp1



						-------------Update OrderStatus-----------------------------

				SELECT ROW_NUMBER() OVER(ORDER BY OrderProductId asc) AS RowId, * INTO #newOrderProducttemp FROM OrderProduct WHERE OrderId=@orderId  and  ISNULL(ItemType,0) in ( 0,32)
				DECLARE @site_value INT;
				DECLARE @site_RowCount INT;
				DECLARE @tempOrderProductId BIGINT;

				SET @site_value = 1;
				SET @site_RowCount=(SELECT COUNT(*) FROM #newOrderProducttemp)
				WHILE @site_value <= @site_RowCount
				BEGIN
				SET @tempOrderProductId=(SELECT #newOrderProducttemp.OrderProductId FROM #newOrderProducttemp WHERE RowId=@site_value)

				---update  SequenceNo i n it.
				update OrderProduct set LineNumber=@site_value*1000 where  OrderProductId=@tempOrderProductId;

				SET @site_value = @site_value + 1;
			
				-------------End OrderStatus-----------------------------






				--------------Insert inot OrderProductLotInfromation--------
				INSERT INTO [dbo].[OrderProductLotDetails]
						   (OrderProductId
						   ,OrderId
						   ,ProductCode
						   ,Quantity)
				Select op.OrderProductId,op.OrderId,op.ProductCode,op.ProductQuantity from OrderProduct op where 
				OrderId=@orderId
				and NOT EXISTS
				(SELECT opld.OrderProductLotDetailsId FROM [OrderProductLotDetails] opld WHERE op.OrderProductId=opld.OrderProductId and op.OrderId=opld.OrderId);
				--------------------------------------------------------------

				
				--------------------------------------------Allocation the transporter----------------------------------------------------------------------------
		
				set @TruckSizeId=0
				
				set @CompanyId=0
				set @CarrierNumber ='0'
				Declare @SettingValue nvarchar(10)='0'

				Select @SettingValue=SettingValue from SettingMaster where SettingParameter='AutoAllocateCarrierNumber'

				if @SettingValue='1'
				Begin
				Select @CollectionId=isnull(StockLocationId,0),@TruckSizeId=isnull(TruckSizeId,0),@DestinationId=isnull(ShipTo,0),@CompanyId=isnull(CompanyId,0) from [Order] where OrderId=@orderId

				Select @CarrierNumber=CarrierNumber from (select top 1 CarrierNumber, COUNT(CarrierNumber) OVER() AS NumberOfRecord from [Route] 
				where isnull(OriginId,0)=@CollectionId 
				and isnull(TruckSizeId,0)=@TruckSizeId 
				and isnull(DestinationId,0)=@DestinationId 
				and isnull(CompanyId,0)=@CompanyId 
				) as tc
				Where NumberOfRecord =1
				END
			
-------------------------------------------------------END--------------------------------------------------------------------------------
	

    SELECT @orderId as OrderId,'200' as Status
	END
    COMMIT;  
    END TRY
    BEGIN CATCH
	ROLLBACK;
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
