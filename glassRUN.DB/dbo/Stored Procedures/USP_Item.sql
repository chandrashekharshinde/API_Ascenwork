CREATE PROCEDURE [dbo].[USP_Item] --'<Json><ServicesAction>InsertItem</ServicesAction><ItemList><ItemId>260</ItemId><ItemGuId>7b1fff50-2f95-4fe2-b424-97ba353b6e8c</ItemGuId><ItemName>Beer 640x12 Bottle Crt</ItemName><ItemShortCode>74</ItemShortCode><ItemNameEnglishLanguage>Tiger 640x12B Crt Gold</ItemNameEnglishLanguage><ItemCode>65102011</ItemCode><ItemNameCode>Beer 640x12 Bottle Crt (65102011)</ItemNameCode><Name>Beer 640x12 Bottle Crt (65102011)</Name><ProductType>9</ProductType><PrimaryUnitOfMeasure>10</PrimaryUnitOfMeasure><ImageUrl></ImageUrl><QtyPerLayer>0</QtyPerLayer><StockInQuantity>0</StockInQuantity><PackSize></PackSize><BranchPlant></BranchPlant><ExpiryDate></ExpiryDate><IsNewAddedItem>true</IsNewAddedItem><CreatedBy>409</CreatedBy><ConversionInformationList><UnitOfMeasureId>2797</UnitOfMeasureId><ItemId>260</ItemId><PrimaryUOMName>Crate</PrimaryUOMName><RelatedUOMName>Layer</RelatedUOMName><PrimaryUnitOfMeasure>10</PrimaryUnitOfMeasure><RelatedUnitOfMeasure>17</RelatedUnitOfMeasure><Conversion>11.000000</Conversion><IsActive>1</IsActive><ConversionInfoGUID>025C832A-B4EC-45CE-B235-38D9332A5AC3</ConversionInfoGUID></ConversionInformationList><ConversionInformationList><UnitOfMeasureId>2798</UnitOfMeasureId><ItemId>260</ItemId><PrimaryUOMName>Crate</PrimaryUOMName><RelatedUOMName>Pallet</RelatedUOMName><PrimaryUnitOfMeasure>10</PrimaryUnitOfMeasure><RelatedUnitOfMeasure>16</RelatedUnitOfMeasure><Conversion>66.000000</Conversion><IsActive>1</IsActive><ConversionInfoGUID>1FFC00D8-13ED-4910-B7CD-35FB2D84B6C0</ConversionInfoGUID></ConversionInformationList><ConversionInformationList><UnitOfMeasureId>2796</UnitOfMeasureId><ItemId>260</ItemId><PrimaryUOMName>Kg</PrimaryUOMName><RelatedUOMName>Crate</RelatedUOMName><PrimaryUnitOfMeasure>18</PrimaryUnitOfMeasure><RelatedUnitOfMeasure>10</RelatedUnitOfMeasure><Conversion>15.400000</Conversion><IsActive>1</IsActive><ConversionInfoGUID>543E80D3-C600-4793-9DF0-D7C6C6904269</ConversionInfoGUID></ConversionInformationList><Field1></Field1><Field2></Field2><Field3></Field3><Field4></Field4><Field5></Field5><Field6></Field6><Field7></Field7><Field8></Field8><Field9></Field9><Field10></Field10></ItemList><isNewAddedItem>1</isNewAddedItem></Json>'

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
            DECLARE @ItemId bigint
			Declare @itemCode nvarchar(100)
			Declare @itemShortCode nvarchar(100)
            UPDATE dbo.Item SET
			@ItemId=tmp.ItemId,
			@itemCode=tmp.ItemCode,
			@itemShortCode=tmp.ItemShortCode,
        	[ItemName]=tmp.ItemName ,
        	[ItemCode]=tmp.ItemCode ,        	
        	[PrimaryUnitOfMeasure]=tmp.PrimaryUnitOfMeasure,
			ItemNameEnglishLanguage=tmp.ItemNameEnglishLanguage,
			ItemShortCode=tmp.ItemShortCode,
			BussinessUnit=tmp.BussinessUnit,
			[PricingUnit]=tmp.[PricingUnit],
			[ShippingUnit]=tmp.[ShippingUnit],
			[ComponentUnit]=tmp.[ComponentUnit],
			[ShelfLife]=tmp.[ShelfLife],
			[BBD]=tmp.[BBD],
			[Barcode]=tmp.[Barcode],
			[ItemOwner]=tmp.[ItemOwner],
			[Brand]=tmp.[Brand],
			AutomatedWareHouseUOM=tmp.AutomatedWareHouseUOM,
			[Field1]=tmp.[Field1],
			[Field2]=tmp.[Field2],
        	[Field3]=tmp.[Field3],
        	[Field4]=tmp.[Field4],
        	[Field5]=tmp.[Field5],
        	[Field6]=tmp.[Field6],
        	[Field7]=tmp.[Field7],
        	[Field8]=tmp.[Field8],
        	[Field9]=tmp.[Field9],
        	[Field10]=tmp.[Field10],
			[Length]=tmp.[Length],
			[Breadth]=tmp.[Breadth],
			[Height]=tmp.[Height],
			[Tax]=tmp.[Tax]
        	
            FROM OPENXML(@intpointer,'Json/ItemList',2)
			WITH
			(
            [ItemId] bigint,           
            [ItemName] nvarchar(500),           
            [ItemCode] nvarchar(200),
            [PrimaryUnitOfMeasure] nvarchar(20),
			ItemNameEnglishLanguage nvarchar(500),
			[ItemShortCode] nvarchar(200),
			[BussinessUnit] nvarchar(50),
			[PricingUnit] nvarchar(500),
			[ShippingUnit] nvarchar(500),
			[ComponentUnit] nvarchar(500),
			[ShelfLife] nvarchar(200),
			[BBD] nvarchar(200),
			[Barcode] nvarchar(200),
			[ItemOwner] bigint,
			[Brand] nvarchar(200),
			AutomatedWareHouseUOM bigint,
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
			[Length] decimal(18,2),
			[Breadth] decimal(18,2),
			[Height] decimal(18,2),
			Tax nvarchar(50)

            )tmp WHERE Item.[ItemId]=tmp.[ItemId]


			  select * into #tmpPriceDetailsList
    FROM OPENXML(@intpointer,'Json/ItemList',2)
        WITH
        (
		[ItemId] bigint,
		[ItemName] nvarchar(150),
		Amount decimal(18,2)
			
        )tmp






		--declare @itemCount bigint
		--SET @itemCount=(select Count(*) from PriceListDetails where ItemId=@ItemId)
		--If @itemCount = 0
		--BEGIN
		--INSERT INTO	[PriceListDetails]
  --      (
  --      	[ItemId],
		--	[Amount],
		--	[IsTaxInclusive],
		--	[PriceListId],
		--	IsActive,
		--	CreatedBy,
		--	CreatedDate
        	
  --      )

  --      SELECT
  --      	@ItemId,
  --      	tmp.[Amount],
  --      	0,
  --      	1,
		--	1,
		--	tmp.CreatedBy,
		--	GETDATE()
        
  --          FROM OPENXML(@intpointer,'Json/ItemList',2)
  --      WITH
  --      (
  --          [ItemId] nvarchar(500),
  --          [Amount] decimal(18,2),
		--	[IsTaxInclusive] bit,
		--	PriceListId bigint,
  --          IsActive bit,
  --          CreatedBy bigint,
		--	CreatedDate datetime
         
  --      )tmp
		--END
		--ELSE
		--BEGIN
		--	update [PriceListDetails] set Amount=#tmpPriceDetailsList.Amount from #tmpPriceDetailsList where [PriceListDetails].ItemId=@ItemId
		--END


		delete ItemBasePrice where ItemLongCode=@itemCode




INSERT INTO	ItemBasePrice
        (
        	ItemLongCode,
			ItemShortCode,
			AddressNumber,
			CurrencyCode,
			UOM,
			EffectiveDate,
			ExpiryDate,
			Price,
			CustomerGroupID,
			ItemGroupId
        	        )

        SELECT
        	@itemCode,
        	@itemShortCode,
			0,
        	tmp.[CurrencyCode],
        	tmp.[UOMShortCode],
			DBO.DMYTOJUL(CONVERT(date,tmp.[EffectiveDate],103)),
			DBO.DMYTOJUL(CONVERT(date,tmp.[ExpiryDate],103)),
			tmp.[ItemPrice],
			0,
			0
                    FROM OPENXML(@intpointer,'Json/ItemList/ItemBasePriceList',2)
        WITH
        (
            [ItemCode] nvarchar(50),
            [ItemShortCode] bigint,
			CurrencyCode nvarchar(10),
			UOMShortCode nvarchar(10),
			EffectiveDate nvarchar(20),
			ExpiryDate nvarchar(20),
			[ItemPrice] decimal(18,2)
         
        )tmp











		select * into #tmpConversionInformationList
    FROM OPENXML(@intpointer,'Json/ItemList/ConversionInformationList',2)
        WITH
        (
		[UnitOfMeasureId] bigint,
		 [ItemId] nvarchar(500),
            [UOM] nvarchar(20),
			[RelatedUOM] nvarchar(20),
			[Conversion] nvarchar(20),
			PrimaryUnitOfMeasure bigint,
			[RelatedUnitOfMeasure] bigint,
			IsActive bit
        )tmp


update UnitOfMeasure set IsActive = 0 where ItemId = @ItemId

update UnitOfMeasure set IsActive = 1,UOM=#tmpConversionInformationList.[PrimaryUnitOfMeasure],RelatedUOM=#tmpConversionInformationList.[RelatedUnitOfMeasure]
,ConversionFactor=#tmpConversionInformationList.[Conversion] from #tmpConversionInformationList 
where UnitOfMeasure.[UnitOfMeasureId] = #tmpConversionInformationList.[UnitOfMeasureId]


INSERT INTO	UnitOfMeasure
        (
        	[ItemId],
			UOM,
			RelatedUOM,
			ConversionFactor,
			IsActive        	
        )

        SELECT
        	@ItemId,#tmpConversionInformationList.[PrimaryUnitOfMeasure],#tmpConversionInformationList.[RelatedUnitOfMeasure],#tmpConversionInformationList.[Conversion],1  from #tmpConversionInformationList
			WHERE #tmpConversionInformationList.[UnitOfMeasureId]=0



			select * into #tmpCollectionLocationList
    FROM OPENXML(@intpointer,'Json/ItemList/CollectionLocationList',2)
        WITH
        (
		ItemBranchPlantMappingId bigint,
		[ItemId] nvarchar(500),           		
			CollectionId bigint,
            IsActive bit,
            CreatedBy bigint,
			CreatedDate datetime
        )tmp

update ItemBranchPlantMapping set IsActive = 0 where ItemId = @ItemId

update ItemBranchPlantMapping set IsActive = 1,BranchPlantId=#tmpCollectionLocationList.CollectionId from #tmpCollectionLocationList
 where ItemBranchPlantMapping.ItemBranchPlantMappingId = #tmpCollectionLocationList.ItemBranchPlantMappingId


  INSERT INTO	ItemBranchPlantMapping (ItemId,BranchPlantId,IsActive,CreatedBy,CreatedDate)
          SELECT @ItemId,#tmpCollectionLocationList.[CollectionId],1,#tmpCollectionLocationList.CreatedBy,GETDATE()
        
            FROM #tmpCollectionLocationList where #tmpCollectionLocationList.ItemBranchPlantMappingId=0



	--select * into #tmpCompanyList
 --   FROM OPENXML(@intpointer,'Json/ItemList/CompanyList',2)
 --       WITH
 --       (
	--	[ItemSoldToMappingId] bigint,
	--	[ItemId] bigint,
	--	[SoldTo] nvarchar(50),
 --       [CreatedBy] bigint
 --       )tmp

	--update ItemSoldToMapping set IsActive = 0 where ItemId = @ItemId

	--update ItemSoldToMapping set IsActive = 1 from #tmpCompanyList where ItemSoldToMapping.ItemId = @ItemId and ItemSoldToMapping.SoldTo = #tmpCompanyList.[SoldTo]

	--		INSERT INTO	ItemSoldToMapping
 --       (
 --       	ItemId,
	--		SoldTo,
	--		ShipTo,			
	--		IsActive,
	--		CreatedBy,
	--		CreatedDate
        	
 --       )
 --    SELECT  	@ItemId, 
	--        	#tmpCompanyList.[SoldTo], 	
	--	        0,
 --           	1,
	--	    	#tmpCompanyList.CreatedBy,
	--	     	GETDATE()
 --               FROM #tmpCompanyList
 --               WHERE #tmpCompanyList.ItemSoldToMappingId=0


             SELECT @ItemId as ItemId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
