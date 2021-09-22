CREATE PROCEDURE [dbo].[ISP_InsertCustomerAppOrderDeliveryFeedback] 
@xmlDoc xml 
AS 
 BEGIN 
 SET ARITHABORT ON 
 DECLARE @TranName NVARCHAR(255) 
 DECLARE @ErrMsg NVARCHAR(2048) 
 DECLARE @ErrSeverity INT; 
 DECLARE @intPointer INT; 
 SET @ErrSeverity = 15; 

  BEGIN TRY
   EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

        Declare @orderProductId bigint
  Declare @returnQuantity decimal(10,2)

INSERT INTO [dbo].[OrderFeedback]
           ([OrderId]
           ,[OrderProductId]
           ,[feedbackId]
		   ,[Field1]
           ,[Comment]
           ,[Quantity]
		   ,[ParentOrderFeedbackReplyId]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive])

		   Select 
		    tmp.[OrderId]
           ,0
           ,tmp.[feedbackId]
		   ,tmp.[ItemFeedbackName]
           ,tmp.[Comment]
           ,0
		   ,0
           ,tmp.[CreatedBy]
           ,GETDATE()
           ,1
            FROM OPENXML(@intpointer,'Json/OrderFeedbackDetails',2)
        WITH
        (
		    [OrderId] bigint
           ,[ItemFeedbackName] bigint
           ,[feedbackId] bigint
           ,[Comment] nvarchar(500)
           ,[Quantity] bigint
		   ,[ParentOrderFeedbackReplyId] bigint
           ,[CreatedBy] bigint
        )tmp


   DECLARE @OrderFeedback bigint
     SET @OrderFeedback = @@IDENTITY


   
  SELECT @OrderFeedback as OrderFeedback FOR XML RAW('Json'),ELEMENTS
    
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
