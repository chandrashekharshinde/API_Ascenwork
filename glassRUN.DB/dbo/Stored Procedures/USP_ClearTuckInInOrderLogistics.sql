Create PROCEDURE [dbo].[USP_ClearTuckInInOrderLogistics] --'<Json><ServicesAction>UpdateSchedulingDate</ServicesAction><EnquiryDetailList><SchedulingDate>15/12/2017</SchedulingDate><EnquiryId>236</EnquiryId></EnquiryDetailList></Json>'
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
    @orderId = tmp.[OrderId]
   
   
   

FROM OPENXML(@intpointer,'Json/OrderDetailList',2)
   WITH
   (
   [OrderId] bigint
   
           
   )tmp
  

  


  

   update OrderLogistics set TruckInTime= NULL where OrderMovementId in (select OrderMovementId from OrderMovement  where OrderId = @orderId and LocationType=1)

   update OrderLogisticHistory set IsActive=0 where OrderId=@orderId and PlateNumberBy='TruckIn'

    update [Order] set CurrentState=1103 where OrderId=@orderId 


   
   
   
   SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS

END
