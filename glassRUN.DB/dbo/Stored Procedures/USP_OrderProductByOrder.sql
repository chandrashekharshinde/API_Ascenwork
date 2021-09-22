CREATE PROCEDURE [dbo].[USP_OrderProductByOrder] --'<Json><UpdatedBy>8</UpdatedBy><OrderProductList><ProductQuantity>10</ProductQuantity><IsActive>1</IsActive><ProductCode>55909001</ProductCode><ProductType>9</ProductType><UnitPrice>0.0000</UnitPrice><ItemType>0</ItemType><CreatedBy>8</CreatedBy><UpdatedBy>8</UpdatedBy><Remarks></Remarks><SequenceNo>0</SequenceNo><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.00</DepositeAmount></OrderProductList><OrderProductList><ProductQuantity>1000</ProductQuantity><IsActive>1</IsActive><ProductCode>65205121</ProductCode><ProductType>9</ProductType><UnitPrice>230000.0000</UnitPrice><ItemType>32</ItemType><CreatedBy>8</CreatedBy><UpdatedBy>8</UpdatedBy><Remarks></Remarks><SequenceNo>0</SequenceNo><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.00</DepositeAmount></OrderProductList><OrderProductList><EnquiryProductId>0</EnquiryProductId><ProductQuantity>300</ProductQuantity><IsActive>1</IsActive><EnquiryId>76633</EnquiryId><ProductCode>65205131</ProductCode><ProductType>9</ProductType><UnitPrice>0</UnitPrice><ItemType>32</ItemType><CreatedBy>8</CreatedBy><UpdatedBy>8</UpdatedBy><Remarks></Remarks><SequenceNo>0</SequenceNo><AssociatedOrder>0</AssociatedOrder><DepositeAmount>0.00</DepositeAmount></OrderProductList></Json>'

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

            DECLARE @OrderId bigint

            UPDATE dbo.[Order] SET
			@OrderId=tmp.OrderId,     	      	
        	[ModifiedBy]=1 ,
        	[ModifiedDate]=GETDATE()
        	
            FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[OrderId] bigint,                 
			[UpdatedBy] bigint
            )tmp WHERE [Order].[OrderId]=tmp.[OrderId]




			SELECT * INTO #tmpOrderProduct
			FROM OPENXML(@intpointer,'Json/OrderProductList',2)
			 WITH
             (
			OrderProductId BIGINT,
			[ProductCode] nvarchar(200),			        
			[ProductType] nvarchar(200),
			[ProductQuantity] decimal(10, 2),
			[Remarks] nvarchar,
            [DepositeAmountPerUnit] decimal(10,2),
			[ItemPricesPerUnit] decimal(10, 2),
			[ItemType] bigint,
            [IsActive] bit,
			[ReasonCodeId] bigint,
            [SequenceNo] bigint,
			[AssociatedOrder] nvarchar(100),
            [Field1] nvarchar(500),
            [Field2] nvarchar(500),
            [Field3] nvarchar(500),
            [Field4] nvarchar(500),
            [Field5] nvarchar(500),
            [Field6] nvarchar(500),
            [Field7] nvarchar(500),
            [Field8] nvarchar(500),
            [Field9] nvarchar(500),
            [Field10] nvarchar(500)
			 ) tmp

			 select * from #tmpOrderProduct

			 --select op.* from #tmpEnquiryProduct tmpop join OrderProduct op
			 -- on tmpop.EnquiryProductId=op.EnquiryProductId and tmpop.[ProductQuantity] <> op.[ProductQuantity]  
			 --where tmpop.EnquiryProductId <>0 and tmpop.IsActive=1





			 UPDATE dbo.OrderProduct SET IsActive=0 WHERE OrderId=@orderId

			UPDATE dbo.OrderProduct
			SET dbo.OrderProduct.[ProductQuantity]=#tmpOrderProduct.[ProductQuantity],dbo.OrderProduct.IsActive=#tmpOrderProduct.IsActive,dbo.OrderProduct.ModifiedDate=GETDATE(),dbo.OrderProduct.ModifiedBy = 1 
			FROM #tmpOrderProduct WHERE dbo.OrderProduct.OrderProductId=#tmpOrderProduct.OrderProductId






			

			INSERT INTO	[OrderProduct] 
			([OrderId],[ProductCode],[ProductType],[ProductQuantity],[CreatedBy],[CreatedDate],[IsActive],[Remarks],       	
        	
			[AssociatedOrder],
			[DepositeAmount],
			UnitPrice,
			ItemType,
        	[Field1],
        	[Field2],
        	[Field3],
        	[Field4],
        	[Field5],
        	[Field6],
        	[Field7],
        	[Field8],
        	[Field9],
        	[Field10])

          SELECT
        	@orderId,
        	#tmpOrderProduct.[ProductCode],
        	#tmpOrderProduct.[ProductType],
        	#tmpOrderProduct.[ProductQuantity],
        	1,
        	GETDATE(),        	
        	1 ,
			#tmpOrderProduct.[Remarks],
        	
			#tmpOrderProduct.[AssociatedOrder],
			#tmpOrderProduct.[DepositeAmountPerUnit],
			#tmpOrderProduct.[ItemPricesPerUnit],
			#tmpOrderProduct.[ItemType],
        	#tmpOrderProduct.[Field1],
        	#tmpOrderProduct.[Field2],
        	#tmpOrderProduct.[Field3],
        	#tmpOrderProduct.[Field4],
        	#tmpOrderProduct.[Field5],
        	#tmpOrderProduct.[Field6],
        	#tmpOrderProduct.[Field7],
        	#tmpOrderProduct.[Field8],
        	#tmpOrderProduct.[Field9],
        	#tmpOrderProduct.[Field10]
			
			FROM #tmpOrderProduct WHERE #tmpOrderProduct.OrderProductId = 0
        	

		declare @OrderList nvarchar(max)
		set @OrderList='<Json><ServicesAction>SaveEmailContent</ServicesAction><OrderList><OrderId>'+convert(nvarchar(max),@OrderId)+'</OrderId></OrderList></Json>'
		exec [dbo].[USP_OrderProductMovementByOrderId] @OrderList


           SELECT @OrderId as EnquiryId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_Enquiry'