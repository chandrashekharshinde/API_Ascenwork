

CREATE PROCEDURE [dbo].[USP_UpdateBranchPlantInEnquiry] --'<Json><ServicesAction>UpdateBranchPlant</ServicesAction><EnquiryDetailList><BranchPlantName>11</BranchPlantName><EnquiryId>10197</EnquiryId></EnquiryDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @enuiryId bigint
Declare @branchPlantCode nvarchar(50)
Declare @BranchPlantName nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @enuiryId = tmp.[EnquiryId],
    @BranchPlantName = tmp.[BranchPlantName]
   
   

FROM OPENXML(@intpointer,'Json/EnquiryDetailList',2)
   WITH
   (
   [EnquiryId] bigint,
   [BranchPlantName] nvarchar(50)  
           
   )tmp
  

  select @branchPlantCode=DeliveryLocationCode from DeliveryLocation where DeliveryLocationId=@BranchPlantName


  print @enuiryId
  print @branchPlantCode
 --  update [Enquiry] set StockLocationId  = @branchPlantCode where EnquiryId = @enuiryId

   

   
   SELECT @enuiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS

END
