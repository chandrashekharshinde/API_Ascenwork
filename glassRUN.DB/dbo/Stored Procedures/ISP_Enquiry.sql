
CREATE PROCEDURE [dbo].[ISP_Enquiry] --'<Json><CopyOrderGUID></CopyOrderGUID><OrderGUID>99a96936-934c-4108-b26d-46a4736ddc5c</OrderGUID><EnquiryId>0</EnquiryId><EnquiryType>SO</EnquiryType><IsOrderSelfCollect>0</IsOrderSelfCollect><ActivityStartTime>2019/06/04 13:51:27</ActivityStartTime><RequestDate>05/06/2019 00:00:00</RequestDate><ShipToCode>1111311</ShipToCode><ShipTo>39</ShipTo><SoldTo>274</SoldTo><CompanyMnemonic>11000362</CompanyMnemonic><CompanyId>1</CompanyId><CompanyCode>11000362</CompanyCode><PONumber></PONumber><SONumber>20190604</SONumber><CollectionCode></CollectionCode><TruckSizeId>19</TruckSizeId><IsActive>true</IsActive><IsRecievingLocationCapacityExceed>false</IsRecievingLocationCapacityExceed><NumberOfPalettes>12</NumberOfPalettes><PalletSpace>12</PalletSpace><TruckWeight>12.924</TruckWeight><OrderProposedETD>05/06/2019 00:00:00</OrderProposedETD><PreviousState>0</PreviousState><CurrentState>1</CurrentState><CurrentStateDraft>1</CurrentStateDraft><CreatedBy>793</CreatedBy><OrderProductList><OrderGUID>99a96936-934c-4108-b26d-46a4736ddc5c</OrderGUID><EnquiryProductId>0</EnquiryProductId><ItemId>50</ItemId><ParentItemId>0</ParentItemId><ParentProductCode></ParentProductCode><AssociatedOrder>0</AssociatedOrder><ItemName>Heineken 250x24C Tray</ItemName><ItemPricesPerUnit>436364</ItemPricesPerUnit><ProductCode>65200500</ProductCode><PrimaryUnitOfMeasure>Carton</PrimaryUnitOfMeasure><ProductQuantity>1920</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>6.500000000000000e+000</WeightPerUnit><IsActive>true</IsActive><ItemType>32</ItemType><PackingItemCount>0</PackingItemCount><PackingItemCode>0</PackingItemCode><IsPackingItem>0</IsPackingItem><NumberOfExtraPalettes>0</NumberOfExtraPalettes><AllocationExcited>false</AllocationExcited><AllocationQty>0</AllocationQty><DepositeAmountPerUnit>0.00</DepositeAmountPerUnit><CollectionCode></CollectionCode></OrderProductList><OrderProductList><OrderGUID>99a96936-934c-4108-b26d-46a4736ddc5c</OrderGUID><EnquiryProductId>0</EnquiryProductId><ItemId>223</ItemId><ParentItemId>0</ParentItemId><ParentProductCode></ParentProductCode><AssociatedOrder>0</AssociatedOrder><ItemName>Wooden Pallet</ItemName><ItemPricesPerUnit>0</ItemPricesPerUnit><ProductCode>55909001</ProductCode><PrimaryUnitOfMeasure>Each</PrimaryUnitOfMeasure><ProductQuantity>12</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>0</WeightPerUnit><IsActive>true</IsActive><ItemType>0</ItemType><PackingItemCount>0</PackingItemCount><PackingItemCode>0</PackingItemCode><IsPackingItem>1</IsPackingItem><NumberOfExtraPalettes>0</NumberOfExtraPalettes><AllocationExcited>false</AllocationExcited><AllocationQty>0</AllocationQty><DepositeAmountPerUnit>0</DepositeAmountPerUnit><CollectionCode></CollectionCode></OrderProductList><TotalAmount>837818880</TotalAmount><TotalQuantity>1932</TotalQuantity><TotalVolume>12.924</TotalVolume><TotalPrice>921600768</TotalPrice><TotalWeight>12.924</TotalWeight><TotalDepositeAmount>0</TotalDepositeAmount><TotalTaxAmount>83781888</TotalTaxAmount><TotalDiscountAmount>0</TotalDiscountAmount><totalorderamount>837818880</totalorderamount><totalDepositeamount>0</totalDepositeamount><EnquiryAutoNumber></EnquiryAutoNumber></Json>'
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
			DECLARE @ENQUIRYIDGENERATOR bigint
		INSERT INTO [dbo].[EnquiryIdGenerated]([Value])
		SELECT 'EnquiryNumber'
		SELECT  @ENQUIRYIDGENERATOR  = @@IDENTITY   
		DELETE FROM [dbo].[EnquiryIdGenerated]   

		Declare @branchPlantCode nvarchar(50)
Declare @shipToCode nvarchar(50)
Declare @truckSizeId bigint
Declare @LocationId bigint

Declare @StockLocationName nvarchar(50)
Declare @BranchPlantName nvarchar(50)


   Declare @pick datetime

  Declare @currentState bigint
   Select * into #tmpPickDate  FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            PickDateTime nvarchar(50),
          [CurrentState] bigint
           
        )tmp

		SET @pick=(Select CONVERT(datetime, #tmpPickDate.PickDateTime,103) from #tmpPickDate)
SET @currentState=(Select  #tmpPickDate.CurrentState from #tmpPickDate)
   declare @AutoNumber nvarchar(max)= CONVERT(NVARCHAR(max),right(replicate('0',6-LEN(@ENQUIRYIDGENERATOR))+cast(@ENQUIRYIDGENERATOR as varchar(15)),10))
   declare @EnquiryAutoNumber nvarchar(max)='TINQ' +@AutoNumber

   declare @tmpStockLocationId nvarchar(max)=null
    declare @tmpCollectionCode nvarchar(max)=null

	Declare @CopyOrderGUID nvarchar(200)=''
	Declare @MainOrderGUID nvarchar(200)=''

    SELECT

        @tmpStockLocationId=case when (select count(distinct(r.OriginId)) from [Route] r join Location d on d.LocationId=r.OriginId where d.IsActive=1
		 and r.DestinationId=tmp.[ShipTo] and r.TruckSizeId=tmp.[TruckSizeId]) =1 then (select distinct(d.LocationCode )   
		 from [Route] r join Location d on d.LocationId=r.OriginId where d.IsActive=1 and r.DestinationId=tmp.[ShipTo] 
		 and r.TruckSizeId=tmp.[TruckSizeId]) else NULL end ,
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
			[TruckSizeId] BIGINT,
			CompanyId bigint
        )tmp


if not exists (SELECT EnquiryId From Enquiry where Isnull(EnquiryGuid,'')=@MainOrderGUID)
 BEGIN


		if(@tmpCollectionCode = '' or @tmpCollectionCode = null)
			begin
				set @tmpCollectionCode = null
			end
		
    
        INSERT INTO	[Enquiry]
        (
        	[EnquiryAutoNumber],
			[EnquiryType],
			PickDatetime,
        	[RequestDate],
			[StockLocationId],
			[EnquiryDate],
        	[PrimaryAddress],
        	[SecondaryAddress],
        	[OrderProposedETD],
			[CompanyId],
			[CompanyCode],		
			[PONumber],
			[SONumber],
			[CollectionLocationCode],
        	[Remarks],
        	[PreviousState],
        	[CurrentState],
			[TruckSizeId],
			[NumberOfPalettes],
			[PalletSpace],
			[TruckWeight],
			[ShipTo],
			[ShipToCode],
			[ShipToName],
			[SoldTo],
			[SoldToCode],
			[SoldToName],
        	[CreatedBy],
        	[CreatedDate],        
        	[IsActive],
        	[SequenceNo],
			[IsRecievingLocationCapacityExceed],
			[TotalAmount],
			[TotalQuantity],
			[TotalPrice],
			[TotalVolume],
			[TotalWeight],
			[TotalTaxAmount],
			[TotalDiscountAmount],
			[TotalDepositeAmount],
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
			[EnquiryGuid],
			[IsSelfCollect],
			OriginalCollectionDate,
			PromisedDate,
			BillToId,
			BillToCode,
			Description1
        )

        SELECT
        	@EnquiryAutoNumber aS OrderNumber,
        	'SO',
			@pick,
        	--tmp.[RequestDate],
        	CASE WHEN CONVERT(datetime, tmp.[RequestDate],103) = '1900-01-01' THEN convert(datetime,tmp.[OrderProposedETD], 103)  ELSE convert(datetime, tmp.[RequestDate] , 103)  END ,
			--case when (select count(distinct(r.OriginId)) from [Route] r join Location d on d.LocationId=r.OriginId where d.IsActive=1 and r.DestinationId=tmp.[ShipTo] and r.TruckSizeId=tmp.[TruckSizeId]) =1 then (select distinct(d.LocationCode )   from [Route] r join Location d on d.LocationId=r.OriginId where d.IsActive=1 and r.DestinationId=tmp.[ShipTo] and r.TruckSizeId=tmp.[TruckSizeId]) else NULL end ,
			ISNULL(@tmpStockLocationId,@tmpCollectionCode),
			GETDATE(),
        	tmp.[PrimaryAddress],
        	tmp.[SecondaryAddress],
        	--CAST(tmp.[OrderProposedETD] AS datetime2),
			-- convert(datetime,tmp.[OrderProposedETD], 103)  ,
			case when (select top 1 Field1 from Company cmp where cmp.CompanyId=tmp.[SoldTo]) ='SCO' then NULL else convert(datetime,tmp.[OrderProposedETD], 103)  end as OrderProposedETD,
			--tmp.[OrderProposedETD],
			--tmp.[CompanyId],
			tmp.CompanyId,
			tmp.CompanyMnemonic,
			--(select Top 1 ParentCompany from Company where CompanyId = tmp.[SoldTo]),
			--(select Top 1 CompanyMnemonic from Company where CompanyId = tmp.[SoldTo]),
			tmp.[PONumber],
			NULL,
			--tmp.[SONumber],
			--tmp.[CollectionCode],
			ISNULL(@tmpCollectionCode,@tmpStockLocationId),
        	tmp.[Remarks],
        	tmp.[PreviousState],
        	tmp.[CurrentState],
			tmp.[TruckSizeId],
			tmp.[NumberOfPalettes],
			tmp.[PalletSpace],
			case when    tmp.TruckWeight  is null then 0 else  tmp.TruckWeight   end ,
			tmp.[ShipTo],
			(select Top 1 LocationCode from Location where LocationId = tmp.[ShipTo]),
			(select Top 1 LocationName from Location where LocationId = tmp.[ShipTo]),
			tmp.[SoldTo],
			(select Top 1 CompanyMnemonic from Company where CompanyId = tmp.[SoldTo]),
			(select Top 1 CompanyName from Company where CompanyId = tmp.[SoldTo]),
        	tmp.[CreatedBy],
        	GETDATE(),        
        	tmp.[IsActive],
        	tmp.[SequenceNo],
			tmp.[IsRecievingLocationCapacityExceed],
			tmp.[TotalAmount],
			tmp.[TotalQuantity],
			tmp.[TotalPrice],
			case when    tmp.[TotalVolume]  is null then 0 else  tmp.[TotalVolume]   end ,
			case when    tmp.[TotalWeight]  is null then 0 else  tmp.[TotalWeight]   end ,
			tmp.[TotalTaxAmount],
			tmp.[TotalDiscountAmount],
			tmp.[TotalDepositeAmount],
        	tmp.[Field1],
        	tmp.[Field2],
        	tmp.[Field3],
        	tmp.[Field4],
        	tmp.[Field5],
        	tmp.[Field6],
        	tmp.[Field7],
        	tmp.[NoOfDays],
        	tmp.[Field9],
        	tmp.[Field10],
			tmp.[OrderGUID],
			tmp.[IsOrderSelfCollect],
			@pick,
			CASE WHEN CONVERT(datetime, tmp.[RequestDate],103) = '1900-01-01' THEN convert(datetime,tmp.[OrderProposedETD], 103)  ELSE convert(datetime, tmp.[RequestDate] , 103)  END ,
			tmp.BillTo,
			tmp.BillToCode,
			tmp.InquiryDescription
            FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            [EnquiryAutoNumber] nvarchar(100),
			[EnquiryType] nvarchar(100),
			[PickDatetime]  datetime,
			 [RequestDate] nvarchar(50),
			[CompanyId] nvarchar(50),
			[CompanyMnemonic] nvarchar(100),
			[PONumber] nvarchar(100),
			[SONumber] nvarchar(100),
			[CollectionCode] nvarchar(100),
            [PrimaryAddress] nvarchar(500),
            [SecondaryAddress] nvarchar(500),
            [OrderProposedETD] nvarchar(50),
            [Remarks] nvarchar(250),
            [PreviousState] bigint,
            [CurrentState] bigint,
			[TruckSizeId] BIGINT,
			[PalletSpace] decimal(18,2),
			[NumberOfPalettes] decimal(18,2),
			[TruckWeight]  decimal(18,2),
			[ShipTo] BIGINT,
			[SoldTo] BIGINT,
            [CreatedBy] bigint,
            [CreatedDate] datetime,           
            [IsActive] bit,
            [SequenceNo] bigint,
			[IsRecievingLocationCapacityExceed] bit,
			[TotalAmount]  decimal(18,2),
			[TotalQuantity]  decimal(18,2),
			[TotalPrice]  decimal(18,2),
			[TotalVolume]  decimal(18,2),
			[TotalWeight]  decimal(18,2),
			[TotalTaxAmount]  decimal(18,2),
			[TotalDiscountAmount]  decimal(18,2),
			[TotalDepositeAmount]  decimal(18,2),
            [Field1] nvarchar(500),
            [Field2] nvarchar(500),
            [Field3] nvarchar(500),
            [Field4] nvarchar(500),
            [Field5] nvarchar(500),
            [Field6] nvarchar(500),
            [Field7] nvarchar(500),
            [Field8] nvarchar(500),
            [Field9] nvarchar(500),
			[NoOfDays] nvarchar(50),
            [Field10] nvarchar(500),
			[OrderGUID] nvarchar(200),
			[IsOrderSelfCollect] nvarchar(10),
			PromisedDate datetime,
			[BillTo] BIGINT,
			BillToCode nvarchar(200),
			InquiryDescription  nvarchar(50)
        )tmp
        

  DECLARE @Enquiry bigint
  SET @Enquiry = @@IDENTITY
        

	Update [Log] set ObjectId=@Enquiry where isnull(LogGuid,'')=@MainOrderGUID;


	If @CopyOrderGUID !=''
	Begin

	insert into log 
	([UserId]
           ,[ObjectId]
           ,[ObjectType]
           ,[LogDescription]
           ,[FunctionCall]
           ,[LogDate]
           ,[LoggingTypeId]
           ,[Source]
           ,[LogGuid]
           ,[CreatedDate])
		   Select (select top 1 UserId From Log where [LogGuid]=@CopyOrderGUID)
           ,@Enquiry
           ,'Enquiry Copied'
           ,'Start Enquiry copy log'
           ,NULL
           ,GETDATE()
           ,3501
           ,'Portal'
           ,@MainOrderGUID
           ,GETDATE()

		INSERT INTO [dbo].[Log]
           ([UserId]
           ,[ObjectId]
           ,[ObjectType]
           ,[LogDescription]
           ,[FunctionCall]
           ,[LogDate]
           ,[LoggingTypeId]
           ,[Source]
           ,[LogGuid]
           ,[CreatedDate])

	 Select [UserId]
           ,@Enquiry
           ,[ObjectType]
           ,[LogDescription]
           ,[FunctionCall]
           ,[LogDate]
           ,[LoggingTypeId]
           ,[Source]
           ,@MainOrderGUID
           ,[CreatedDate] from [Log] Where [LogGuid]=@CopyOrderGUID


		   insert into log 
	([UserId]
           ,[ObjectId]
           ,[ObjectType]
           ,[LogDescription]
           ,[FunctionCall]
           ,[LogDate]
           ,[LoggingTypeId]
           ,[Source]
           ,[LogGuid]
           ,[CreatedDate])
		   Select (select top 1 UserId From Log where [LogGuid]=@CopyOrderGUID)
           ,@Enquiry
           ,'Enquiry Copied'
           ,'End Enquiry copy log'
           ,NULL
           ,GETDATE()
           ,3501
           ,'Portal'
           ,@MainOrderGUID
           ,GETDATE()


	End



		 INSERT INTO	[EnquiryProduct]
        (
        	[EnquiryId],
        	[ProductCode],
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
			IsPackingItem,
			EnquiryAutoNumber,
			UOM
        )

        SELECT
        	@Enquiry,
        	tmp.[ProductCode],
			(select top 1 ItemName from Item where ItemCode = tmp.[ProductCode]),
			tmp.[ParentProductCode],
        	tmp.[ProductType],
        	tmp.[ProductQuantity],
			case when isnull(tmp.[AssociatedOrder],0)=0 then  ISNULL(tmp.[ItemPricesPerUnit],0)  else 0 end,
			tmp.[DepositeAmountPerUnit],
        	tmp.[Remarks],
			tmp.[AssociatedOrder],
			tmp.[ItemType],
			tmp.[CollectionCode],
        	1,
        	GETDATE(),        	
        	tmp.[IsActive],
        	tmp.[SequenceNo],
			tmp.[NumberOfExtraPalettes],
        	tmp.[Field1],
        	tmp.[Field2],
        	tmp.[Field3],
        	tmp.[Field4],
        	tmp.[Field5],
        	tmp.[Field6],
        	tmp.[Field7],
        	tmp.[Field8],
        	tmp.[Field9],
        	tmp.[Field10],
			tmp.[CurrentItemPalettesCorrectWeight],
			tmp.[CurrentItemTruckCapacityFullInTone],
			tmp.[PackingItemCount],
			tmp.[PackingItemCode],
			tmp.IsPackingItem,
			@EnquiryAutoNumber,
			tmp.PrimaryUnitOfMeasure
            FROM OPENXML(@intpointer,'Json/OrderProductList',2)
        WITH
        (
            [EnquiryId] bigint,
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
			IsPackingItem bit,
			PrimaryUnitOfMeasure nvarchar(50)
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
        	@Enquiry,
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
        	tmp.[IsActive],
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
        
         -----------add event notfication for   order created --------
		 if @currentState !=8
		 BEGIN
				 INSERT INTO [EventNotification] ( [EventMasterId], [EventCode], [ObjectId], [ObjectType], [IsActive], [CreatedDate], [CreatedBy] ) 
			select (select EventMasterId  From EventMaster where EventCode='EnquiryCreated' and IsActive=1 ), 'EnquiryCreated', o.EnquiryId , 'Enquiry',1 , GETDATE() , o.CreatedBy  From   Enquiry  o  where o.EnquiryId=@Enquiry
			END
				 ------


		 INSERT INTO [dbo].[Notes]
			    (
			       [RoleId]
				  ,[ObjectId]
				  ,[ObjectType]
				  ,[Note]
				  ,[IsActive]
				  ,[CreatedBy]
				  ,[CreatedDate]
				  
			    )

        SELECT
			    	tmp1.[RoleId],
			    	@Enquiry,
			    	tmp1.[ObjectType],        		
					tmp1.[Note],
			    	1,
					tmp1.[CreatedBy],
			    	GETDATE() 	
            FROM OPENXML(@intpointer,'Json/NoteList',2)
        WITH
        (
			[RoleId] bigint,
            [ObjectId] bigint,
			[ObjectType] bigint,
			[Note] NVARCHAR(max),
			[CreatedBy] bigint
			
        )tmp1


	

		select @shipToCode =ShipTo from Enquiry where EnquiryId = @Enquiry
		select @truckSizeId =TruckSizeId from Enquiry where EnquiryId = @Enquiry

		select @LocationId =LocationId from Location where LocationCode = (Select top 1 CollectionLocationCode from Enquiry Where EnquiryId=@Enquiry)


		if((select COUNT(*) from Route where DestinationId = @shipToCode and OriginId = @LocationId and TruckSizeId = @truckSizeId and IsActive = 1 ) = 1)
		BEGIN	
		Declare @CarrierId bigint
		Declare @CarrierCode nvarchar(50)
		Declare @CarrierName nvarchar(500)
		select @CarrierId=CompanyId, @CarrierCode=CompanyMnemonic, @CarrierName=CompanyName from Company where CompanyId in (select CarrierNumber from Route where DestinationId = @shipToCode and OriginId = @LocationId and TruckSizeId = @truckSizeId and IsActive = 1 )

		update [Enquiry] set CarrierId  = @CarrierId,CarrierCode = @CarrierCode, CarrierName = @CarrierName  where EnquiryId IN (@Enquiry)


	  END
	  ELSE
	  BEGIN
		update [Enquiry] set CarrierId  = NULL,CarrierCode = NULL, CarrierName = NULL  where EnquiryId IN (@Enquiry)
	  END

	  --update Enquiry set companyid=1 where companyid is null

  SELECT EnquiryId,EnquiryAutoNumber,CurrentState,IsActive From Enquiry where EnquiryId=@Enquiry FOR XML RAW('Json'),ELEMENTS
   End
   else
   begin
   --update Enquiry set companyid=1 where companyid is null
     SELECT EnquiryId,EnquiryAutoNumber,CurrentState,IsActive From Enquiry where Isnull(EnquiryGuid,'')=@MainOrderGUID FOR XML RAW('Json'),ELEMENTS
   end
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
