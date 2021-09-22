
CREATE PROCEDURE [dbo].[USP_UpdatePickShift] --'<Json><ServicesAction>UpdatePickShift</ServicesAction><OrderId>13150</OrderId><PickupShift>3</PickupShift></Json>'
	(@xmlDoc XML)
AS
BEGIN
	DECLARE @intPointer INT;
	DECLARE @orderId BIGINT
	DECLARE @pickupShift NVARCHAR(50)

	EXEC sp_xml_preparedocument @intpointer OUTPUT
		,@xmlDoc

	SELECT @orderId = tmp.[OrderId]
		,@pickupShift = tmp.PickupShift
	FROM OPENXML(@intpointer, 'Json', 2) WITH (
			[OrderId] BIGINT
			,PickupShift NVARCHAR(50)
			) tmp

	UPDATE OrderMovement
	SET PraposedShift = @pickupShift
	WHERE OrderId = @orderId

    print @orderId 

	SELECT @orderId AS OrderId
	FOR XML RAW('Json')
		,ELEMENTS
END
