-- =============================================
-- Author:  	<Author,,Alok>
-- Create date: <Wednesday 05-Feb-2020>
-- Description:	<Insert product list,,>
-- =============================================
CREATE PROCEDURE [dbo].[ISP_SaveProductV2]
-- Add the parameters for the stored procedure here

 
@ItemName nvarchar(500),
@ItemNameEnglishLanguage nvarchar(500),
@ItemCode nvarchar(500),
@ItemShortCode nvarchar(500),
@PrimaryUnitOfMeasure nvarchar(500),
@SecondaryUnitOfMeasure nvarchar(500),
@ProductType nvarchar(500),
@BussinessUnit nvarchar(500),
@DangerGoods bit,
@Description nvarchar(500),
@StockInQuantity bigint,
@WeightPerUnit bigint,
@ImageUrl nvarchar(500),
@PackSize bigint,
@BranchPlant nvarchar(500),
@CreatedBy bigint,
@CreatedDate nvarchar(500),
@ModifiedBy bigint,
@ModifiedDate nvarchar(500),
@IsActive bit,
@SequenceNo bigint,
@PricingUnit nvarchar(500),
@ShippingUnit nvarchar(500),
@ComponentUnit nvarchar(500),
@ItemClass nvarchar(500),
@ShelfLife nvarchar(500),
@BBD nvarchar(500),
@Barcode nvarchar(500),
@ItemOwner bigint,
@Field1 nvarchar(500),
@Field2 nvarchar(500),
@Field3 nvarchar(500),
@Field4 nvarchar(500),
@Field5 nvarchar(500),
@Field6 nvarchar(500),
@Field7 nvarchar(500),
@Field8 nvarchar(500),
@Field9 nvarchar(500),
@Field10 nvarchar(500),
@ItemType nvarchar(500),
@AutomatedWareHouseUOM bigint,
@Tax nvarchar(500),
@Length bigint,
@Breadth bigint,
@Height bigint,
@Brand nvarchar(500)

AS
BEGIN
  DECLARE @ItemID BIGINT;
  DECLARE @ErrMsg NVARCHAR(2048) 
  DECLARE @ErrSeverity INT;
  SET NOCOUNT ON
   
  SET @ErrSeverity = 15;

   begin try 
   begin tran
  INSERT INTO dbo.Item 
   ( 
		ItemName,ItemNameEnglishLanguage,ItemCode,ItemShortCode,PrimaryUnitOfMeasure,SecondaryUnitOfMeasure,ProductType,
		BussinessUnit,DangerGoods,Description,StockInQuantity,WeightPerUnit,ImageUrl,PackSize,BranchPlant,CreatedBy,CreatedDate,ModifiedBy,
		ModifiedDate,IsActive,SequenceNo,PricingUnit,ShippingUnit,ComponentUnit,ItemClass,ShelfLife,BBD,Barcode,ItemOwner,Field1,Field2,Field3,
		Field4,Field5,Field6,Field7,Field8,Field9,Field10,ItemType,AutomatedWareHouseUOM,Tax,Length,Breadth,Height,Brand
    )
    VALUES
	 ( 
		@ItemName, @ItemNameEnglishLanguage, @ItemCode, @ItemShortCode, @PrimaryUnitOfMeasure, @SecondaryUnitOfMeasure, @ProductType, 
		@BussinessUnit, @DangerGoods, @Description, @StockInQuantity, @WeightPerUnit, @ImageUrl, @PackSize, @BranchPlant, @CreatedBy, @CreatedDate, 
		@ModifiedBy, @ModifiedDate, @IsActive, @SequenceNo, @PricingUnit, @ShippingUnit, @ComponentUnit, @ItemClass, @ShelfLife, @BBD, @Barcode,
		@ItemOwner, @Field1, @Field2, @Field3, @Field4, @Field5, @Field6, @Field7, @Field8, @Field9, @Field10, @ItemType, @AutomatedWareHouseUOM, @Tax,
		@Length, @Breadth, @Height, @Brand
	 )


    SET @ItemID = @@IDENTITY 
	select @ItemID as ItemID, '200' as Status

	commit
	end try
	 BEGIN catch 
	 ROLLBACK; 
	 SELECT @ErrMsg = Error_message(); 

	 RAISERROR(@ErrMsg,@ErrSeverity,1); 

          
	 end catch
	
END