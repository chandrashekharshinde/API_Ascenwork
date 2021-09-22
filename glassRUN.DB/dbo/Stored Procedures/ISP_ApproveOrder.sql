

CREATE PROCEDURE [dbo].[ISP_ApproveOrder] --'<Json><EnquiryId>1</EnquiryId><ShipTo>525</ShipTo><SoldTo>547</SoldTo><OrderType>SO</OrderType><TruckSizeId>15</TruckSizeId><ExpectedTimeOfDelivery>27/10/2018</ExpectedTimeOfDelivery><PromisedDate>27/10/2018</PromisedDate><IsRecievingLocationCapacityExceed>0</IsRecievingLocationCapacityExceed><CurrentState>1</CurrentState><NumberOfPalettes>8.00</NumberOfPalettes><TruckWeight>7.16</TruckWeight><SourceReferenceNumber>INQ000001</SourceReferenceNumber><DeliveryLocationCode></DeliveryLocationCode><CompanyMnemonic></CompanyMnemonic><OrderTime></OrderTime><OrderDate></OrderDate><OrderProductList><ProductCode>55909001</ProductCode><ProductType>9</ProductType><ProductQuantity>8.00</ProductQuantity><UnitPrice>0.0000</UnitPrice><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.0000</DepositeAmount><ItemType>0</ItemType></OrderProductList><OrderProductList><ProductCode>65801001</ProductCode><ProductType>9</ProductType><ProductQuantity>70.00</ProductQuantity><UnitPrice>636364.0000</UnitPrice><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.0000</DepositeAmount><ItemType>32</ItemType></OrderProductList><OrderProductList><ProductCode>65801011</ProductCode><ProductType>9</ProductType><ProductQuantity>410.00</ProductQuantity><UnitPrice>636364.0000</UnitPrice><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.0000</DepositeAmount><ItemType>32</ItemType></OrderProductList><Field3>26/10/2018 00:00:00</Field3><JdeBatchGeneratorId>5</JdeBatchGeneratorId><OrderedBy>OM</OrderedBy><OrderTakenBy>OM</OrderTakenBy><CreatedBy>8</CreatedBy><ServicesAction>GetOrderNumberFromThirthParty</ServicesAction><ReferenceNumber>2016273179</ReferenceNumber></Json>'
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


   select * into #tmpOrder
    FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
		OrderNumber nvarchar(250),
		EnquiryId BIGINT,
            [EnquiryAutoNumber] nvarchar(100),  
			ExpectedTimeOfDelivery nvarchar(100),  
			CarrierETA DATETIME,
			CarrierETD DATETIME,
			SoldTo BIGINT,
			ShipTo BIGINT,
            [RequestDate] datetime,     
			 [PrimaryAddressId] BIGINT,
            [SecondaryAddressId] BIGINT,
            [PrimaryAddress] nvarchar(500),
            [SecondaryAddress] nvarchar(500),
			[ModeOfDelivery] NVARCHAR(200),
			OrderType NVARCHAR(100),
			PurchaseOrderNumber NVARCHAR(200),      
			CarrierNumber NVARCHAR(50),     
            [Remarks] nvarchar,
            [PreviousState] bigint,
            [CurrentState] bigint,
			[TruckSizeId] BIGINT,
			[NumberOfPalettes] decimal(18,2),
			[TruckWeight]  decimal(18,2),
			[Description1] nvarchar(500),
			[Description2] nvarchar(500),
            [CreatedBy] bigint,
            [CreatedDate] datetime,           
            [IsActive] bit,
            [SequenceNo] bigint,
			[StockLocationId] nvarchar(150),
			[IsRecievingLocationCapacityExceed] bit,
			[OrderedBy] nvarchar(50),
			[GratisCode] nvarchar(50),
			BranchPlantCode nvarchar(150),
			Province nvarchar(50),
			SoldToCode nvarchar(150),
            [Field1] nvarchar(500),
            [Field2] nvarchar(500),
            [Field3] nvarchar(500),
            [Field4] nvarchar(500),
            [Field5] nvarchar(500),
            [Field6] nvarchar(500),
            [Field7] nvarchar(500),
            [Field8] nvarchar(500),
            [Field9] nvarchar(500),
            [Field10] nvarchar(500),
			[ReferenceNumber] nvarchar(250)
        )tmp


		 -----create tmp order Product table------
  select * into #tmpOrderProduct
   FROM OPENXML(@intpointer,'Json/OrderProductList',2)
        WITH
        (
		
            [EnquiryId] bigint,			
            [ProductCode] nvarchar(200),
            [ProductType] nvarchar(200),
			[ItemType] nvarchar(200),
            [ProductQuantity] decimal(10, 2),
			[UnitPrice]   decimal(10, 2),
			[DepositeAmount]   decimal(10, 2),
            [Remarks] nvarchar,
            [CreatedBy] bigint,
            [CreatedDate] datetime,           
            [IsActive] bit,
            [SequenceNo] bigint,
			[AssociatedOrder] nvarchar(100),
			StockLocationName nvarchar(500),
			StockLocationCode nvarchar(100),
            [Field1] nvarchar(500),
            [Field2] nvarchar(500),
            [Field3] nvarchar(500),
            [Field4] nvarchar(500),
            [Field5] nvarchar(500),
            [Field6] nvarchar(500),
            [Field7] nvarchar(500),
            [Field8] nvarchar(500),
            [Field9] nvarchar(500),
            [Field10] nvarchar(500)
        )tmp


		--DECLARE @OrderNumberIdGenerator bigint
	--INSERT INTO [dbo].[OrderNumberGenerator]([Value])
	--	SELECT 'OrderNumber'
		--SELECT  @OrderNumberIdGenerator  = @@IDENTITY   
		DECLARE @orderId BIGINT
		DECLARE @enquiryId BIGINT
		DECLARE @ReferenceNumber nvarchar(250)
		
        SET @enquiryId=(SELECT #tmpOrder.EnquiryId FROM #tmpOrder)
		SET @ReferenceNumber=(SELECT #tmpOrder.ReferenceNumber FROM #tmpOrder)

		   SET @orderId=0
		  if(@ReferenceNumber is  null)
		  begin
		  set @ReferenceNumber =''
		  end



		  if(@ReferenceNumber != '')
		  begin

		  --IF EXISTS (SELECT * FROM [Order] WHERE EnquiryId = @enquiryId)
		--BEGIN
		--	 SET @orderId=0
		--END
		--ELSE
		--BEGIN
		DECLARE @stockLocationCode nvarchar(150)
        --SET @stockLocationCode= (select DeliveryLocationCode from DeliveryLocation where DeliveryLocationId = (SELECT #tmpOrder.[StockLocationId] FROM #tmpOrder)) 

		declare @pickupDate datetime 

		select @pickupDate = PickDateTime from Enquiry where EnquiryId in (select #tmpOrder.EnquiryId from #tmpOrder)

		INSERT INTO [dbo].[Order]([OrderNumber],EnquiryId, [ExpectedTimeOfDelivery],PickDateTime, [CarrierETA],[CarrierETD],[SoldTo],[ShipTo],[PrimaryAddressId],[SecondaryAddressId],[OrderDate],
				    [ModeOfDelivery],StockLocationId,[OrderType],[PurchaseOrderNumber],[SalesOrderNumber],[Remarks],[PreviousState],[CurrentState],[CarrierNumber],[NumberOfPalettes],
			[TruckSizeId],[TruckWeight],[Description1],[Description2],[OrderedBy],[GratisCode],[Province],[CreatedBy],[CreatedDate],[IsActive],[Field1],[Field2],[Field3],[IsRecievingLocationCapacityExceed],[ReferenceNumber] , [ShipToCode], [ShipToName],[SoldToCode],[SoldToName])
				
				SELECT  #tmpOrder.[OrderNumber],
				#tmpOrder.EnquiryId, #tmpOrder.[ExpectedTimeOfDelivery],@pickupDate,#tmpOrder.[CarrierETA],#tmpOrder.[CarrierETD],#tmpOrder.[SoldTo],#tmpOrder.[ShipTo],#tmpOrder.[PrimaryAddressId],
				#tmpOrder.[SecondaryAddressId],GETDATE(),#tmpOrder.[ModeOfDelivery],#tmpOrder.[StockLocationId],#tmpOrder.[OrderType],#tmpOrder.[PurchaseOrderNumber],
				#tmpOrder.[OrderNumber],#tmpOrder.[Remarks],#tmpOrder.[PreviousState],#tmpOrder.[CurrentState],#tmpOrder.[CarrierNumber], #tmpOrder.[NumberOfPalettes]
				,#tmpOrder.[TruckSizeId]
				,#tmpOrder.[TruckWeight],#tmpOrder.[Description1],#tmpOrder.[Description2],#tmpOrder.[OrderedBy],
				#tmpOrder.[GratisCode],#tmpOrder.[Province],#tmpOrder.[CreatedBy],GETDATE(),1,#tmpOrder.SoldToCode,#tmpOrder.[Field2],#tmpOrder.[Field3],#tmpOrder.[IsRecievingLocationCapacityExceed],#tmpOrder.[ReferenceNumber] ,  l.LocationCode , l.LocationName , c.CompanyMnemonic , c.CompanyName
				FROM #tmpOrder    left join Company c on c.CompanyId=#tmpOrder.SoldTo
						left join Location  l on l.LocationId =#tmpOrder.ShipTo

			
				SELECT  @orderId  = @@IDENTITY  
				
				
				INSERT INTO dbo.OrderProduct( OrderId, ProductCode,ProductType,ProductQuantity,UnitPrice,AssociatedOrder,ShippableQuantity,
				BackOrderQuantity,CancelledQuantity,Remarks,DepositeAmount,ItemType,StockLocationCode,StockLocationName
				,CreatedBy,CreatedDate,IsActive)
				SELECT @orderId,#tmpOrderProduct.[ProductCode],#tmpOrderProduct.ProductType,#tmpOrderProduct.ProductQuantity,#tmpOrderProduct.UnitPrice, #tmpOrderProduct.AssociatedOrder, #tmpOrderProduct.ProductQuantity,
				#tmpOrderProduct.ProductQuantity,0,#tmpOrderProduct.[Remarks],
				#tmpOrderProduct.DepositeAmount,#tmpOrderProduct.ItemType,#tmpOrderProduct.StockLocationCode,#tmpOrderProduct.StockLocationName,
				1,GETDATE(),1
				FROM #tmpOrderProduct
		--END

		

			Update [Order] set CarrierNumber=e.CarrierId,CarrierCode=e.CarrierCode,CarrierName=e.CarrierName,CompanyId=e.CompanyId,CompanyCode=e.CompanyCode,TotalAmount=e.TotalAmount,TotalQuantity=e.TotalQuantity,TotalPrice=e.TotalPrice,TotalVolume=e.TotalVolume,TotalWeight=e.TotalWeight,TotalTaxAmount=e.TotalTaxAmount,TotalDiscountAmount=e.TotalDiscountAmount,TotalDepositeAmount=e.TotalDepositeAmount,TruckWeight=e.TruckWeight, IsSelfCollect = e.IsSelfCollect from Enquiry e where e.EnquiryId=[Order].EnquiryId and [Order].OrderId=@orderId
				-----update Enquiry  IsProcess column so that enquiry should be process again
					Update OrderProduct set PackingItemCount=ep.PackingItemCount,PackingItemCode=ep.PackingItemCode,IsPackingItem=ep.IsPackingItem,TotalVolume=ep.TotalVolume,TotalWeight=ep.TotalWeight
from EnquiryProduct ep where ep.IsActive=1 and ep.EnquiryId=@enquiryId and OrderProduct.OrderId=@orderId and ep.ProductCode=OrderProduct.ProductCode and ep.ItemType=OrderProduct.ItemType
			
				update enquiry set IsProcess =1 where  EnquiryId=@enquiryId


				declare @countForSaleorderNumber bigint


				set @countForSaleorderNumber =(select  count(*)  from   [order]  where SalesOrderNumber in (   select SONumber   From  Enquiry  where EnquiryId=@enquiryId))

				set @countForSaleorderNumber = @countForSaleorderNumber +1 ;

				--------------------Old Logic---------------------
				--update [Order] set SalesOrderNumber =(Select Top 1 SONumber from enquiry where EnquiryId=@enquiryId),[PurchaseOrderNumber] =(Select Top 1 PONumber from enquiry where EnquiryId=@enquiryId),
				--StockLocationId=(Select Top 1 CollectionLocationCode from enquiry where EnquiryId=@enquiryId) 
				
				--,[OrderNumber] =(Select Top 1 SONumber from enquiry where EnquiryId=@enquiryId)+ '/'+ right('00'+ convert(nvarchar(250),@countForSaleorderNumber),2)
				-- where EnquiryId=@enquiryId
			--------------------------New Logic-----------------------------

					update [Order] set [PurchaseOrderNumber] =(Select Top 1 PONumber from enquiry where EnquiryId=@enquiryId),
				StockLocationId=(Select Top 1 CollectionLocationCode from enquiry where EnquiryId=@enquiryId) 
				
				,[OrderNumber] =(Select Top 1 Replace(EnquiryAutoNumber,'INQ','') from enquiry where EnquiryId=@enquiryId) where EnquiryId=@enquiryId


				 -----------add event notfication for   order created --------

				 INSERT INTO [EventNotification] ( [EventMasterId], [EventCode], [ObjectId], [ObjectType], [IsActive], [CreatedDate], [CreatedBy] ) 
			select (select EventMasterId  From EventMaster where EventCode='OrderCreated' and IsActive=1 ), 'OrderCreated', o.OrderId , 'Order',1 , GETDATE() , o.CreatedBy  From   [order]  o  where o.EnquiryId=@enquiryId
				 ------





        --Add child table insert procedure when required.

		--------insert cd Amount for item

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



--------Add Because of Deposite Product
--INSERT INTO dbo.OrderProduct( OrderId, ProductCode,ProductType,ProductQuantity,UnitPrice,AssociatedOrder,ShippableQuantity,
--				BackOrderQuantity,CancelledQuantity,Remarks,DepositeAmount,ItemType
--				,CreatedBy,CreatedDate,IsActive ,LineNumber)
--				SELECT @orderId,'65999001',9,op.ProductQuantity,op.DepositeAmount,NULL, op.ProductQuantity,
--				op.ProductQuantity,0,NULL,
--				NULL,39,1,GETDATE(),1 ,( op.LineNumber +10)
--				FROM OrderProduct op where op.OrderProductId=@tempOrderProductId  and  ISNULL(op.DepositeAmount,0)   !=0;



SET @site_value = @site_value + 1;
END;
-------------End OrderStatus-----------------------------






------ insert in notes from enquiry table -----------

			INSERT INTO Notes(RoleId, ObjectId, ObjectType, Note,IsActive,CreatedBy,CreatedDate)
			SELECT RoleId, @orderId, 1221, Note,1,CreatedBy,GETDATE()
			FROM Notes where ObjectId = @enquiryId and ObjectType = 1220


------ insert in notes from enquiry table -----------

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

		  end
--------------------------------------------Allocation the transporter----------------------------------------------------------------------------
Declare @CollectionId bigint=0
Declare @TruckSizeId bigint=0
Declare @DestinationId bigint=0
Declare @CompanyId bigint=0
Declare @CarrierNumber nvarchar(10)='0'
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

--Update [Order] set CarrierNumber=@CarrierNumber where OrderId=@orderId
END
-------------------------------------------------------END--------------------------------------------------------------------------------
		
    update [Order] set companyid=1 where companyid is null
    SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
