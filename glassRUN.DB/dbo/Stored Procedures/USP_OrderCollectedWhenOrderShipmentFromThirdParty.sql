CREATE PROCEDURE [dbo].[USP_OrderCollectedWhenOrderShipmentFromThirdParty]

@orderId bigint

AS
BEGIN

DECLARE  @Currentstatus   bigint
SET  @Currentstatus   = (select   CurrentState  From  [order]  where OrderId=@orderId)

	IF(@Currentstatus = 560)
	BEGIN
		DECLARE @ordermovementId BIGINT
		SET   @ordermovementId  = (SELECT   OrderMovementId  FROM OrderMovement  WHERE OrderId=@orderId and LocationType=1)

		----- update ordermovement  
		UPDATE  OrderMovement  SET   ActualTimeOfAction =GETDATE()  WHERE  OrderMovementId=    @ordermovementId

		----update order collected Quantity 
		UPDATE OrderProductMovement   

		SET ActualQuantity=op.ShippableQuantity ,
		DeliveryStartTime =GETDATE(),
		DeliveryEndTime =GETDATE(),
		IsDeliveredAll=1

		FROM OrderProduct  op   JOIN  OrderProductMovement  opm  
		ON op.OrderId =opm.OrderId  AND op.OrderProductId =opm.OrderId 
		WHERE opm.OrderMovementId=@ordermovementId
	END
END
