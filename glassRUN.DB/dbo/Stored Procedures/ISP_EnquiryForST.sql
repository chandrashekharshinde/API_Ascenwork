CREATE PROCEDURE [dbo].[ISP_EnquiryForST] --'<Json><RequestDate>2017-10-26T00:00:00</RequestDate><EnquiryType>ST</EnquiryType><ShipTo>18</ShipTo><SoldTo>0</SoldTo><TruckSizeId>1</TruckSizeId><branchPlant>7</branchPlant><IsActive>true</IsActive><PreviousState>0</PreviousState><CurrentState>1</CurrentState><CreatedBy>2</CreatedBy><OrderProductList><ItemId>97</ItemId><ItemName>Affligem Blond 300x24B Ctn</ItemName><ProductCode>65801001</ProductCode><PrimaryUnitOfMeasure>0</PrimaryUnitOfMeasure><ProductQuantity>1</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>100</WeightPerUnit><IsActive>true</IsActive></OrderProductList><OrderProductList><ItemId>105</ItemId><ItemName>Desperados 330x12C Ctn</ItemName><ProductCode>65705131</ProductCode><PrimaryUnitOfMeasure>0</PrimaryUnitOfMeasure><ProductQuantity>3</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>100</WeightPerUnit><IsActive>true</IsActive></OrderProductList></Json>'
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



		 -- Select *  FROM OPENXML(@intpointer,'Json/EnquiryList',2)
   --     WITH
   --     (
   --         [EnquiryAutoNumber] nvarchar(100),
          
   --         [RequestDate] datetime,
          
   --         [PrimaryAddress] nvarchar(500),
   --         [SecondaryAddress] nvarchar(500),
   --         [OrderProposedETD] datetime,
   --         [Remarks] nvarchar,
   --         [PreviousState] bigint,
   --         [CurrentState] bigint,
			--[TruckSizeId] BIGINT,
			--[ShipTo] BIGINT,
			--[SoldTo] BIGINT,
   --         [CreatedBy] bigint,
   --         [CreatedDate] datetime,           
   --         [IsActive] bit,
   --         [SequenceNo] bigint,
   --         [Field1] nvarchar(500),
   --         [Field2] nvarchar(500),
   --         [Field3] nvarchar(500),
   --         [Field4] nvarchar(500),
   --         [Field5] nvarchar(500),
   --         [Field6] nvarchar(500),
   --         [Field7] nvarchar(500),
   --         [Field8] nvarchar(500),
   --         [Field9] nvarchar(500),
   --         [Field10] nvarchar(500)
   --     )tmp




        INSERT INTO	[Enquiry]
        (
        	[EnquiryAutoNumber],
			[EnquiryType],
        	[RequestDate],
			
			[EnquiryDate],
        	[PrimaryAddress],
        	[SecondaryAddress],
        	[OrderProposedETD],
        	[Remarks],
        	[PreviousState],
        	[CurrentState],
			[TruckSizeId],
			[NumberOfPalettes],
			[TruckWeight],
			[ShipTo],
			[SoldTo],
        	[CreatedBy],
        	[CreatedDate],        
        	[IsActive],
        	[SequenceNo],
			[IsRecievingLocationCapacityExceed],
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
        	'INQ' + CONVERT(NVARCHAR(max),right(replicate('0',6-LEN(@ENQUIRYIDGENERATOR))+cast(@ENQUIRYIDGENERATOR as varchar(15)),10)) aS OrderNumber,
        	tmp.[EnquiryType],
        	--tmp.[RequestDate],
        	CASE WHEN CONVERT(datetime, tmp.[RequestDate],103) = '1900-01-01' THEN Null ELSE convert(datetime, tmp.[RequestDate] , 103)  END ,
			
			GETDATE(),
        	tmp.[PrimaryAddress],
        	tmp.[SecondaryAddress],
        	--CAST(tmp.[OrderProposedETD] AS datetime2),
			convert(datetime,tmp.[OrderProposedETD], 103)  ,
			--tmp.[OrderProposedETD],
        	tmp.[Remarks],
        	tmp.[PreviousState],
        	tmp.[CurrentState],
			tmp.[TruckSizeId],
				tmp.[NumberOfPalettes],
			tmp.[TruckWeight],
			tmp.[ShipTo],
			tmp.[SoldTo],
        	tmp.[CreatedBy],
        	GETDATE(),        
        	tmp.[IsActive],
        	tmp.[SequenceNo],
			tmp.[IsRecievingLocationCapacityExceed],
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
            FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            [EnquiryAutoNumber] nvarchar(100),
			[EnquiryType] nvarchar(100),
            [RequestDate] nvarchar(50),
            [PrimaryAddress] nvarchar(500),
            [SecondaryAddress] nvarchar(500),
            [OrderProposedETD] nvarchar(50),
            [Remarks] nvarchar,
            [PreviousState] bigint,
            [CurrentState] bigint,
			[TruckSizeId] BIGINT,
			[NumberOfPalettes] decimal(18,2),
			[TruckWeight]  decimal(18,2),
			[ShipTo] BIGINT,
			[SoldTo] BIGINT,
            [CreatedBy] bigint,
            [CreatedDate] datetime,           
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
            [Field10] nvarchar(500)
        )tmp
        
        DECLARE @Enquiry bigint
	    SET @Enquiry = @@IDENTITY
        

		 INSERT INTO	[EnquiryProduct]
        (
        	[EnquiryId],
        	[ProductCode],
        	[ProductType],
        	[ProductQuantity],
			[UnitPrice],
        	[Remarks],
			[AssociatedOrder],
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
        	tmp.[ProductType],
        	tmp.[ProductQuantity],
			case when isnull(tmp.[AssociatedOrder],0)=0 then  tmp.[ItemPricesPerUnit]  else 0 end,
        	tmp.[Remarks],
			tmp.[AssociatedOrder],
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
            FROM OPENXML(@intpointer,'Json/EnquiryProductList',2)
        WITH
        (
            [EnquiryId] bigint,
            [ProductCode] nvarchar(200),
            [ProductType] nvarchar(200),
            [ProductQuantity] decimal(10, 2),
			[ItemPricesPerUnit] decimal(10, 2),
            [Remarks] nvarchar,
			[AssociatedOrder] bigint,
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



        --Add child table insert procedure when required.
    SELECT @Enquiry as EnquiryId FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
