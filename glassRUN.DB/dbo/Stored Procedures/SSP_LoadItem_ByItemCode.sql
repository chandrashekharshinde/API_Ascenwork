CREATE PROCEDURE [dbo].[SSP_LoadItem_ByItemCode] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><SalesOrderNumber>18016808</SalesOrderNumber><RoleId>3</RoleId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @ItemCode nvarchar(100)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ItemCode = tmp.[ItemCode]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[ItemCode] nvarchar(100)
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((SELECT 
	[ItemId],
    ItemName,
    ItemCode,
    ItemShortCode,
    PrimaryUnitOfMeasure,
   SecondaryUnitOfMeasure,
       ProductType,
       BussinessUnit
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
	  ,(SELECT [dbo].[fn_GetPriceOfItem] (i.[ItemId],0)) as Amount
	  ,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as UOM
      
	  , (select cast ((SELECT  'true' AS [@json:Array]  ,  UnitOfMeasureId,ItemId,
	  UOM,
	  RelatedUOM,
	  Convert(Decimal(18,6),u.ConversionFactor) as ConversionFactor,
	  IsActive
		from  UnitOfMeasure u 
   WHERE   u.ItemId = i.ItemId and IsActive = 1
 FOR XML path('ItemUOMList'),ELEMENTS) AS xml))

 
	FROM Item i
	
	
	 WHERE (ItemCode = @ItemCode OR @ItemCode = '')  
	FOR XML path('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END
