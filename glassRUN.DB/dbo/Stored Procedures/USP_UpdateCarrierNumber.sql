CREATE PROCEDURE [dbo].[USP_UpdateCarrierNumber]-- '<Json><ServicesAction>UpdateOrderBranchPlant</ServicesAction><OrderDetailList><BranchPlantName>1007</BranchPlantName><OrderId>77409</OrderId></OrderDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @OrderId nvarchar(500)
Declare @branchPlantCode nvarchar(50)
Declare @StockLocationName nvarchar(50)
Declare @CarrierNumber nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @OrderId = tmp.[OrderId],
    @CarrierNumber = tmp.CarrierNumber
   
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] nvarchar(500),
   [CarrierNumber] nvarchar(50)  
           
   )tmp
  
  update [order] set CarrierNumber  = @CarrierNumber where orderid IN (SELECT * FROM [dbo].[fnSplitValues] (@OrderId))

  SELECT @CarrierNumber as CarrierNumber FOR XML RAW('Json'),ELEMENTS

END
