

CREATE PROCEDURE [dbo].[USP_UpdateBranchPlantInOrder] --'<Json><ServicesAction>UpdateBranchPlant</ServicesAction><EnquiryDetailList><BranchPlantName>11</BranchPlantName><EnquiryId>10197</EnquiryId></EnquiryDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @orderId bigint
Declare @branchPlantCode nvarchar(50)
Declare @BranchPlantName nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @orderId = tmp.[OrderId],
    @BranchPlantName = tmp.[BranchPlantName]
   
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] bigint,
   [BranchPlantName] nvarchar(50)  
           
   )tmp
  

  select @branchPlantCode=DeliveryLocationCode from DeliveryLocation where DeliveryLocationId=@BranchPlantName


  print @orderId
  print @branchPlantCode
  -- update [Order] set StockLocationId  = @branchPlantCode where OrderId = @orderId

   

   
   SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS

END
