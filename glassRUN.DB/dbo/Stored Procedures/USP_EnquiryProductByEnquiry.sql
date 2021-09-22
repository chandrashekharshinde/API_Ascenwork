
CREATE PROCEDURE [dbo].[USP_EnquiryProductByEnquiry] --'<Json> <EnquiryId>27067</EnquiryId> <UpdatedBy>793</UpdatedBy> <TotalPrice>794460755</TotalPrice> <OrderProductList> <EnquiryProductId>33494</EnquiryProductId> <ProductQuantity>12</ProductQuantity> <IsActive>1</IsActive> <EnquiryId>27067</EnquiryId> <ProductCode>55909001</ProductCode> <ProductType>9</ProductType> <UnitPrice>0.0000</UnitPrice> <ItemType>0</ItemType> <CreatedBy>793</CreatedBy> <UpdatedBy>793</UpdatedBy> <Remarks></Remarks> <SequenceNo>0</SequenceNo> <AssociatedOrder>0</AssociatedOrder> <DepositeAmount>0.0000</DepositeAmount> </OrderProductList> <OrderProductList> <EnquiryProductId>33493</EnquiryProductId> <ProductQuantity>1400</ProductQuantity> <IsActive>1</IsActive> <EnquiryId>27067</EnquiryId> <ProductCode>65200500</ProductCode> <ProductType>9</ProductType> <UnitPrice>436364.0000</UnitPrice> <ItemType>32</ItemType> <CreatedBy>793</CreatedBy> <UpdatedBy>793</UpdatedBy> <Remarks></Remarks> <SequenceNo>0</SequenceNo> <AssociatedOrder>0</AssociatedOrder> <DepositeAmount>0.0000</DepositeAmount> </OrderProductList> <OrderProductList> <EnquiryProductId>0</EnquiryProductId> <ProductQuantity>390</ProductQuantity> <IsActive>1</IsActive> <EnquiryId>27067</EnquiryId> <ProductCode>65105011</ProductCode> <ProductType>9</ProductType> <UnitPrice>285455</UnitPrice> <ItemType>32</ItemType> <CreatedBy>793</CreatedBy> <UpdatedBy>793</UpdatedBy> <Remarks></Remarks> <SequenceNo>0</SequenceNo> <AssociatedOrder>0</AssociatedOrder> <DepositeAmount>0.00</DepositeAmount> </OrderProductList> </Json>'

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

            DECLARE @EnquiryId bigint

            UPDATE dbo.Enquiry SET
			@EnquiryId=tmp.EnquiryId, 
			[TotalPrice]=tmp.TotalPrice,    	      	
        	[ModifiedBy]=1 ,
        	[ModifiedDate]=GETDATE()
        	
            FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EnquiryId] bigint,                 
			[UpdatedBy] bigint,
			[TotalPrice] decimal(18,4)
            )tmp WHERE Enquiry.[EnquiryId]=tmp.[EnquiryId]




			SELECT * INTO #tmpEnquiryProduct
			FROM OPENXML(@intpointer,'Json/OrderProductList',2)
			 WITH
             (
			EnquiryProductId BIGINT,
			[ProductCode] nvarchar(200),			        
			[ProductType] nvarchar(200),
			[ProductQuantity] decimal(18, 4),
			[Remarks] nvarchar,
            [DepositeAmountPerUnit] decimal(18, 4),
			[ItemPricesPerUnit] decimal(18, 4),
			[UnitPrice] decimal(18, 4),
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



			 --select op.* from #tmpEnquiryProduct tmpop join OrderProduct op
			 -- on tmpop.EnquiryProductId=op.EnquiryProductId and tmpop.[ProductQuantity] <> op.[ProductQuantity]  
			 --where tmpop.EnquiryProductId <>0 and tmpop.IsActive=1


			



			 	INSERT INTO	[EnquiryProductHistory] 
			([EnquiryProductId],[EnquiryId],[ReasonCodeId],[ProductCode],[ProductType],[ProductQuantity],[CreatedBy],[CreatedDate],[IsActive],[Remarks],       	
        	[SequenceNo],[AssociatedOrder],[DepositeAmount],Price,ItemType,[Field1],
        	[Field2],[Field3],[Field4],	[Field5],[Field6],
        	[Field7],
        	[Field8],
        	[Field9],
        	[Field10])

          SELECT
        	 ep.EnquiryProductId,ep.[EnquiryId],tmpop.ReasonCodeId,ep.[ProductCode],ep.[ProductType],ep.[ProductQuantity],ep.[CreatedBy]
			,GETDATE(),ep.[IsActive],ep.Remarks,ep.SequenceNo,ep.AssociatedOrder,ep.DepositeAmount,ep.UnitPrice,ep.ItemType,ep.Field1
			,ep.Field2,ep.Field3,ep.Field4,ep.Field5,ep.Field6,ep.Field7,ep.Field8,ep.Field9,ep.Field10
			 from #tmpEnquiryProduct tmpop join EnquiryProduct ep
			  on tmpop.EnquiryProductId=ep.EnquiryProductId and tmpop.[ProductQuantity] <> ep.[ProductQuantity]  
			 where tmpop.EnquiryProductId <>0 and tmpop.IsActive=1 


			 

			UPDATE dbo.EnquiryProduct SET IsActive=0 WHERE EnquiryId=@EnquiryId

			UPDATE dbo.EnquiryProduct
			SET dbo.EnquiryProduct.[ProductQuantity]=#tmpEnquiryProduct.[ProductQuantity],
			dbo.EnquiryProduct.UnitPrice=#tmpEnquiryProduct.[UnitPrice],dbo.EnquiryProduct.IsActive=#tmpEnquiryProduct.IsActive,dbo.EnquiryProduct.ModifiedDate=GETDATE(),dbo.EnquiryProduct.ModifiedBy = 1 
			FROM #tmpEnquiryProduct WHERE dbo.EnquiryProduct.EnquiryProductId=#tmpEnquiryProduct.EnquiryProductId


			INSERT INTO	[EnquiryProduct] 
			([EnquiryId],[ProductCode],[ProductType],[ProductQuantity],[CreatedBy],[CreatedDate],[IsActive],[Remarks],       	
        	[SequenceNo],
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
        	@EnquiryId,
        	#tmpEnquiryProduct.[ProductCode],
        	#tmpEnquiryProduct.[ProductType],
        	#tmpEnquiryProduct.[ProductQuantity],
        	1,
        	GETDATE(),        	
        	1 ,
			#tmpEnquiryProduct.[Remarks],
        	#tmpEnquiryProduct.[SequenceNo],
			#tmpEnquiryProduct.[AssociatedOrder],
			#tmpEnquiryProduct.[DepositeAmountPerUnit],
			#tmpEnquiryProduct.[UnitPrice],
			#tmpEnquiryProduct.[ItemType],
        	#tmpEnquiryProduct.[Field1],
        	#tmpEnquiryProduct.[Field2],
        	#tmpEnquiryProduct.[Field3],
        	#tmpEnquiryProduct.[Field4],
        	#tmpEnquiryProduct.[Field5],
        	#tmpEnquiryProduct.[Field6],
        	#tmpEnquiryProduct.[Field7],
        	#tmpEnquiryProduct.[Field8],
        	#tmpEnquiryProduct.[Field9],
        	#tmpEnquiryProduct.[Field10]
			
			FROM #tmpEnquiryProduct WHERE #tmpEnquiryProduct.EnquiryProductId = 0
        	
           SELECT @EnquiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_Enquiry'
