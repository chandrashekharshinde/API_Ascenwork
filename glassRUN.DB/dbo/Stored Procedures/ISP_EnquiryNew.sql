
CREATE PROCEDURE [dbo].[ISP_EnquiryNew] -- '{"Json":{"CopyOrderGUID":"","OrderGUID":"7c3a0ebf-76de-4c31-952d-e685e4d3ffcb","EnquiryId":0,"EnquiryType":"SO","IsOrderSelfCollect":"0","ActivityStartTime":"2019/12/17 13:21:08","RequestDate":"19/12/2019","ShipToCode":"1111097","ShipTo":"284","SoldTo":66,"CompanyMnemonic":"1111097","CompanyId":1,"CompanyCode":"1111097","PONumber":"","SONumber":"20191217","CollectionCode":"","NoOfDays":"0","IsActive":true,"IsRecievingLocationCapacityExceed":false,"TruckSizeId":"15","NumberOfPalettes":7,"PalletSpace":6.3857142857142861,"CollectionDateFromSettingValue":"-1","OrderProposedETD":"19/12/2019","PreviousState":0,"CurrentState":"1","CurrentStateDraft":1,"CreatedBy":536,"OrderProductList":[{"OrderGUID":"7c3a0ebf-76de-4c31-952d-e685e4d3ffcb","EnquiryProductId":0,"ItemId":"8","ParentItemId":0,"ParentProductCode":"","AssociatedOrder":0,"ItemName":"Heineken 330x24C Ctn Festive","ItemPricesPerUnit":344545,"ProductCode":"65205003","PrimaryUnitOfMeasure":"Carton","ProductQuantity":894,"ProductType":"9","WeightPerUnit":"8.650000000000000e+000","IsActive":true,"ItemType":32,"CurrentItemPalettesCorrectWeight":6.3857142857142861,"CurrentItemTruckCapacityFullInTone":7.7331,"PackingItemCount":6.3857142857142861,"PackingItemCode":"0","IsPackingItem":"0","NumberOfExtraPalettes":0,"AllocationExcited":false,"AllocationQty":0,"DepositeAmountPerUnit":"0.00","CollectionCode":""},{"OrderGUID":"7c3a0ebf-76de-4c31-952d-e685e4d3ffcb","EnquiryProductId":0,"ItemId":"16","ParentItemId":0,"ParentProductCode":"","AssociatedOrder":0,"ItemName":"Pallet - Wooden MT","ItemPricesPerUnit":0,"ProductCode":"55909001","PrimaryUnitOfMeasure":"Each","ProductQuantity":7,"ProductType":"9","WeightPerUnit":0,"IsActive":true,"ItemType":0,"CurrentItemPalettesCorrectWeight":0,"CurrentItemTruckCapacityFullInTone":0.259,"PackingItemCount":0,"PackingItemCode":"0","IsPackingItem":"1","NumberOfExtraPalettes":0,"AllocationExcited":false,"AllocationQty":0,"DepositeAmountPerUnit":0,"CollectionCode":""}],"TotalAmount":308023230,"TotalQuantity":901,"TotalPrice":338825553,"TotalWeight":7.9921000000000006,"TotalVolume":7.9921000000000006,"TruckWeight":7.9921000000000006,"TotalDepositeAmount":0,"TotalTaxAmount":30802323,"TotalDiscountAmount":0,"totalorderamount":308023230,"totalDepositeamount":0,"EnquiryAutoNumber":"","PickDateTime":"18/12/2019"}}'
@jsonEnquiry nvarchar(max) 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255) 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	SET @ErrSeverity = 15; 

		BEGIN TRY
			--EXEC sp_xml_preparedocument @intpointer OUTPUT,@jsonEnquiry
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

		--set @jsonEnquiry = '[' + @jsonEnquiry + ']';
		Declare @pick datetime

		Declare @currentState bigint
		Select * into #tmpPickDate
		FROM OPENJSON(@jsonEnquiry, N'$')
		  WITH (
			PickDateTime nvarchar(50) N'$.Json.PickDateTime',
			[CurrentState] bigint N'$.Json.CurrentState'
		  )tmp;

		SET @pick=(Select CONVERT(datetime, #tmpPickDate.PickDateTime,103) from #tmpPickDate)
		SET @currentState=(Select  #tmpPickDate.CurrentState from #tmpPickDate)
		declare @AutoNumber nvarchar(max)= CONVERT(NVARCHAR(max),right(replicate('0',6-LEN(@ENQUIRYIDGENERATOR))+cast(@ENQUIRYIDGENERATOR as varchar(15)),10))
		declare @EnquiryAutoNumber nvarchar(max)='TINQ' +@AutoNumber

		declare @tmpStockLocationId nvarchar(max)=null
		declare @tmpCollectionCode nvarchar(max)=null

		Declare @CopyOrderGUID nvarchar(200)=''
		Declare @MainOrderGUID nvarchar(200)=''


    SELECT @tmpStockLocationId=case when (select count(distinct(r.OriginId)) from [Route] r join Location d on d.LocationId=r.OriginId where d.IsActive=1
		 and r.DestinationId=JSON_VALUE(@jsonEnquiry,'$.Json.ShipTo') and r.TruckSizeId=JSON_VALUE(@jsonEnquiry,'$.Json.TruckSizeId')) =1 then (select distinct(d.LocationCode )   
		 from [Route] r join Location d on d.LocationId=r.OriginId where d.IsActive=1 and r.DestinationId=JSON_VALUE(@jsonEnquiry,'$.Json.ShipTo') 
		 and r.TruckSizeId=JSON_VALUE(@jsonEnquiry,'$.Json.TruckSizeId')) else NULL end ,
		@tmpCollectionCode=JSON_VALUE(@jsonEnquiry,'$.Json.CollectionCode'),
		@CopyOrderGUID=JSON_VALUE(@jsonEnquiry,'$.Json.CopyOrderGUID'),
		@MainOrderGUID=JSON_VALUE(@jsonEnquiry,'$.Json.OrderGUID')
        
		--FROM OPENJSON(@jsonEnquiry, N'$')
		--WITH (
		--	[OrderGUID] nvarchar(200) N'$.Json.OrderGUID',
		--	[CopyOrderGUID] nvarchar(200) N'$.Json.CopyOrderGUID',
		--	[CollectionCode] nvarchar(100) N'$.Json.CollectionCode',
		--	[ShipTo] BIGINT N'$.Json.ShipTo',
		--	[SoldTo] BIGINT N'$.Json.SoldTo',
		--	[TruckSizeId] BIGINT N'$.Json.TruckSizeId',
		--	CompanyId bigint-- N'$.Json.CompanyId'
		-- )tmp;

		if(@tmpCollectionCode = '' or @tmpCollectionCode = null)
			begin
				set @tmpCollectionCode = null
			end
		
    
   --     INSERT INTO	[Enquiry]
   --     (
   --     	[EnquiryAutoNumber],
			--[EnquiryType],
			--PickDatetime,
   --     	[RequestDate],
			--[StockLocationId],
			--[EnquiryDate],
   --     	[PrimaryAddress],
   --     	[SecondaryAddress],
   --     	[OrderProposedETD],
			--[CompanyId],
			--[CompanyCode],		
			--[PONumber],
			--[SONumber],
			--[CollectionLocationCode],
   --     	[Remarks],
   --     	[PreviousState],
   --     	[CurrentState],
			--[TruckSizeId],
			--[NumberOfPalettes],
			--[PalletSpace],
			--[TruckWeight],
			--[ShipTo],
			--[ShipToCode],
			--[ShipToName],
			--[SoldTo],
			--[SoldToCode],
			--[SoldToName],
   --     	[CreatedBy],
   --     	[CreatedDate],        
   --     	[IsActive],
   --     	[SequenceNo],
			--[IsRecievingLocationCapacityExceed],
			--[TotalAmount],
			--[TotalQuantity],
			--[TotalPrice],
			--[TotalVolume],
			--[TotalWeight],
			--[TotalTaxAmount],
			--[TotalDiscountAmount],
			--[TotalDepositeAmount],
   --     	[Field1],
   --     	[Field2],
   --     	[Field3],
   --     	[Field4],
   --     	[Field5],
   --     	[Field6],
   --     	[Field7],
   --     	[Field8],
   --     	[Field9],
   --     	[Field10],
			--[EnquiryGuid],
			--[IsSelfCollect],
			--OriginalCollectionDate,
			--PromisedDate
   --     )

        SELECT
        	@EnquiryAutoNumber aS OrderNumber,
        	'SO',
			@pick,
        	CASE WHEN CONVERT(datetime, JSON_VALUE(@jsonEnquiry,'$.Json.RequestDate'),103) = '1900-01-01' THEN convert(datetime,JSON_VALUE(@jsonEnquiry,'$.Json.OrderProposedETD'), 103)  ELSE convert(datetime, JSON_VALUE(@jsonEnquiry,'$.Json.RequestDate'), 103)  END ,
			ISNULL(@tmpStockLocationId,@tmpCollectionCode),
			GETDATE(),
        	JSON_VALUE(@jsonEnquiry,'$.Json.PrimaryAddress'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.SecondaryAddress'),
			case when (select top 1 Field1 from Company cmp where cmp.CompanyId=JSON_VALUE(@jsonEnquiry,'$.Json.SoldTo')) ='SCO' then NULL else convert(datetime,JSON_VALUE(@jsonEnquiry,'$.Json.OrderProposedETD'), 103)  end as OrderProposedETD,
			(select Top 1 ParentCompany from Company where CompanyId = JSON_VALUE(@jsonEnquiry,'$.Json.SoldTo')),
			(select Top 1 CompanyMnemonic from Company where CompanyId = JSON_VALUE(@jsonEnquiry,'$.Json.SoldTo')),
			JSON_VALUE(@jsonEnquiry,'$.Json.PONumber'),
			NULL,
			ISNULL(@tmpCollectionCode,@tmpStockLocationId),
        	JSON_VALUE(@jsonEnquiry,'$.Json.Remarks'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.PreviousState'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.CurrentState'),
			JSON_VALUE(@jsonEnquiry,'$.Json.TruckSizeId'),
			JSON_VALUE(@jsonEnquiry,'$.Json.NumberOfPalettes'),
			JSON_VALUE(@jsonEnquiry,'$.Json.PalletSpace'),
			case when    Convert(decimal(18,2),JSON_VALUE(@jsonEnquiry,'$.Json.TruckWeight'))  is null then 0 else  Convert(decimal(18,2),JSON_VALUE(@jsonEnquiry,'$.Json.TruckWeight'))  end ,
			JSON_VALUE(@jsonEnquiry,'$.Json.ShipTo'),
			(select Top 1 LocationCode from Location where LocationId = JSON_VALUE(@jsonEnquiry,'$.Json.ShipTo')),
			(select Top 1 LocationName from Location where LocationId = JSON_VALUE(@jsonEnquiry,'$.Json.ShipTo')),
			JSON_VALUE(@jsonEnquiry,'$.Json.SoldTo'),
			(select Top 1 CompanyMnemonic from Company where CompanyId = JSON_VALUE(@jsonEnquiry,'$.Json.SoldTo')),
			(select Top 1 CompanyName from Company where CompanyId = JSON_VALUE(@jsonEnquiry,'$.Json.SoldTo')),
        	JSON_VALUE(@jsonEnquiry,'$.Json.CreatedBy'),
        	GETDATE(),        
        	JSON_VALUE(@jsonEnquiry,'$.Json.IsActive'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.SequenceNo'),
			JSON_VALUE(@jsonEnquiry,'$.Json.IsRecievingLocationCapacityExceed'),
			JSON_VALUE(@jsonEnquiry,'$.Json.TotalAmount'),
			JSON_VALUE(@jsonEnquiry,'$.Json.TotalQuantity'),
			JSON_VALUE(@jsonEnquiry,'$.Json.TotalPrice'),
			case when    Convert(decimal(18,2),JSON_VALUE(@jsonEnquiry,'$.Json.TotalVolume') ) is null then 0 else  Convert(decimal(18,2), JSON_VALUE(@jsonEnquiry,'$.Json.TotalVolume'))   end ,
			case when    Convert(decimal(18,2),JSON_VALUE(@jsonEnquiry,'$.Json.TotalWeight'))  is null then 0 else  Convert(decimal(18,2),JSON_VALUE(@jsonEnquiry,'$.Json.TotalWeight'))   end ,
			JSON_VALUE(@jsonEnquiry,'$.Json.TotalTaxAmount'),
			JSON_VALUE(@jsonEnquiry,'$.Json.TotalDiscountAmount'),
			JSON_VALUE(@jsonEnquiry,'$.Json.TotalDepositeAmount'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.Field1'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.Field2'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.Field3'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.Field4'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.Field5'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.Field6'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.Field7'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.NoOfDays'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.Field9'),
        	JSON_VALUE(@jsonEnquiry,'$.Json.Field10'),
			JSON_VALUE(@jsonEnquiry,'$.Json.OrderGUID'),
			JSON_VALUE(@jsonEnquiry,'$.Json.IsOrderSelfCollect'),
			@pick,
			CASE WHEN CONVERT(datetime, JSON_VALUE(@jsonEnquiry,'$.Json.RequestDate'),103) = '1900-01-01' THEN convert(datetime,JSON_VALUE(@jsonEnquiry,'$.Json.OrderProposedETD'), 103)  ELSE convert(datetime, JSON_VALUE(@jsonEnquiry,'$.Json.RequestDate') , 103)  END 
           
	-- Updating the Log table with Enquiry id based on the Guid
	DECLARE @Enquiry bigint
	SET @Enquiry = @@IDENTITY

	Update [Log] set ObjectId=@Enquiry where isnull(LogGuid,'')=@MainOrderGUID;

	-- If the Enquiry is copied from another Enquiry, copy the log of original enquiry

	If @CopyOrderGUID !='' 
	Begin

		INSERT INTO log 
			([UserId],[ObjectId],[ObjectType],[LogDescription],[FunctionCall],[LogDate],[LoggingTypeId],[Source],[LogGuid],[CreatedDate])
		Select 
		(SELECT TOP 1 UserId FROM Log WHERE [LogGuid]=@CopyOrderGUID),@Enquiry,'Enquiry Copied','Start Enquiry copy log',NULL,GETDATE(),3501,'Portal',@MainOrderGUID,GETDATE()

		INSERT INTO [dbo].[Log]
			([UserId],[ObjectId],[ObjectType],[LogDescription],[FunctionCall],[LogDate],[LoggingTypeId],[Source],[LogGuid],[CreatedDate])
		Select [UserId],@Enquiry,[ObjectType],[LogDescription],[FunctionCall],[LogDate],[LoggingTypeId],[Source],@MainOrderGUID,[CreatedDate] from [Log] Where [LogGuid]=@CopyOrderGUID

		INSERT INTO log 
		([UserId],[ObjectId],[ObjectType],[LogDescription],[FunctionCall],[LogDate],[LoggingTypeId],[Source],[LogGuid],[CreatedDate])
		Select 
		(select top 1 UserId From Log where [LogGuid]=@CopyOrderGUID),@Enquiry,'Enquiry Copied','End Enquiry copy log' ,NULL,GETDATE(),3501 ,'Portal',@MainOrderGUID,GETDATE()
	End

	-- Inserting Enquiry Products
	
	declare @EnquiryProductJson nvarchar(max)
	Select @EnquiryProductJson = JSON_QUERY(@jsonEnquiry, '$.Json.OrderProductList')
	print @EnquiryProductJson

	select JSON_VALUE(@EnquiryProductJson,'$.ProductCode') 


		 --INSERT INTO	[EnquiryProduct]
   --     (
   --     	[EnquiryId],
   --     	[ProductCode],
			--[ProductName],
			--[ParentProductCode],
   --     	[ProductType],
   --     	[ProductQuantity],
			--[UnitPrice],
			--[DepositeAmount],
   --     	[Remarks],
			--[AssociatedOrder],
			--[ItemType],
			--[CollectionLocationCode],
   --     	[CreatedBy],
   --     	[CreatedDate],        	
   --     	[IsActive],
   --     	[SequenceNo],
			--[NumberOfExtraPallet],
   --     	[Field1],
   --     	[Field2],
   --     	[Field3],
   --     	[Field4],
   --     	[Field5],
   --     	[Field6],
   --     	[Field7],
   --     	[Field8],
   --     	[Field9],
   --     	[Field10],
			--[TotalVolume],
			--[TotalWeight],
			--[PackingItemCount],
			--[PackingItemCode],
			--IsPackingItem
   --     )

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
			tmp.IsPackingItem
            --FROM OPENXML(@intpointer,'Json/OrderProductList',2)
			FROM OPENJSON(@EnquiryProductJson,  N'$')
        WITH
        (
            [EnquiryId] bigint N'$.EnquiryId',
            [ProductCode] nvarchar(200) N'$.ProductCode',
			[ParentProductCode] nvarchar(200) N'$.ParentProductCode',
            [ProductType] nvarchar(200) N'$.ProductType',
            [ProductQuantity] decimal(10, 2) N'$.ProductQuantity',
			[ItemPricesPerUnit] decimal(10, 2) N'$.ItemPricesPerUnit',
			[DepositeAmountPerUnit] decimal(10,2) N'$.DepositeAmountPerUnit',
            [Remarks] nvarchar N'$.Remarks',
			[AssociatedOrder] bigint N'$.AssociatedOrder',
			[ItemType] bigint N'$.ItemType',
			[CollectionCode] nvarchar(100) N'$.CollectionCode',
            [CreatedBy] bigint N'$.CreatedBy',
            [CreatedDate] datetime N'$.CreatedDate',           
            [IsActive] bit N'$.IsActive',
            [SequenceNo] bigint N'$.SequenceNo',
			[NumberOfExtraPalettes] nvarchar(50) N'$.NumberOfExtraPalettes',
            [Field1] nvarchar(500) N'$.Field1',
            [Field2] nvarchar(500) N'$.Field2',
            [Field3] nvarchar(500) N'$.Field3',
            [Field4] nvarchar(500) N'$.Field4',
            [Field5] nvarchar(500) N'$.Field5',
            [Field6] nvarchar(500) N'$.Field6',
            [Field7] nvarchar(500) N'$.Field7',
            [Field8] nvarchar(500) N'$.Field8',
            [Field9] nvarchar(500) N'$.Field9',
            [Field10] nvarchar(500) N'$.Field10',
			[CurrentItemPalettesCorrectWeight] decimal(10,2) N'$.CurrentItemPalettesCorrectWeight',
			[CurrentItemTruckCapacityFullInTone] decimal(10,2) N'$.CurrentItemTruckCapacityFullInTone',
			[PackingItemCount] decimal(10,2) N'$.PackingItemCount',
			[PackingItemCode] nvarchar(500) N'$.PackingItemCode',
			IsPackingItem bit-- N'$.IsPackingItem'
        )tmp


		-- INSERT INTO [ReturnPakageMaterial]
  --      (
  --      	[EnquiryId],
  --      	[ProductCode],
		--	[ParentProductCode],
  --      	[ProductType],
  --      	[ProductQuantity],
		--	[Price],
  --      	[Remarks],
		--	[AssociatedOrder],
		--	[ItemType],
  --      	[CreatedBy],
  --      	[CreatedDate],        	
  --      	[IsActive],
  --      	[SequenceNo],
  --      	[Field1],
  --      	[Field2],
  --      	[Field3],
  --      	[Field4],
  --      	[Field5],
  --      	[Field6],
  --      	[Field7],
  --      	[Field8],
  --      	[Field9],
  --      	[Field10]
  --      )

  --      SELECT
  --      	@Enquiry,
  --      	tmp.[ProductCode],
		--	tmp.[ParentProductCode],
  --      	tmp.[ProductType],
  --      	tmp.[ProductQuantity],
		--	0,
  --      	tmp.[Remarks],
		--	tmp.[AssociatedOrder],
		--	tmp.[ItemType],
  --      	1,
  --      	GETDATE(),        	
  --      	tmp.[IsActive],
  --      	tmp.[SequenceNo],
  --      	tmp.[Field1],
  --      	tmp.[Field2],
  --      	tmp.[Field3],
  --      	tmp.[Field4],
  --      	tmp.[Field5],
  --      	tmp.[Field6],
  --      	tmp.[Field7],
  --      	tmp.[Field8],
  --      	tmp.[Field9],
  --      	tmp.[Field10]
  --          --FROM OPENXML(@intpointer,'Json/ReturnPakageMaterialList',2)
		--	FROM OPENJSON(@jsonEnquiry,  N'$.Json.ReturnPakageMaterialList')
  --      WITH
  --      (
  --          [EnquiryId] bigint N'$.EnquiryId',
  --          [ProductCode] nvarchar(200) N'$.ProductCode',
		--	[ParentProductCode] nvarchar(200) N'$.ParentProductCode',
  --          [ProductType] nvarchar(200) N'$.ProductType',
  --          [ProductQuantity] decimal(10, 2) N'$.ProductQuantity',
		--	[ItemPricesPerUnit] decimal(10, 2) N'$.ItemPricesPerUnit',
  --          [Remarks] nvarchar N'$.Remarks',
		--	[AssociatedOrder] bigint N'$.AssociatedOrder',
		--	[ItemType] bigint N'$.ItemType',
  --          [CreatedBy] bigint N'$.CreatedBy',
  --          [CreatedDate] datetime N'$.CreatedDate',           
  --          [IsActive] bit N'$.IsActive',
  --          [SequenceNo] bigint N'$.SequenceNo',
  --          [Field1] nvarchar(500) N'$.Field1',
  --          [Field2] nvarchar(500) N'$.Field2',
  --          [Field3] nvarchar(500) N'$.Field3',
  --          [Field4] nvarchar(500) N'$.Field4',
  --          [Field5] nvarchar(500) N'$.Field5',
  --          [Field6] nvarchar(500) N'$.Field6',
  --          [Field7] nvarchar(500) N'$.Field7',
  --          [Field8] nvarchar(500) N'$.Field8',
  --          [Field9] nvarchar(500) N'$.Field9',
  --          [Field10] nvarchar(500) --N'$.Field10'
  --      )tmp
        
  --       -----------add event notfication for   order created --------
		-- if @currentState !=8
		-- BEGIN
		--		 INSERT INTO [EventNotification] ( [EventMasterId], [EventCode], [ObjectId], [ObjectType], [IsActive], [CreatedDate], [CreatedBy] ) 
		--	select (select EventMasterId  From EventMaster where EventCode='EnquiryCreated' and IsActive=1 ), 'EnquiryCreated', o.EnquiryId , 'Enquiry',1 , GETDATE() , o.CreatedBy  From   Enquiry  o  where o.EnquiryId=@Enquiry
		--	END
		--		 ------


		-- INSERT INTO [dbo].[Notes]
		--	    (
		--	       [RoleId]
		--		  ,[ObjectId]
		--		  ,[ObjectType]
		--		  ,[Note]
		--		  ,[IsActive]
		--		  ,[CreatedBy]
		--		  ,[CreatedDate]
				  
		--	    )

  --      SELECT
		--	    	tmp1.[RoleId],
		--	    	@Enquiry,
		--	    	tmp1.[ObjectType],        		
		--			tmp1.[Note],
		--	    	1,
		--			tmp1.[CreatedBy],
		--	    	GETDATE() 	
  --          --FROM OPENXML(@intpointer,'Json/NoteList',2)
		--	FROM OPENJSON(@jsonEnquiry,  N'$.Json.NoteList')
  --      WITH
  --      (
		--	[RoleId] bigint N'$.RoleId',
  --          [ObjectId] bigint N'$.ObjectId',
		--	[ObjectType] bigint N'$.ObjectType',
		--	[Note] NVARCHAR(max) N'$.Note',
		--	[CreatedBy] bigint --N'$.CreatedBy'
			
  --      )tmp1


	

		--select @shipToCode =ShipTo from Enquiry where EnquiryId = @Enquiry
		--select @truckSizeId =TruckSizeId from Enquiry where EnquiryId = @Enquiry

		--select @LocationId =LocationId from Location where LocationCode = (Select top 1 CollectionLocationCode from Enquiry Where EnquiryId=@Enquiry)


		--if((select COUNT(*) from Route where DestinationId = @shipToCode and OriginId = @LocationId and TruckSizeId = @truckSizeId and IsActive = 1 ) = 1)
		--BEGIN	
		--	Declare @CarrierId bigint
		--	Declare @CarrierCode nvarchar(50)
		--	Declare @CarrierName nvarchar(500)
		--	select @CarrierId=CompanyId, @CarrierCode=CompanyMnemonic, @CarrierName=CompanyName from Company where CompanyId in (select CarrierNumber from Route where DestinationId = @shipToCode and OriginId = @LocationId and TruckSizeId = @truckSizeId and IsActive = 1 )

		--	update [Enquiry] set CarrierId  = @CarrierId,CarrierCode = @CarrierCode, CarrierName = @CarrierName  where EnquiryId IN (@Enquiry)

		----INSERT INTO [dbo].[EventNotification]
  ----         ([EventMasterId]
  ----         ,[EventCode]
  ----         ,[ObjectId]
  ----         ,[ObjectType]
  ----         ,[IsActive]
  ----         ,[CreatedBy]
  ----         ,[CreatedDate])
		----Select (Select top 1 EventMasterId from EventMaster 
		----where EventCode='OrderAssignedToTransporter' and IsActive=1),'OrderAssignedToTransporter',@Enquiry,'Enquiry',1,1,GETDATE() 
	 -- END
	 -- ELSE
	 -- BEGIN
		--update [Enquiry] set CarrierId  = NULL,CarrierCode = NULL, CarrierName = NULL  where EnquiryId IN (@Enquiry)
	 -- END


        --Add child table insert procedure when required.
    --SELECT @Enquiry as EnquiryId,@EnquiryAutoNumber as EnquiryAutoNumber FOR XML RAW('Json'),ELEMENTS
	--SELECT @Enquiry as EnquiryId,@EnquiryAutoNumber as EnquiryAutoNumber FOR JSON PATH, ROOT('Json')
   
    --exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END

