CREATE PROCEDURE [dbo].[USP_OrderCancel] --'<Json><UpdatedBy>8</UpdatedBy><OrderProductList><ProductQuantity>10</ProductQuantity><IsActive>1</IsActive><ProductCode>55909001</ProductCode><ProductType>9</ProductType><UnitPrice>0.0000</UnitPrice><ItemType>0</ItemType><CreatedBy>8</CreatedBy><UpdatedBy>8</UpdatedBy><Remarks></Remarks><SequenceNo>0</SequenceNo><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.00</DepositeAmount></OrderProductList><OrderProductList><ProductQuantity>1000</ProductQuantity><IsActive>1</IsActive><ProductCode>65205121</ProductCode><ProductType>9</ProductType><UnitPrice>230000.0000</UnitPrice><ItemType>32</ItemType><CreatedBy>8</CreatedBy><UpdatedBy>8</UpdatedBy><Remarks></Remarks><SequenceNo>0</SequenceNo><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.00</DepositeAmount></OrderProductList><OrderProductList><EnquiryProductId>0</EnquiryProductId><ProductQuantity>300</ProductQuantity><IsActive>1</IsActive><EnquiryId>76633</EnquiryId><ProductCode>65205131</ProductCode><ProductType>9</ProductType><UnitPrice>0</UnitPrice><ItemType>32</ItemType><CreatedBy>8</CreatedBy><UpdatedBy>8</UpdatedBy><Remarks></Remarks><SequenceNo>0</SequenceNo><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.00</DepositeAmount></OrderProductList></Json>'

@xmlDoc xml

AS


BEGIN
DECLARE @intPointer INT;
Declare @OrderId bigint;
Declare @RejectedStatus bigint=0

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	   @OrderId = tmp.[OrderId]
	  
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[OrderId] bigint
			)tmp

	INSERT INTO	[OrderCancellationDetails] 
	(
		OrderNumber,
		OrderId,
		UserId,
		CancellationDatetime,
		CancellationReason,
		Remarks,
		IsActive
	)

	SELECT 
		tmp.[OrderNumber],
		tmp.[OrderId],
		tmp.[UserId],
		GETDATE(),
		tmp.[CancellationReason],
		tmp.[Remarks],
		1
   FROM OPENXML(@intpointer,'Json',2)
	WITH
	(
		OrderNumber Nvarchar(200),
		OrderId bigint,
		UserId bigint,
		CancellationReason Nvarchar(200),
		Remarks nvarchar(200)
	)tmp
	
	update [order] set [CurrentState]=999 where OrderId=@OrderId;

	UPDATE [OrderCancellationDetails] SET CancellationReason=(Select Top 1 ReasonCodeId from ReasonCodeObjectMapping where ObjectId = @OrderId and ObjectType = 'Order' AND EventName='CancelOrder'
 order by ReasonCodeObjectMapping desc) WHERE OrderId=@OrderId


 	exec [dbo].[ISP_InsertInEventNotification] 999,@orderId

SELECT @OrderId as OrderId FOR XML RAW('Json'),ELEMENTS

END


PRINT 'Successfully created procedure dbo.USP_Enquiry'