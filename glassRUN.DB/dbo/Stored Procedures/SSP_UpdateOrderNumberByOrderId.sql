CREATE PROCEDURE [dbo].[SSP_UpdateOrderNumberByOrderId]

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

declare  @OrderNumber nvarchar(250) ;
declare @EnquiryId  bigint ;
declare @CurrentState  bigint ;
declare @orderid  bigint ;

select @EnquiryId =tmp.EnquiryId,
@CurrentState =tmp.CurrentState
			FROM OPENXML(@intpointer,'Enquiry',2)
			 WITH
             (
		
					        
			EnquiryId bigint,		
				CurrentState  bigint
				
			 ) tmp



		select @OrderNumber  =tmp.OrderNumber  
			FROM OPENXML(@intpointer,'Enquiry/JDEOrder',2)
			 WITH
             (
		
			OrderNumber nvarchar(250)
			        
			
			 ) tmp




	if(not  exists(select *From   [order] where EnquiryId=@EnquiryId)   )
	begin


	print '657'

	  SELECT * INTO #tmpBSSVOrderProductList
			FROM OPENXML(@intpointer,'Enquiry/JDEOrder/OrderProductList',2)
			 WITH
             (
		
			ProductCode nvarchar(250),
			ProductName nvarchar(250),			        
			ItemShortCode nvarchar(250),		
				ProductQuantity  decimal(18,2) ,
				LastStatus bigint,
				NextStatus bigint,
				LineTypeCode nvarchar(250),
				LineNumber bigint ,
				UnitPrice  decimal(18,2),
				TotalUnitPrice  decimal(18,2)
				
			 ) tmp

	print '234234'

		---- isnert  order Nimesh-------------------------


		print '1'

				INSERT INTO [dbo].[Order] ([CompanyId] ,[CompanyCode] ,[OrderNumber] ,[EnquiryId] ,[PickDateTime] ,[ExpectedTimeOfDelivery] ,[CarrierETA] ,[CarrierETD] ,[OrderDate] ,[TruckSizeId] ,[SoldTo] ,[SoldToCode] ,[SoldToName] ,[ShipTo] ,[ShipToCode] ,[ShipToName] ,[PrimaryAddressId] ,[SecondaryAddressId] ,[PrimaryAddress] ,[SecondaryAddress] ,[ModeOfDelivery] ,[OrderType] ,[PurchaseOrderNumber] ,[SalesOrderNumber] ,[PickNumber] ,[Remarks] ,[PreviousState] ,[CurrentState] ,[NextState] ,[IsRecievingLocationCapacityExceed] ,[StockLocationId] ,[CreatedBy] ,[CreatedDate] ,isactive ,Description1 ,Description2 ,PalletSpace  ,CarrierNumber ,CarrierCode ,CarrierName ,NumberOfPalettes ,TruckWeight ,TotalDiscountAmount ,TotalAmount ,TotalDepositeAmount ,TotalTaxAmount ,TotalQuantity ,TotalPrice ,TotalVolume ,TotalWeight ,IsSelfCollect  ,OrderedBy ,GratisCode ,Province )
							 select CompanyId , CompanyCode , @OrderNumber, @EnquiryId, PickDateTime, promiseddate , NULL, NULL, EnquiryDate , TruckSizeId, SoldTo, SoldToCode, SoldToName, ShipTo, ShipToCode, ShipToName, PrimaryAddressId, SecondaryAddressId, PrimaryAddress, SecondaryAddress, NULL, EnquiryType, PONumber, @OrderNumber, NULL, null, 0, @CurrentState, 0, null,  StockLocationId, 1, GETDATE(), 1, Description1, Description2, PalletSpace, CarrierId, CarrierCode, CarrierName, NumberOfPalettes, TruckWeight, TotalDiscountAmount, TotalAmount, TotalDepositeAmount, TotalTaxAmount, TotalQuantity, TotalPrice, TotalVolume, TotalWeight, IsSelfCollect ,OrderedBy ,GratisCode ,Province  from enquiry where EnquiryId=@EnquiryId

		   set @orderid = @@IDENTITY

		   print '2'
--------------------insert  order product ----------------
	INSERT INTO [dbo].[OrderProduct]
           (
           [OrderId]
           ,[ProductCode]
           ,[ProductName]
           ,[ProductType]
           ,[ProductQuantity]
           ,[UnitPrice]
           ,[TotalUnitPrice]
           ,[ShippableQuantity]
            ,[ItemType]
            ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive]
           ,[LineNumber]
		   ,LastStatus
		   ,NextStatus
		 --  ,TotalVolume
		--   ,TotalWeight
		--   ,PackingItemCount
		 --  ,PackingItemCode
		--   ,IsPackingItem
           )
		   select  @orderId ,
		    #tmpBSSVOrderProductList.ProductCode    , 
		 #tmpBSSVOrderProductList.ProductName  ,
			   9,
				  #tmpBSSVOrderProductList.ProductQuantity ,
				    #tmpBSSVOrderProductList.UnitPrice ,
					 #tmpBSSVOrderProductList.TotalUnitPrice ,
					 #tmpBSSVOrderProductList.ProductQuantity ,
				 case when ( #tmpBSSVOrderProductList.ProductCode  = '65999001')  then '37'
				  when ( #tmpBSSVOrderProductList.ProductCode  = '55909001'  or   #tmpBSSVOrderProductList.ProductCode  = '55908001')  then '0' else  '32' end  ,
					 1,
					GETDATE(),
					1,
 #tmpBSSVOrderProductList.LineNumber,
 #tmpBSSVOrderProductList.LastStatus,
 #tmpBSSVOrderProductList.NextStatus
  --,ep.TotalVolume
		--   ,ep.TotalWeight
		--   ,ep.PackingItemCount
		--   ,ep.PackingItemCode
		--   ,ep.IsPackingItem

			  from    #tmpBSSVOrderProductList  
  
  ----update order product   total volume ,total weight 

  update OrderProduct

  set   TotalVolume  =   ep.TotalVolume ,
  TotalWeight =ep.TotalWeight ,
  PackingItemCount = ep.PackingItemCount ,
  PackingItemCode = ep.PackingItemCode ,
  IsPackingItem = ep.IsPackingItem
 
  from   OrderProduct op left  join  EnquiryProduct  ep
	 on ep.ProductCode = op.ProductCode 
	 where  ep.EnquiryId = @EnquiryId and 
	 op.OrderId=@orderid


-- Inserting the gratis product from the enquiry
-- Insert gratis product in order

Declare @lastStatus bigint
Declare @nextStatus bigint
select @lastStatus  =tmp.LastStatus,
 @nextStatus  =tmp.NextStatus  
			FROM OPENXML(@intpointer,'Enquiry/JDEOrder/OrderProductList',2)
			 WITH
             (
		
			LastStatus bigint,
			NextStatus bigint
			        
			
			 ) tmp


	INSERT INTO [dbo].[OrderProduct]
           ([OrderId]   ,[ProductCode]   ,[ProductName]    ,[ProductType]   ,[ProductQuantity]  ,[UnitPrice]  ,[TotalUnitPrice]  ,[ShippableQuantity]  ,[ItemType],AssociatedOrder
            ,[CreatedBy] ,[CreatedDate]   ,[IsActive]      ,[LineNumber]    ,LastStatus  ,NextStatus,TotalVolume,TotalWeight)
		Select (Select top 1 OrderId from [Order] where EnquiryId=@EnquiryId and IsActive=1),ProductCode,ProductName,ProductType,ProductQuantity,UnitPrice,TotalUnitPrice,ProductQuantity
		,30,AssociatedOrder,1,GETDATE(),1,NULL,@lastStatus,@nextStatus,TotalVolume,TotalWeight 
		from [Enquiryproduct] where EnquiryId =@EnquiryId and ItemType=30  and IsActive=1



-- Insert gratis order number in associated order table



-------

	end
	
Declare @EnquiryType nvarchar(50)
	SET @EnquiryType=(Select EnquiryType from Enquiry where EnquiryId=@EnquiryId)
	if @EnquiryType!='SO'
	BEGIN
		INSERT INTO [dbo].[EventNotification]
           ([EventMasterId]
           ,[EventCode]
           ,[ObjectId]
           ,[ObjectType]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		Select (Select top 1 EventMasterId from EventMaster where EventCode='GratisOrder' and IsActive=1),'GratisOrder',@orderId,'Order',1,1,GETDATE() 
	END
	ELSE if @EnquiryType='SO'
	BEGIN
		INSERT INTO [dbo].[EventNotification]
           ([EventMasterId]
           ,[EventCode]
           ,[ObjectId]
           ,[ObjectType]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		Select (Select top 1 EventMasterId from EventMaster where EventCode='OrderCreated' and IsActive=1),'OrderCreated',@orderId,'Order',1,1,GETDATE() 
	END
	  SELECT @OrderNumber as OrderNumber        FOR XML RAW('Json'),ELEMENTS


	
	
END
