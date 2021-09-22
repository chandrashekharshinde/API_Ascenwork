CREATE PROCEDURE [dbo].[SSP_AllItemSoldToMappingListById] --'<Json><ServicesAction>GetAllItemListById</ServicesAction><ItemId>297</ItemId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @itemId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @itemId = tmp.[ItemId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[ItemId] bigint
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,ItemId,(Select ItemName from Item where ItemId=ItemSoldToMapping.ItemId) as ItemName,(Select ItemCode from Item where ItemId=ItemSoldToMapping.ItemId) as ItemCode from ItemSoldToMapping where ItemId=@itemId
	FOR XML path('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
END