Create PROCEDURE [dbo].[USP_UpdateConfirmedPickupDateInOrderMovement] --'<Json><ServicesAction>UpdateSchedulingDate</ServicesAction><EnquiryDetailList><SchedulingDate>15/12/2017</SchedulingDate><EnquiryId>236</EnquiryId></EnquiryDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @orderId bigint
Declare @pickupDate nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @orderId = tmp.[OrderId],
    @pickupDate = tmp.[PickupDate]
   
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] bigint,
   [PickupDate] nvarchar(50)  
           
   )tmp
  

  




   update OrderMovement set ExpectedTimeOfAction  = convert(datetime,@pickupDate, 103) where OrderId = @orderId and LocationType=1

   
   
   
   SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS

END
