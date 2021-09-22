CREATE PROCEDURE [dbo].[USP_Enquiry]

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

            DECLARE @EnquiryId bigint
			DECLARE @EnquiryAutoNumber nvarchar(100)


			 Declare @pick datetime
			 Declare @currentState bigint
  

  Declare @branchPlantCode nvarchar(50)
Declare @shipToCode nvarchar(50)
Declare @truckSizeId bigint
Declare @LocationId bigint
			  declare @tmpStockLocationId nvarchar(max)=null
    declare @tmpCollectionCode nvarchar(max)=null

	Declare @CopyOrderGUID nvarchar(200)=''
	Declare @MainOrderGUID nvarchar(200)=''

	SELECT

        @tmpStockLocationId=case when (select count(distinct(r.OriginId)) from [Route] r join Location d on d.LocationId=r.OriginId where d.IsActive=1 and r.DestinationId=tmp.[ShipTo] and r.TruckSizeId=tmp.[TruckSizeId]) =1 then (select distinct(d.LocationCode )   from [Route] r join Location d on d.LocationId=r.OriginId where d.IsActive=1 and r.DestinationId=tmp.[ShipTo] and r.TruckSizeId=tmp.[TruckSizeId]) else NULL end ,
		@tmpCollectionCode=tmp.[CollectionCode],
		@CopyOrderGUID=tmp.[CopyOrderGUID],
		@MainOrderGUID=tmp.[OrderGUID]
        	
        FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
			[OrderGUID] nvarchar(200),
			[CopyOrderGUID] nvarchar(200),
			[CollectionCode] nvarchar(100),
			[ShipTo] BIGINT,
			[SoldTo] BIGINT,
			[TruckSizeId] BIGINT
        )tmp


		


		if(@tmpCollectionCode = '' or @tmpCollectionCode = null)
			begin
				set @tmpCollectionCode = null
			end


   Select * into #tmpPickDate  FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            PickDateTime nvarchar(50)
          
           
        )tmp

		SET @pick=(Select CONVERT(datetime, #tmpPickDate.PickDateTime,103) from #tmpPickDate)

		Select * into #tmpEnquiryList  FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            EnquiryId bigint
          
           
        )tmp

		SET @EnquiryId=(Select top 1 #tmpEnquiryList.EnquiryId from #tmpEnquiryList)
		SET @currentState =(Select CurrentState from Enquiry where EnquiryId=@EnquiryId )
		Print @currentState

            UPDATE dbo.Enquiry SET
			@EnquiryId=tmp.EnquiryId,
			
			--[RequestDate] = convert(datetime, tmp.RequestDate , 103) ,
			[PromisedDate] = convert(datetime, tmp.RequestDate , 103) ,
			[PrimaryAddress] = tmp.PrimaryAddress,
        	[SecondaryAddress] = tmp.SecondaryAddress,
        	[OrderProposedETD] = case when (select top 1 Field1 from Company cmp where cmp.CompanyId=tmp.[SoldTo]) ='SCO' then NULL else convert(datetime,tmp.[OrderProposedETD], 103)  end ,
			[PONumber] = tmp.[PONumber],
			[SONumber] = tmp.[SONumber],
			[PickDatetime] = @pick,
			TotalPrice = tmp.[TotalPrice],
			[StockLocationId] = ISNULL(@tmpStockLocationId,@tmpCollectionCode),
			[IsSelfCollect] = tmp.IsOrderSelfCollect,
			[CollectionLocationCode] = ISNULL(@tmpCollectionCode,@tmpStockLocationId),
			
        	[Remarks] = tmp.Remarks,
        	[PreviousState] = tmp.PreviousState,
        	[CurrentState] = tmp.CurrentState,
			[TruckSizeId] = tmp.TruckSizeId,
			[ShipTo] = tmp.ShipTo,
			[ShipToCode]=(select Top 1 LocationCode from Location where LocationId = tmp.[ShipTo]),
			[ShipToName]=(select Top 1 LocationName from Location where LocationId = tmp.[ShipTo]),
			[SoldTo] = tmp.SoldTo,
			[EnquiryDate]=case when @currentState = 8 then getdate() else Enquiry.[EnquiryDate]  end ,
			--[EnquiryDate]= getdate() ,
        	[NumberOfPalettes] = tmp.NumberOfPalettes,
			[PalletSpace]=tmp.PalletSpace,
			[TotalWeight] = tmp.TotalWeight,
			[TruckWeight] = tmp.TruckWeight,
        	[IsActive] = tmp.IsActive,
        	[SequenceNo] = tmp.SequenceNo,
			[IsRecievingLocationCapacityExceed] = tmp.IsRecievingLocationCapacityExceed,
        	[Field1] = tmp.Field1,
        	[Field2] = tmp.Field2,
        	[Field3] = tmp.Field3,
        	[Field4] = tmp.Field4,
        	[Field5] = tmp.Field5,
        	[Field6] = tmp.Field6,
        	[Field7] = tmp.Field7,
        	[Field8] = tmp.Field8,
        	[Field9] = tmp.Field9,
        	[Field10]  = tmp.Field10,       	      	
        	[ModifiedBy]=1 ,
        	[ModifiedDate]=GETDATE(),
			[BillToId]=tmp.[BillTo],
			[BillToCode]=tmp.BillToCode
        	
            FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EnquiryId] bigint,   
			EnquiryAutoNumber nvarchar(100), 
            [RequestDate] nvarchar(500),
            [PrimaryAddress] nvarchar(500),
            [SecondaryAddress] nvarchar(500),
            [OrderProposedETD] nvarchar(500),
			[PONumber] nvarchar(100),
			[SONumber] nvarchar(100),
			[PickDatetime] datetime,
			TotalPrice decimal(18,2),
			IsOrderSelfCollect  nvarchar(10),
            [Remarks] nvarchar,
            [PreviousState] bigint,
            [CurrentState] bigint,
			[TruckSizeId] BIGINT,
			[ShipTo] BIGINT,
			[SoldTo] BIGINT,
			[PalletSpace] decimal(18,2),
            [NumberOfPalettes] decimal(18,2),
			[TotalWeight]  decimal(18,2),
			[TruckWeight]  decimal(18,2),       
            [IsActive] bit,
            [SequenceNo] bigint,
			[IsRecievingLocationCapacityExceed] bit,
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
			[ModifiedBy] bigint,
			[ModifiedDate] datetime,
			[BillTo] BIGINT,
			BillToCode nvarchar(200)
            )tmp WHERE Enquiry.[EnquiryId]=tmp.[EnquiryId]




			SELECT * INTO #tmpEnquiryProduct
			FROM OPENXML(@intpointer,'Json/OrderProductList',2)
			 WITH
             (
			EnquiryProductId BIGINT,
			[ProductCode] nvarchar(200),
			[ParentProductCode] nvarchar(200),
            [ProductType] nvarchar(200),
            [ProductQuantity] decimal(10, 2),
			[ItemPricesPerUnit] decimal(10, 2),
			[DepositeAmountPerUnit] decimal(10,2),
            [Remarks] nvarchar,
			[AssociatedOrder] bigint,
			[ItemType] bigint,
			[CollectionCode] nvarchar(100),
            [CreatedBy] bigint,
            [CreatedDate] datetime,           
            [IsActive] bit,
			[ReasonCodeId] bigint,
            [SequenceNo] bigint,
			[NumberOfExtraPalettes] nvarchar(50),
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
				[CurrentItemPalettesCorrectWeight] decimal(10,2),
			[CurrentItemTruckCapacityFullInTone] decimal(10,2),
			[PackingItemCount] decimal(10,2),
			[PackingItemCode] nvarchar(500),
			IsPackingItem bit
			 ) tmp



			 --select op.* from #tmpEnquiryProduct tmpop join OrderProduct op
			 -- on tmpop.EnquiryProductId=op.EnquiryProductId and tmpop.[ProductQuantity] <> op.[ProductQuantity]  
			 --where tmpop.EnquiryProductId <>0 and tmpop.IsActive=1

			 			SELECT * INTO #tmpReturnPakageMaterialList
			 FROM OPENXML(@intpointer,'Json/ReturnPakageMaterialList',2)
        WITH
        (
            [EnquiryId] bigint,
            [ProductCode] nvarchar(200),
			[ParentProductCode] nvarchar(200),
            [ProductType] nvarchar(200),
            [ProductQuantity] decimal(10, 2),
			[ItemPricesPerUnit] decimal(10, 2),
            [Remarks] nvarchar,
			[AssociatedOrder] bigint,
			[ItemType] bigint,
            [CreatedBy] bigint,
            [CreatedDate] datetime,           
            [IsActive] bit,
            [SequenceNo] bigint,
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



			  INSERT INTO [ReturnPakageMaterial]
        (
        	[EnquiryId],
        	[ProductCode],
			[ParentProductCode],
        	[ProductType],
        	[ProductQuantity],
			[Price],
        	[Remarks],
			[AssociatedOrder],
			[ItemType],
        	[CreatedBy],
        	[CreatedDate],        	
        	[IsActive],
        	[SequenceNo],
        	[Field1],
        	[Field2],
        	[Field3],
        	[Field4],
        	[Field5],
        	[Field6],
        	[Field7],
        	[Field8],
        	[Field9],
        	[Field10]
        )

        SELECT
        	@EnquiryId,
        	tmp.[ProductCode],
			tmp.[ParentProductCode],
        	tmp.[ProductType],
        	tmp.[ProductQuantity],
			0,
        	tmp.[Remarks],
			tmp.[AssociatedOrder],
			tmp.[ItemType],
        	1,
        	GETDATE(),        	
        	1,
        	tmp.[SequenceNo],
        	tmp.[Field1],
        	tmp.[Field2],
        	tmp.[Field3],
        	tmp.[Field4],
        	tmp.[Field5],
        	tmp.[Field6],
        	tmp.[Field7],
        	tmp.[Field8],
        	tmp.[Field9],
        	tmp.[Field10]
            From #tmpReturnPakageMaterialList tmp where NOT EXISTS (Select * from ReturnPakageMaterial rpm where rpm.IsActive=1 and rpm.EnquiryId=@EnquiryId and rpm.ProductCode=tmp.[ProductCode])
			




			
			select @shipToCode =ShipTo from Enquiry where EnquiryId = @EnquiryId
		select @truckSizeId =TruckSizeId from Enquiry where EnquiryId = @EnquiryId
		select @LocationId =LocationId from Location where LocationCode = (Select top 1 CollectionLocationCode from Enquiry Where EnquiryId=@EnquiryId)
		if((select COUNT(*) from Route where DestinationId = @shipToCode and OriginId = @LocationId and TruckSizeId = @truckSizeId and IsActive=1 ) = 1)
		BEGIN	
		Declare @CarrierId bigint
		Declare @CarrierCode nvarchar(50)
		Declare @CarrierName nvarchar(500)
		select @CarrierId=CompanyId, @CarrierCode=CompanyMnemonic, @CarrierName=CompanyName from Company where CompanyId in (select CarrierNumber from Route where DestinationId = @shipToCode and OriginId = @LocationId and TruckSizeId = @truckSizeId and IsActive=1)
		update [Enquiry] set CarrierId  = @CarrierId,CarrierCode = @CarrierCode, CarrierName = @CarrierName  where EnquiryId IN (@EnquiryId)
		
	  END
	  ELSE
	  BEGIN
		update [Enquiry] set CarrierId  = NULL,CarrierCode = NULL, CarrierName = NULL  where EnquiryId IN (@EnquiryId)
	  END




			 	INSERT INTO	[EnquiryProductHistory] 
			([EnquiryProductId],[EnquiryId],[ReasonCodeId],[ProductCode],[ProductType],[ProductQuantity],[CreatedBy],[CreatedDate],[IsActive],[Remarks],       	
        	[SequenceNo],[AssociatedOrder],[DepositeAmount],Price,ItemType,[Field1],
        	[Field2],[Field3],[Field4],	[Field5],[Field6],
        	[Field7],
        	[Field8],
        	[Field9],
        	[Field10])

          SELECT
        	 ep.EnquiryProductId,ep.[EnquiryId],tmpop.ReasonCodeId,ep.[ProductCode],ep.[ProductType],ep.[ProductQuantity],ep.[CreatedBy]
			,GETDATE(),ep.[IsActive],ep.Remarks,ep.SequenceNo,ep.AssociatedOrder,ep.DepositeAmount,ep.UnitPrice,ep.ItemType,ep.Field1
			,ep.Field2,ep.Field3,ep.Field4,ep.Field5,ep.Field6,ep.Field7,ep.Field8,ep.Field9,ep.Field10
			 from #tmpEnquiryProduct tmpop join EnquiryProduct ep
			  on tmpop.EnquiryProductId=ep.EnquiryProductId and tmpop.[ProductQuantity] <> ep.[ProductQuantity]  
			 where tmpop.EnquiryProductId <>0 and tmpop.IsActive=1 




			UPDATE dbo.EnquiryProduct SET IsActive=0 WHERE EnquiryId=@EnquiryId

			UPDATE dbo.EnquiryProduct
			SET dbo.EnquiryProduct.[ProductQuantity]=#tmpEnquiryProduct.[ProductQuantity],dbo.EnquiryProduct.IsActive=#tmpEnquiryProduct.IsActive,
			dbo.EnquiryProduct.ModifiedDate=GETDATE(),dbo.EnquiryProduct.ModifiedBy = 1,
			dbo.EnquiryProduct.[TotalVolume] = #tmpEnquiryProduct.[CurrentItemPalettesCorrectWeight],
			dbo.EnquiryProduct.[TotalWeight] = #tmpEnquiryProduct.[CurrentItemTruckCapacityFullInTone]
			FROM #tmpEnquiryProduct WHERE  	
			dbo.EnquiryProduct.EnquiryId=@EnquiryId and  dbo.EnquiryProduct.ProductCode=#tmpEnquiryProduct.[ProductCode] and dbo.EnquiryProduct.ItemType=#tmpEnquiryProduct.ItemType
		--dbo.EnquiryProduct.EnquiryProductId=#tmpEnquiryProduct.EnquiryProductId


			INSERT INTO	[EnquiryProduct] 
			([EnquiryId],[ProductCode],
			[ProductName],
			[ParentProductCode],
        	[ProductType],
        	[ProductQuantity],
			[UnitPrice],
			[DepositeAmount],
        	[Remarks],
			[AssociatedOrder],
			[ItemType],
			[CollectionLocationCode],
        	[CreatedBy],
        	[CreatedDate],        	
        	[IsActive],
        	[SequenceNo],
			[NumberOfExtraPallet],
        	[Field1],
        	[Field2],
        	[Field3],
        	[Field4],
        	[Field5],
        	[Field6],
        	[Field7],
        	[Field8],
        	[Field9],
        	[Field10],
				[TotalVolume],
			[TotalWeight],
			[PackingItemCount],
			[PackingItemCode],
			IsPackingItem)

          SELECT
        	@EnquiryId,
        	#tmpEnquiryProduct.[ProductCode],
			(select top 1 ItemName from Item where ItemCode = #tmpEnquiryProduct.[ProductCode]),
			#tmpEnquiryProduct.[ParentProductCode],
			#tmpEnquiryProduct.[ProductType],        	
        	#tmpEnquiryProduct.[ProductQuantity],
        	case when isnull(#tmpEnquiryProduct.[AssociatedOrder],0)=0 then  ISNULL(#tmpEnquiryProduct.[ItemPricesPerUnit],0)  else 0 end,
        	#tmpEnquiryProduct.[DepositeAmountPerUnit],
        	#tmpEnquiryProduct.[Remarks],
			#tmpEnquiryProduct.[AssociatedOrder],
			#tmpEnquiryProduct.[ItemType],
			#tmpEnquiryProduct.[CollectionCode],
        	1,
        	GETDATE(),        	
        	#tmpEnquiryProduct.[IsActive],	
			#tmpEnquiryProduct.[SequenceNo],
			#tmpEnquiryProduct.[NumberOfExtraPalettes],		
        	#tmpEnquiryProduct.[Field1],
        	#tmpEnquiryProduct.[Field2],
        	#tmpEnquiryProduct.[Field3],
        	#tmpEnquiryProduct.[Field4],
        	#tmpEnquiryProduct.[Field5],
        	#tmpEnquiryProduct.[Field6],
        	#tmpEnquiryProduct.[Field7],
        	#tmpEnquiryProduct.[Field8],
        	#tmpEnquiryProduct.[Field9],
        	#tmpEnquiryProduct.[Field10],
			#tmpEnquiryProduct.[CurrentItemPalettesCorrectWeight],
			#tmpEnquiryProduct.[CurrentItemTruckCapacityFullInTone],
			#tmpEnquiryProduct.[PackingItemCount],
			#tmpEnquiryProduct.[PackingItemCode],
			#tmpEnquiryProduct.IsPackingItem
			
			FROM #tmpEnquiryProduct WHERE  
			not  EXISTS (SELECT EnquiryProductId from EnquiryProduct  WHERE dbo.EnquiryProduct.EnquiryId=@EnquiryId and dbo.EnquiryProduct.ProductCode=#tmpEnquiryProduct.[ProductCode] and dbo.EnquiryProduct.ItemType=#tmpEnquiryProduct.ItemType)
			--#tmpEnquiryProduct.EnquiryProductId = 0
        	
           
		   SELECT EnquiryId as EnquiryId,EnquiryAutoNumber as EnquiryAutoNumber,CurrentState,IsActive from Enquiry where EnquiryId=@EnquiryId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_Enquiry'
