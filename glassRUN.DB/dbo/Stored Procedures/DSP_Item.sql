
CREATE PROCEDURE [dbo].[DSP_Item] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @itemId bigint;
Declare @IsActive bigint;
Declare @ModifiedBy bigint;



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @itemId = tmp.[ItemId],
	   @IsActive = tmp.[IsActive],
	   @ModifiedBy = tmp.[ModifiedBy]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ItemId] bigint,
			[IsActive] bit,
            [ModifiedBy] bigint
			)tmp ;

INSERT INTO [dbo].[ItemHistory]
           ([ItemId]
           ,[ItemName]
           ,[ItemNameEnglishLanguage]
           ,[ItemCode]
           ,[ItemShortCode]
           ,[PrimaryUnitOfMeasure]
           ,[SecondaryUnitOfMeasure]
           ,[ProductType]
           ,[BussinessUnit]
           ,[DangerGoods]
           ,[Description]
           ,[StockInQuantity]
           ,[WeightPerUnit]
           ,[ImageUrl]
           ,[PackSize]
           ,[BranchPlant]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[ModifiedBy]
           ,[ModifiedDate]
           ,[IsActive]
           ,[SequenceNo]
           ,[PricingUnit]
           ,[ShippingUnit]
           ,[ComponentUnit]
           ,[ItemClass]
           ,[ShelfLife]
           ,[BBD]
           ,[Barcode]
           ,[ItemOwner]
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
           ,[ItemType]
           ,[AutomatedWareHouseUOM]
           ,[Tax]
           ,[Length]
           ,[Breadth]
           ,[Height]
           ,[Brand])
     SELECT * From Item where ItemId = @itemId
			
Update Item SET IsActive= @IsActive, ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE()  where ItemId=@itemId
 SELECT @itemId as TruckSize FOR XML RAW('Json'),ELEMENTS
END
