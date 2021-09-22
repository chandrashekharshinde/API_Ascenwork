CREATE PROCEDURE [dbo].[USP_UpdateConfirmedPickupShiftInOrderMovement] --'<Json><ServicesAction>UpdateSchedulingDate</ServicesAction><EnquiryDetailList><SchedulingDate>15/12/2017</SchedulingDate><EnquiryId>236</EnquiryId></EnquiryDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @orderId bigint
Declare @pickupShift nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @orderId = tmp.[OrderId],
    @pickupShift = tmp.PickupShift
   
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] bigint,
   PickupShift nvarchar(50)  
           
   )tmp
  

  




   update OrderMovement set ExpectedShift  = @pickupShift where OrderId = @orderId and LocationType=1

   
   
   
   SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS

END
