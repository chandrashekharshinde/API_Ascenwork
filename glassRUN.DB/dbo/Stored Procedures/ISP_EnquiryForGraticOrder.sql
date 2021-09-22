

CREATE PROCEDURE [dbo].[ISP_EnquiryForGraticOrder] --'<Json><OrderGUID>5c6b5f48-c1f6-4e5b-8171-2fdb0071b8b5</OrderGUID><EnquiryId>0</EnquiryId><RequestDate>30/06/2018</RequestDate><NoOfDays>1</NoOfDays><ShipTo>647</ShipTo><SoldTo>592</SoldTo><TruckSizeId>16</TruckSizeId><IsActive>true</IsActive><IsRecievingLocationCapacityExceed>false</IsRecievingLocationCapacityExceed><NumberOfPalettes>10</NumberOfPalettes><PalletSpace>9.4</PalletSpace><TruckWeight>10.146</TruckWeight><OrderProposedETD>30/06/2018</OrderProposedETD><PreviousState>0</PreviousState><CurrentState>1</CurrentState><CurrentStateDraft>1</CurrentStateDraft><CreatedBy>12</CreatedBy><OrderProductList><OrderGUID>5c6b5f48-c1f6-4e5b-8171-2fdb0071b8b5</OrderGUID><EnquiryProductId>0</EnquiryProductId><ItemId>51</ItemId><ParentItemId>0</ParentItemId><ParentProductCode></ParentProductCode><AssociatedOrder>0</AssociatedOrder><ItemName>Heineken 250x24C Tray Festive</ItemName><ItemPricesPerUnit>398182</ItemPricesPerUnit><ProductCode>65200501</ProductCode><PrimaryUnitOfMeasure>Carton</PrimaryUnitOfMeasure><ProductQuantity>1504</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>6.500000000000000e+000</WeightPerUnit><IsActive>true</IsActive><ItemType>32</ItemType><DepositeAmountPerUnit>0.00</DepositeAmountPerUnit></OrderProductList><OrderProductList><OrderGUID>5c6b5f48-c1f6-4e5b-8171-2fdb0071b8b5</OrderGUID><EnquiryProductId>0</EnquiryProductId><ItemId>226</ItemId><ParentItemId>0</ParentItemId><ParentProductCode></ParentProductCode><AssociatedOrder>0</AssociatedOrder><ItemName>Wooden Pallet</ItemName><ItemPricesPerUnit>0</ItemPricesPerUnit><ProductCode>55909001</ProductCode><PrimaryUnitOfMeasure>Each</PrimaryUnitOfMeasure><ProductQuantity>10</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>0</WeightPerUnit><IsActive>true</IsActive><ItemType>0</ItemType><DepositeAmountPerUnit>0</DepositeAmountPerUnit></OrderProductList></Json>'
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



		
   declare @AutoNumber nvarchar(max)= CONVERT(NVARCHAR(max),right(replicate('0',6-LEN(@ENQUIRYIDGENERATOR))+cast(@ENQUIRYIDGENERATOR as varchar(15)),10))
   declare @EnquiryAutoNumber nvarchar(max)='TINQ' +@AutoNumber

  
		
    
        INSERT INTO	[Enquiry]
        (
			CompanyId,
			CompanyCode,
        	[EnquiryAutoNumber],
			[EnquiryType],
			PickDatetime,
        	[RequestDate],
			[StockLocationId],
			[EnquiryDate],
        	[PrimaryAddress],
        	[SecondaryAddress],
        	[OrderProposedETD],
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
			[OrderedBy]   ,
			[GratisCode] ,
			[Province] ,
			[Description1]  ,
			[Description2]  
        )

        SELECT
		   (select Top 1 ParentCompany from Company where CompanyId = tmp.[SoldTo]),
		   (select   top 1 CompanyMnemonic From  Company  where CompanyId in (select Top 1 ParentCompany from Company where CompanyId = tmp.[SoldTo])),
		    @EnquiryAutoNumber aS OrderNumber,
        	tmp.[EnquiryType],
			tmp.[PickDatetime],
        	--tmp.[RequestDate],
        	CASE WHEN CONVERT(datetime, tmp.[RequestDate],103) = '1900-01-01' THEN convert(datetime,tmp.[OrderProposedETD], 103)  ELSE convert(datetime, tmp.[RequestDate] , 103)  END ,
			--case when (select count(distinct(r.OriginId)) from [Route] r join Location d on d.LocationId=r.OriginId where d.IsActive=1 and r.DestinationId=tmp.[ShipTo] and r.TruckSizeId=tmp.[TruckSizeId]) =1 then (select distinct(d.LocationCode )   from [Route] r join Location d on d.LocationId=r.OriginId where d.IsActive=1 and r.DestinationId=tmp.[ShipTo] and r.TruckSizeId=tmp.[TruckSizeId]) else NULL end ,
			(select LocationCode  From Location  where LocationId=  tmp.[StockLocationId]),
			GETDATE(),
        	tmp.[PrimaryAddress],
        	tmp.[SecondaryAddress],
        	case when (select top 1 Field1 from Company cmp where cmp.CompanyId=tmp.[SoldTo]) ='SCO' then NULL else convert(datetime,tmp.[OrderProposedETD], 103)  end as OrderProposedETD,
			tmp.[PONumber],
			@AutoNumber,
			(select LocationCode  From  [Location]  l where l.LocationId=tmp.[StockLocationId] ),
        	tmp.[Remarks],
        	tmp.[PreviousState],
        	370,
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
			tmp.OrderedBy   ,
			tmp.GratisCode ,
			tmp.Province ,
			tmp.Description1  ,
			tmp.Description2  
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
            [Remarks] nvarchar,
            [PreviousState] bigint,
            [CurrentState] bigint,
			[TruckSizeId] BIGINT,
			[PalletSpace] decimal(18,2),
			[NumberOfPalettes] decimal(18,2),
			[TruckWeight]  nvarchar(250),
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
			[TotalVolume]  nvarchar(250),
			[TotalWeight]  nvarchar(250),
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
			[StockLocationId]  bigint,
			OrderedBy  bigint ,
			GratisCode  nvarchar(250),
			Province  nvarchar(250),
			Description1  nvarchar(250),
			Description2  nvarchar(250)
        )tmp
        


        DECLARE @Enquiry bigint
	    SET @Enquiry = @@IDENTITY
        

	


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
			[PackingItemCount],
			[PackingItemCode],
			IsPackingItem
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
			tmp.[PackingItemCount],
			tmp.[PackingItemCode],
			tmp.IsPackingItem
            FROM OPENXML(@intpointer,'Json/EnquiryProductList',2)
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
			[PackingItemCount] decimal(10,2),
			[PackingItemCode] nvarchar(500),
			IsPackingItem bit
        )tmp



        --Add child table insert procedure when required.
    SELECT @Enquiry as EnquiryId,@EnquiryAutoNumber as EnquiryAutoNumber FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
