CREATE PROCEDURE [dbo].[ISP_Item] --'<Json><ServicesAction>InsertItem</ServicesAction><ItemList><ItemId>100001</ItemId><ItemGuId>828bd52b-5a90-48fd-bf85-72e4c5a6cee2</ItemGuId><ItemName>itemlist123</ItemName><ItemShortCode>12</ItemShortCode><ItemCode>1234567</ItemCode><ItemNameCode>itemlist123 (1234567)</ItemNameCode><Name>itemlist123 (1234567)</Name><ProductType>9</ProductType><PrimaryUnitOfMeasure></PrimaryUnitOfMeasure><RelatedPrimaryUnitOfMeasure></RelatedPrimaryUnitOfMeasure><ConversionFactor></ConversionFactor><ImageUrl></ImageUrl><QtyPerLayer>0</QtyPerLayer><Amount>12</Amount><BussinessUnit>ssdfs</BussinessUnit><StockInQuantity>0</StockInQuantity><PackSize></PackSize><BranchPlant></BranchPlant><EffectiveDate>8/2/2019</EffectiveDate><ExpiryDate>8/2/2019</ExpiryDate><IsNewAddedItem>true</IsNewAddedItem><CreatedBy>409</CreatedBy><ConversionInformationList><ConversionInfoGUID>3ff14bc6-1f76-402e-9169-8ac8e04d4ed9</ConversionInfoGUID><PrimaryUOMName>Bottles</PrimaryUOMName><RelatedUOMName>Carton</RelatedUOMName><PrimaryUnitOfMeasure>9</PrimaryUnitOfMeasure><RelatedUnitOfMeasure>11</RelatedUnitOfMeasure><Conversion>12</Conversion><IsActive>true</IsActive><CreatedBy>409</CreatedBy></ConversionInformationList><CollectionLocationList><CollectionId>1015</CollectionId><CollectionName>Shipper 1 Pick UP -1 (1015)</CollectionName><IsActive>true</IsActive><CreatedBy>409</CreatedBy></CollectionLocationList><CollectionLocationList><CollectionId>1016</CollectionId><CollectionName>Shipper 1 Pick Up -2 (1016)</CollectionName><IsActive>true</IsActive><CreatedBy>409</CreatedBy></CollectionLocationList><CollectionLocationList><CollectionId>1019</CollectionId><CollectionName>Madurai (1019)</CollectionName><IsActive>true</IsActive><CreatedBy>409</CreatedBy></CollectionLocationList><BusinessUnit>ssdfs</BusinessUnit><PricingUnit>ghjhf</PricingUnit><ShippingUnit>sghjf</ShippingUnit><ComponentUnit>sdfgdbvcdfg</ComponentUnit><Field1></Field1><Field2></Field2><Field3></Field3><Field4></Field4><Field5></Field5><Field6></Field6><Field7></Field7><Field8></Field8><Field9></Field9><Field10></Field10><ShelfLife>8/2/2019</ShelfLife><BBD>8/2/2019</BBD><Barcode>dfhdgdf</Barcode><ItemOwner>1</ItemOwner><Brand>gdhfghfhdgsd</Brand><AutomatedWareHouseUOM>1</AutomatedWareHouseUOM></ItemList><isNewAddedItem>1</isNewAddedItem></Json>'
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

			Declare @itemCode nvarchar(50)
			Declare @itemShortCode nvarchar(50)
		

		Select * INTO #tmpItem 
		FROM OPENXML(@intpointer,'Json/ItemList',2)
        WITH
        (
            [ItemName] nvarchar(500),
            [ItemCode] nvarchar(200),			
            [ItemShortCode] nvarchar(200),
            [PrimaryUnitOfMeasure] nvarchar(20),
            [SecondaryUnitOfMeasure] nvarchar(20)           
           
        )tmp


		SET @itemCode=(Select [ItemCode] from #tmpItem)
		SET @itemShortCode=(Select [ItemShortCode] from #tmpItem)


			
        INSERT INTO	[Item]
        (
        	[ItemName],
        	[ItemCode],
			ItemNameEnglishLanguage,
        	[ItemShortCode],
        	[PrimaryUnitOfMeasure],
        	[SecondaryUnitOfMeasure],
        	[ProductType],
        	[BussinessUnit],
        	[DangerGoods],
        	[Description],
        	[StockInQuantity],
        	[WeightPerUnit],
        	[ImageUrl],
        	[PackSize],
        	[BranchPlant],
        	[CreatedBy],
        	[CreatedDate],        	
        	[IsActive],
        	[SequenceNo],
			[PricingUnit],
			[ShippingUnit],
			[ComponentUnit],
			[ShelfLife],
			[BBD],
			[Barcode],
			[ItemOwner],
			[Brand],
			AutomatedWareHouseUOM,
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
			[Length],
			[Breadth],
			[Height],
			[Tax]
        )

        SELECT
        	tmp.[ItemName],
        	tmp.[ItemCode],
			tmp.ItemNameEnglishLanguage,
        	tmp.[ItemShortCode],
        	tmp.[PrimaryUnitOfMeasure],
        	tmp.[SecondaryUnitOfMeasure],
        	tmp.[ProductType],
        	tmp.[BussinessUnit],
        	tmp.[DangerGoods],
        	tmp.[Description],
        	tmp.[StockInQuantity],
        	tmp.[WeightPerUnit],
        	tmp.[ImageUrl],
        	tmp.[PackSize],
        	tmp.[BranchPlant],
        	tmp.[CreatedBy],
        	GETDATE(),        	
        	1,
        	tmp.[SequenceNo],
			tmp.[PricingUnit],
			tmp.[ShippingUnit],
			tmp.[ComponentUnit],
			tmp.[ShelfLife],
			tmp.[BBD],
			tmp.[Barcode],
			1,
			tmp.[Brand],
			tmp.AutomatedWareHouseUOM,
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
			tmp.[Length],
			tmp.[Breadth],
			tmp.[Height],
			tmp.[Tax]
            FROM OPENXML(@intpointer,'Json/ItemList',2)
        WITH
        (
            [ItemName] nvarchar(500),
            [ItemCode] nvarchar(200),
			ItemNameEnglishLanguage nvarchar(500),
            [ItemShortCode] nvarchar(200),
            [PrimaryUnitOfMeasure] nvarchar(20),
            [SecondaryUnitOfMeasure] nvarchar(20),
            [ProductType] nvarchar(50),
            [BussinessUnit] nvarchar(50),
            [DangerGoods] bit,
            [Description] nvarchar(500),
            [StockInQuantity] decimal(10, 2),
            [WeightPerUnit] decimal(10, 2),
            [ImageUrl] nvarchar,
            [PackSize] bigint,
            [BranchPlant] nvarchar(200),
            [CreatedBy] bigint,
            [CreatedDate] datetime,         
            [IsActive] bit,
            [SequenceNo] bigint,
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
        )tmp
        
        DECLARE @Item bigint
	    SET @Item = @@IDENTITY

			

		INSERT INTO	UnitOfMeasure
        (
        	[ItemId],
			UOM,
			RelatedUOM,
			ConversionFactor,
			IsActive        	
        )

        SELECT
        	@Item,
        	tmp.[PrimaryUnitOfMeasure],
        	tmp.[RelatedUnitOfMeasure],
        	tmp.[Conversion],
			1
        
            FROM OPENXML(@intpointer,'Json/ItemList/ConversionInformationList',2)
        WITH
        (
            [ItemId] nvarchar(500),
            [PrimaryUnitOfMeasure] nvarchar(20),
			[RelatedUnitOfMeasure] nvarchar(20),
			[Conversion] nvarchar(20),
			IsActive bit
         
        )tmp


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
		

		--INSERT INTO	ItemSoldToMapping
  --      (
  --      	ItemId,
		--	SoldTo,
		--	ShipTo,			
		--	IsActive,
		--	CreatedBy,
		--	CreatedDate
        	
  --      )

  --      SELECT
  --      	@Item,
  --      	tmp.[SoldTo],
  --      	0,
  --      	1,
		--	tmp.CreatedBy,
		--	GETDATE()
        
  --          FROM OPENXML(@intpointer,'Json/ItemList/CompanyList',2)
  --      WITH
  --      (
  --          [ItemId] nvarchar(500),
  --          [SoldTo] nvarchar(50),			
		--	ShipTo bigint,
  --          IsActive bit,
  --          CreatedBy bigint,
		--	CreatedDate datetime
         
  --      )tmp


  INSERT INTO	ItemBranchPlantMapping
        (
        	ItemId,
			BranchPlantId,				
			IsActive,
			CreatedBy,
			CreatedDate
        	
        )

        SELECT
        	@Item,
        	tmp.[CollectionId],        	
        	1,
			tmp.CreatedBy,
			GETDATE()
        
            FROM OPENXML(@intpointer,'Json/ItemList/CollectionLocationList',2)
        WITH
        (
            [ItemId] nvarchar(500),           		
			CollectionId bigint,
            IsActive bit,
            CreatedBy bigint,
			CreatedDate datetime
         
        )tmp



        
        --Add child table insert procedure when required.
     --SELECT @Item as ItemId FOR XML RAW('Json'),ELEMENTS
	 SELECT distinct  I.[ItemId]
      ,I.[ItemName]
      ,I.[ItemCode]
	  ,I.[ItemName] + ' (' + I.[ItemCode] + ')' as ItemNameCode
	  ,I.[ItemCode] as Id
	  ,I.[ItemName] + ' (' + I.[ItemCode] + ')' as Name
      ,I.[ItemShortCode] from Item I where I.ItemId=@Item
	  FOR XML RAW('Json'),ELEMENTS
   
    
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
