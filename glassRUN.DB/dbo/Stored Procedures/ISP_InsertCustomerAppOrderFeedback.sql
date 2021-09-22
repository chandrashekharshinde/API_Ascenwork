CREATE PROCEDURE [dbo].[ISP_InsertCustomerAppOrderFeedback] 
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

 
		 SELECT * INTO #tmpSurveyDetails
            FROM OPENXML(@intpointer,'Json/SurveyDetails',2)
        WITH
        (
		[OrderId] bigint,
		[Survey] bigint,
		[CustomerSignature] nvarchar(max),
		[Comments] nvarchar(max) ,
		[IsActive] bit,
		[CreatedDate] datetime,
		[CreatedBy] bigint
        )tmp


		INSERT INTO [dbo].[SurveyForm]
           ([OrderId]
           ,[Survey]
           ,[Comments]
           ,[IsActive]
           ,[CreatedDate]
           ,[CreatedBy])
		   Select 
		   tmp.[OrderId]
		  ,tmp.[Survey]
		  ,tmp.[Comments]
		  ,1
		  ,GETDATE()
		  ,tmp.[CreatedBy]
		  From #tmpSurveyDetails tmp

		  
   DECLARE @OrderFeedback bigint
     SET @OrderFeedback = @@IDENTITY



		  INSERT INTO [dbo].[OrderDocument]
           ([OrderId]
           ,[OrderProductId]
           ,[DocumentTypeId]
           ,[DocumentFormat]
           ,[DocumentBlob]
           ,[CreatedDate])
		      Select 
		   tmp.[OrderId]
		  ,0
		  ,303
		  ,'jpeg'
		  ,tmp.[CustomerSignature]
		  ,GETDATE()
		  From #tmpSurveyDetails tmp
		  
	
	Update [Order] set CurrentState=103 where OrderId in (Select [OrderId] From #tmpSurveyDetails)



   
  SELECT @OrderFeedback as OrderFeedback FOR XML RAW('Json'),ELEMENTS
    
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
