Create PROCEDURE [dbo].[SSP_Item_ByItemId] --1
@itemId BIGINT
AS
BEGIN

	SELECT [ItemId]
      ,[ItemName]
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
	FROM [dbo].[Item]
	 WHERE (ItemId=@itemId OR @itemId=0) AND IsActive=1
	FOR XML RAW('Item'),ELEMENTS
	
	
	
END
