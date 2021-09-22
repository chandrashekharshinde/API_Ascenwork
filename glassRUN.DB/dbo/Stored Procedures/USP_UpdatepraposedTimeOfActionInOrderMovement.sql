Create PROCEDURE [dbo].[USP_UpdatepraposedTimeOfActionInOrderMovement]-- '<Json><PraposedTimeOfAction>19/04/2018 00:00:00</PraposedTimeOfAction><SalesOrderNumber></SalesOrderNumber><OrderId>76568</OrderId><PraposedShift></PraposedShift><LocationType>1</LocationType></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @orderId bigint
Declare @praposedTimeOfAction nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @orderId = tmp.[OrderId],
    @praposedTimeOfAction = tmp.[PraposedTimeOfAction]
   
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [OrderId] bigint,
   [PraposedTimeOfAction] nvarchar(50)  
           
   )tmp
  

  


  print @orderId

   update [OrderMovement] set PraposedTimeOfAction  = convert(datetime,@praposedTimeOfAction, 103) where OrderId = @orderId

   
   
   
   SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS

END
