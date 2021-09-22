CREATE PROCEDURE [dbo].[USP_OrderReceived]
(
	@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @orderId bigint;


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

	SELECT 
		@orderId = tmp.[OrderId] 
	FROM OPENXML(@intpointer,'Json',2)
	WITH
	(
		[OrderId] bigint
	)tmp
  
   update [Order] set CurrentState = (select Top 1 LookUpId from LookUp where Code='OrderReceived') where OrderId = @orderId

   SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS

END
