CREATE PROCEDURE [dbo].[DSP_OrderFeedback] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @OrderFeedbackId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @OrderFeedbackId = tmp.[OrderFeedbackId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[OrderFeedbackId] bigint
           
			)tmp ;


			
Update OrderFeedback SET IsActive=0 where OrderFeedbackId=@OrderFeedbackId
Update OrderFeedback SET IsActive=0 where ParentOrderFeedbackReplyId=@OrderFeedbackId
update OrderFeedbackReply set IsActive = 0 where OrderFeedbackId = @OrderFeedbackId

 SELECT @OrderFeedbackId as OrderFeedbackId FOR XML RAW('Json'),ELEMENTS
END
