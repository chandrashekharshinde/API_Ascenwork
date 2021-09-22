CREATE PROCEDURE [dbo].[USP_UpdateCollectionDateForSelectedOrder]-- '<Json><ServicesAction>UpdateOrderCollectionDate</ServicesAction><OrderDetailList><CollectionDate>26/07/2019</CollectionDate><OrderId>779</OrderId></OrderDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @OrderId nvarchar(500)
Declare @collectionDate nvarchar(50)
Declare @StockLocationName nvarchar(50)
Declare @BranchPlantName nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @OrderId = tmp.[OrderId],
    @collectionDate = tmp.[CollectionDate]
   
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] nvarchar(500),
   [CollectionDate] nvarchar(50)  
           
   )tmp
 
  update [Enquiry] set PickDateTime  = convert(datetime,@collectionDate, 103) where EnquiryId IN  (SELECT * FROM [dbo].[fnSplitValues] (@OrderId))

  

  SELECT @collectionDate as CollectionDate FOR XML RAW('Json'),ELEMENTS
   

END