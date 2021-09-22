CREATE View [dbo].[ReturnPakageMaterialView]    AS
SELECT [ReturnPakageMaterialId]
      ,[EnquiryId]
      ,[ProductCode]
	  ,i.ItemId  AS ItemId
	  ,i.ItemName AS ItemName
	  ,l.Name AS PrimaryUnitOfMeasure
      ,rpm.[ProductType]
      ,rpm.[ProductQuantity]
	  ,i.StockInQuantity
	  ,i.ItemShortCode
	  ,rpm.ItemType
 from dbo.[ReturnPakageMaterial] rpm left join dbo.Item i on rpm.ProductCode = i.ItemCode
 Left join dbo.lookup l on l.lookupid=i.PrimaryUnitOfMeasure
   WHERE rpm.IsActive = 1