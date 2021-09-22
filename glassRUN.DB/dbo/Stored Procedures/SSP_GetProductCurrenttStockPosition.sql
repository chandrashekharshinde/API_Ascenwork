Create PROCEDURE [dbo].[SSP_GetProductCurrenttStockPosition] --'<Json><ProductCode>65102011</ProductCode><DeliveryLocationCode>6410</DeliveryLocationCode></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @ProductCode BIGINT;
declare @DeliveryLocationCode nvarchar(200)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @ProductCode = tmp.[ProductCode],
       @DeliveryLocationCode = tmp.[DeliveryLocationCode]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[ProductCode] bigint,
				[DeliveryLocationCode] nvarchar(200)
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select  
 
 Convert(Decimal(18,0),(SELECT ISNULL([dbo].[fn_AvailableProductQuantity] (@ProductCode,@DeliveryLocationCode),0))) as CurrentStockPosition

	FOR XML RAW('ItemStock'),ELEMENTS
	
	
	
END
