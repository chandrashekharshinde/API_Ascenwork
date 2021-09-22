Create PROCEDURE [dbo].[USP_UpdateOrderProductLotDetailForGRNProcess]-- '<Json><Order><OrderId>467</OrderId><SalesOrderNumber>8914</SalesOrderNumber><OrderNumber>8914</OrderNumber><PurchaseOrderNumber>134702</PurchaseOrderNumber><OrderType>SI</OrderType><OrderDate>2018-08-06T13:34:31.073</OrderDate><SourceReferenceNumber>SIOI2628</SourceReferenceNumber><BranchPlantCode>1804T</BranchPlantCode><ParentCompanyCode>00018</ParentCompanyCode><BranchPlantAddressNumber>90018</BranchPlantAddressNumber><ToBranchPlantCode>7403</ToBranchPlantCode><SoldToCode>90074</SoldToCode><ShipToCode>90074</ShipToCode><ToCompanyCode>00074</ToCompanyCode><IsCompleted>0</IsCompleted><OrderProductList><OrderId>467</OrderId><OrderProductId>1012</OrderProductId><ProductCode>00270</ProductCode><ItemShortCode>1002805</ItemShortCode><SequenceNo>1100</SequenceNo><LotNumber>20180413001</LotNumber><ProductQuantity>7.00</ProductQuantity><CollectedQuantity>0.00</CollectedQuantity><OrderProductLotDetailsId>25286</OrderProductLotDetailsId></OrderProductList><OrderProductList><OrderId>467</OrderId><OrderProductId>1013</OrderProductId><ProductCode>00231</ProductCode><ItemShortCode>1003008</ItemShortCode><SequenceNo>2100</SequenceNo><LotNumber>20180416001</LotNumber><ProductQuantity>8.00</ProductQuantity><CollectedQuantity>0.00</CollectedQuantity><OrderProductLotDetailsId>25287</OrderProductLotDetailsId></OrderProductList></Order></Json>'
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


   select * into #tmpOrderProductList
    FROM OPENXML(@intpointer,'Json/OrderProductList/OrderProductLotDetailList',2)
        WITH
        (
		[OrderProductId] bigint
		
        )tmp
		 
		--select * from #tmpOrder
		
		
		
		update OrderProduct  set isGRN  =1  where OrderProductId in (  select OrderProductId From  #tmpOrderProductList )


         select 1  as Success FOR XML RAW('Json'),ELEMENTS
    
   
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
