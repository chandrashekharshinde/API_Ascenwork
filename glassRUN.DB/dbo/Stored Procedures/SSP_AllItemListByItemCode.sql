Create PROCEDURE [dbo].[SSP_AllItemListByItemCode] --'<Json><CompanyId>1</CompanyId></Json>'
(
@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @itemCode nvarchar(100)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @itemCode = tmp.[ItemCode]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ItemCode] nvarchar(100)
			)tmp


SELECT CAST((SELECT  I.[ItemId]
      ,I.[ItemName]
      ,I.[ItemCode]
      ,I.[ItemShortCode]
      ,I.[PrimaryUnitOfMeasure]
      ,I.[SecondaryUnitOfMeasure]
      ,I.[ProductType]
      ,I.[BussinessUnit]
      ,I.[DangerGoods]
      ,I.[Description]
      ,I.[StockInQuantity]
      ,I.[WeightPerUnit]
      ,I.[ImageUrl]
      ,I.[PackSize]
      ,I.[BranchPlant]
      ,I.[CreatedBy]
      ,I.[CreatedDate]
      ,I.[ModifiedBy]
      ,I.[ModifiedDate]
      ,I.[IsActive]
      ,I.[SequenceNo]
      ,I.[Field1]
      ,I.[Field2]
      ,I.[Field3]
      ,I.[Field4]
      ,I.[Field5]
      ,I.[Field6]
      ,I.[Field7]
      ,I.[Field8]
      ,I.[Field9]
      ,I.[Field10]
	  --,(SELECT [dbo].[fn_GetPriceOfItem] ([ItemId],@CompanyId)) as Amount
	  ,0 as Amount
     
  FROM [Item] I WHERE I.IsActive =1 and i.ItemCode=@itemCode
	FOR XML RAW('ItemList'),ELEMENTS,ROOT('Item')) AS XML)
END
