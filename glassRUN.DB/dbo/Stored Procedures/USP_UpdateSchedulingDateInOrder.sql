CREATE PROCEDURE [dbo].[USP_UpdateSchedulingDateInOrder] --'<Json><ServicesAction>UpdateSchedulingDate</ServicesAction><EnquiryDetailList><SchedulingDate>15/12/2017</SchedulingDate><EnquiryId>236</EnquiryId></EnquiryDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @orderId bigint
Declare @SchedulingDate nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @orderId = tmp.[OrderId],
    @SchedulingDate = tmp.[SchedulingDate]
   
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] bigint,
   [SchedulingDate] nvarchar(50)  
           
   )tmp
  

  


  print @orderId

   update [Order] set ExpectedTimeOfDelivery  = convert(datetime,@SchedulingDate, 103) where OrderId = @orderId

   
   
   
   SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS

END
