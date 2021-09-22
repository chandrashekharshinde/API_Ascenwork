CREATE PROCEDURE [dbo].[USP_UpdateDeliveryStatusForOrder]
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @orderId bigint
Declare @ModifiedBy bigint

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @orderId = tmp.[OrderId],
   @ModifiedBy = tmp.[ModifiedBy]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [OrderId] bigint,
   [ModifiedBy] bigint
   )tmp
  

	update [Order] set CurrentState  = 103,ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE() where OrderId IN (@orderId)

  SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS
   

END