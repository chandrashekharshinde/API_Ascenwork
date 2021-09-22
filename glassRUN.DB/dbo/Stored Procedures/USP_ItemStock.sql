CREATE  PROCEDURE [dbo].[USP_ItemStock] --'<Json> <ItemStockList> <ItemCode>65801001</ItemCode> <DeliveryLocationCode>6410</DeliveryLocationCode> <ItemQuantity>100</ItemQuantity> </ItemStockList> <ItemStockList> <ItemCode>65801001</ItemCode> <DeliveryLocationCode>6441</DeliveryLocationCode> <ItemQuantity>600</ItemQuantity> </ItemStockList> <ItemStockList> <ItemCode>65305011</ItemCode> <DeliveryLocationCode>6441</DeliveryLocationCode> <ItemQuantity>300</ItemQuantity> </ItemStockList> </Json>'

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

         


			SELECT * INTO #tmpItemStock
			FROM OPENXML(@intpointer,'Json/ItemStockList',2)
			 WITH
             (
		
			ItemCode nvarchar(200),			        
			DeliveryLocationCode nvarchar(200),
			ItemQuantity float,
			LocationCode nvarchar(200)
			 ) tmp

			 

			 select * from  #tmpItemStock

PRINT N'Insert ItemStock'

		INSERT INTO [dbo].[ItemStock]
           ([ItemCode]
           ,[DeliveryLocationCode]
           ,[ItemQuantity]
		   ,[LocationCode])
    SELECT

			 #tmpItemStock.ItemCode
			 , #tmpItemStock.DeliveryLocationCode
			 ,#tmpItemStock.ItemQuantity
			 ,#tmpItemStock.LocationCode
     FROM #tmpItemStock

	  LEFT JOIN dbo.ItemStock ISs ON 
	        #tmpItemStock.[ItemCode]=ISs.ItemCode
	  	AND  #tmpItemStock.[DeliveryLocationCode]	 =ISs.DeliveryLocationCode
			AND  #tmpItemStock.[LocationCode]	 =ISs.LocationCode
	  	  WHERE ISs.ItemStockId IS null


PRINT N'Update ItemStock'


UPDATE  dbo.ItemStock

SET ItemQuantity =#tmpItemStock.[ItemQuantity]

FROM #tmpItemStock  LEFT JOIN dbo.ItemStock ISs ON 
	        #tmpItemStock.[ItemCode]=ISs.ItemCode
	  	AND  #tmpItemStock.[DeliveryLocationCode]	 =ISs.DeliveryLocationCode
			AND  #tmpItemStock.[LocationCode]	 =ISs.LocationCode
	  	  WHERE ISs.ItemStockId IS not  null


		


			
        	
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
