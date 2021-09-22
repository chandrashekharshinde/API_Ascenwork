
CREATE PROCEDURE [dbo].[SSP_ObjectLists_ForSearchFunctionality] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><SalesOrderNumber>SO1482989762</SalesOrderNumber></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @SalesOrderNumber nvarchar(100)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @SalesOrderNumber = tmp.[SalesOrderNumber]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[SalesOrderNumber] nvarchar(100)
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((SELECT   (select cast ((SELECT  'true' AS [@json:Array]  ,  OrderProductId,OrderId,ProductCode,op.ProductType,ProductQuantity,i.ItemName,
	
	  i.ItemId,
	       (SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as UOM,
	  UnitPrice,ShippableQuantity,BackOrderQuantity,CancelledQuantity,Remarks, op.CreatedDate,op.IsActive,  ISNULL(op.AssociatedOrder,0) as AssociatedOrder
	  ,(SELECT [dbo].[fn_GetWeightPerUnitOfItem] (i.ItemId)) as [WeightPerUnit]

	  ,umo.[ConversionFactor]
	
		from OrderProduct op left join Item i on op.ProductCode = i.ItemCode
		join UnitOfMeasure umo on I.ItemId=umo.ItemId  
  
 FOR XML path('OrderProductsList'),ELEMENTS) AS xml)),

 (select cast ((SELECT  'true' AS [@json:Array]  ,[ReturnPakageMaterialId]
      ,[EnquiryId]
      ,[ProductCode]
	  ,(SELECT ItemId FROM dbo.Item WHERE ItemCode=[ProductCode]) AS ItemId
	  ,(SELECT ItemName FROM dbo.Item WHERE ItemCode=[ProductCode]) AS ItemName
	    ,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) AS PrimaryUnitOfMeasure
      ,rpm.[ProductType]
      ,rpm.[ProductQuantity]
		  ,i.StockInQuantity
	   ,i.ItemShortCode
	    ,rpm.ItemType
		from [ReturnPakageMaterial] rpm left join Item i on rpm.ProductCode = i.ItemCode
			
   WHERE rpm.IsActive = 1  and  i.IsActive = 1 
 FOR XML path('ReturnPakageMaterialList'),ELEMENTS) AS xml))

	
	 	
	 FOR XML RAW('Json'),ELEMENTS) AS xml)
	
	
	
END
