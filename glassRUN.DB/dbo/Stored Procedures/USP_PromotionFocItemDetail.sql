CREATE  PROCEDURE [dbo].[USP_PromotionFocItemDetail]-- '<Json> <PromotionFocItemDetailList> <ItemCode>65601001</ItemCode><ItemQuanity>5</ItemQuanity> <FocItemCode>65601001</FocItemCode><FocItemQuantity>1</FocItemQuantity><FromDate>107032</FromDate><ToDate>107135</ToDate> </PromotionFocItemDetailList>'

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

         


			SELECT * INTO #tmpPromotionFocItemDetail
			FROM OPENXML(@intpointer,'Json/PromotionFocItemDetailList',2)
			 WITH
             (
		
			ItemCode nvarchar(200),			        
			ItemQuanity float,
			FocItemCode nvarchar(200),	
			FocItemQuantity bigint,		
			Region nvarchar(200),		
			FromDate nvarchar(200),	
			ToDate nvarchar(200)		
			 ) tmp

			 

			 select * from  #tmpPromotionFocItemDetail

delete from [dbo].[PromotionFocItemDetail]

PRINT N'Insert PromotionFocItemDetail'

		INSERT INTO [dbo].[PromotionFocItemDetail]
           ([ItemCode]
            ,[ItemQuanity]
			 ,[FocItemCode]
			  ,[FocItemQuantity]
			   ,[Region]
			    ,[FromDate]
			 ,[ToDate]
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				 )
    SELECT

			 #tmpPromotionFocItemDetail.ItemCode
			,#tmpPromotionFocItemDetail.ItemQuanity
			,#tmpPromotionFocItemDetail.FocItemCode
			,#tmpPromotionFocItemDetail.FocItemQuantity
			,#tmpPromotionFocItemDetail.Region
			,  [dbo].[JULTODMY](#tmpPromotionFocItemDetail.FromDate)   
			,[dbo].[JULTODMY](#tmpPromotionFocItemDetail.ToDate) 
			,1
			,1
			,GETDATE()

     FROM #tmpPromotionFocItemDetail

	  LEFT JOIN dbo.PromotionFocItemDetail PFID ON 
	        #tmpPromotionFocItemDetail.[ItemCode]=PFID.ItemCode
	  	AND  #tmpPromotionFocItemDetail.[FocItemCode]	 =PFID.FocItemCode
			--AND  #tmpPromotionFocItemDetail.[FromDate]	 =PFID.FromDate
			--	AND  #tmpPromotionFocItemDetail.[ToDate]	 =PFID.ToDate

	  	  WHERE PFID.PromotionFocItemDetailId IS null


PRINT N'Update PromotionFocItemDetail'


--UPDATE  dbo.PromotionFocItemDetail

--SET ItemQuanity =#tmpPromotionFocItemDetail.[ItemQuantity],
--FocItemQuantity =#tmpPromotionFocItemDetail.[FocItemQuantity]

--FROM #tmpPromotionFocItemDetail  LEFT JOIN dbo.PromotionFocItemDetail PFID ON 
	--         #tmpPromotionFocItemDetail.[ItemCode]=PFID.ItemCode
	 -- 	ANfD  #tmpPromotionFocItemDetail.[FocItemCode]	 =PFID.FocItemCode
			--AND  #tmpPromotionFocItemDetail.[FromDate]	 =PFID.FromDate
			--	AND  #tmpPromotionFocItemDetail.[ToDate]	 =PFID.ToDate
	  	--  WHERE ISs.PromotionFocItemDetailId IS not  null


		drop  table #tmpPromotionFocItemDetail


			
        	
           SELECT 1 as EnquiryId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_ItemStock'
