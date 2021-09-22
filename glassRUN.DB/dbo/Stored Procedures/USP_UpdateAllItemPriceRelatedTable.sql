CREATE  PROCEDURE [dbo].[USP_UpdateAllItemPriceRelatedTable] --''

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

         
----create tmp table for  #tmpItemMasterForPricing
		 SELECT * INTO #tmpItemMasterForPricing
			FROM OPENXML(@intpointer,'Json/ItemMasterForPricingList',2)
			 WITH
             (
		
			ItemShortCode numeric(18,0),			        
			ItemLongCode varchar(25),
				ItemDescription varchar(30),
					ItemPriceGroup varchar(8)
			
			 ) tmp
--------create tmp table for  #tmpItemMasterForPricing
SELECT * INTO #tmpAddressBookMasterForPricing
			FROM OPENXML(@intpointer,'Json/AddressBookMasterForPricingList',2)
			 WITH
             (
		
			CustomerNumber numeric(8,0),			        
			CustomerName varchar(40)
			
			 ) tmp 	

---- create tmp table for  #tmpCustomerMasterForPricing

	SELECT * INTO #tmpCustomerMasterForPricing
			FROM OPENXML(@intpointer,'Json/CustomerMasterForPricingList',2)
			 WITH
             (
		
			CustomerNumber numeric(8,0),			        
			CustomerPriceGroup varchar(8)
			
			 ) tmp
---create tmp table for  ##tmpItemBasePrice

SELECT * INTO #tmpItemBasePrice
			FROM OPENXML(@intpointer,'Json/ItemBasePriceList',2)
			 WITH
             (
		
			ItemShortCode numeric(8,0),			        
			ItemLongCode varchar(25),
			AddressNumber numeric(8,0),
			CurrencyCode varchar(3),
			UOM	 varchar(2),
			EffectiveDate	 int,
			ExpiryDate	 int,
			Price	 numeric(18,4),	
			CustomerGroupID	numeric(8,0),	
			ItemGroupId	numeric(8,0)	
			 ) tmp


------create tmp table for  ###tmpCustomerGroupForPricing
SELECT * INTO #tmpCustomerGroupForPricing
			FROM OPENXML(@intpointer,'Json/CustomerGroupForPricingList',2)
			 WITH
             (
		
			CustomerGroupID numeric(8,0),			        
			CustomerPriceGroup varchar(8)
			 ) tmp
------create #tmpItemGroupForPricing

	SELECT * INTO #tmpItemGroupForPricing
			FROM OPENXML(@intpointer,'Json/ItemGroupForPricingList',2)
			 WITH
             (
		
			ItemPriceGroupID numeric(8,0),			        
			ItemPriceGroup varchar(8)
			 ) tmp

---- select all table


		 SELECT * from #tmpItemMasterForPricing
			
SELECT * from  #tmpAddressBookMasterForPricing

	SELECT * from #tmpCustomerMasterForPricing
			

SELECT * From #tmpItemBasePrice
		
SELECT * From #tmpCustomerGroupForPricing
			
	SELECT * from #tmpItemGroupForPricing
			
	----------------- delete 
	delete from ItemMasterForPricing
			
delete from AddressBookMasterForPricing

	delete from CustomerMasterForPricing
			

delete from ItemBasePrice
		
delete from CustomerGroupForPricing
			
	delete from ItemGroupForPricing		
			-------------------------delete------

			
----------------------insert  table----

pRINT N'Insert PriceListDetails'

		INSERT INTO [dbo].[ItemMasterForPricing]
           (ItemShortCode
           ,ItemLongCode
           ,ItemDescription
		   ,ItemPriceGroup
		  )
    SELECT

			#tmpItemMasterForPricing.[ItemShortCode]
			 , #tmpItemMasterForPricing.[ItemLongCode]
			 ,#tmpItemMasterForPricing.[ItemDescription]
			 ,#tmpItemMasterForPricing.[ItemPriceGroup]
			
     FROM #tmpItemMasterForPricing



	 PRINT N'Insert AddressBookMasterForPricing'

		INSERT INTO [dbo].[AddressBookMasterForPricing]
           (CustomerNumber
           ,CustomerName
           
		  )
    SELECT

			#tmpAddressBookMasterForPricing.[CustomerNumber]
			 , #tmpAddressBookMasterForPricing.[CustomerName]
			
     FROM #tmpAddressBookMasterForPricing


	 
PRINT N'Insert CustomerMasterForPricing'

		INSERT INTO [dbo].[CustomerMasterForPricing]
           (CustomerNumber
           ,CustomerPriceGroup
           
		  )
    SELECT

			#tmpCustomerMasterForPricing.[CustomerNumber]
			 , #tmpCustomerMasterForPricing.[CustomerPriceGroup]
			
     FROM #tmpCustomerMasterForPricing




	 

PRINT N'Insert ItemBasePrice'

		INSERT INTO [dbo].[ItemBasePrice]
           (ItemShortCode
			,ItemLongCode
			 ,AddressNumber
			,CurrencyCode
			,UOM
			,EffectiveDate
			 ,ExpiryDate
			,Price
            ,CustomerGroupID
			 ,ItemGroupId
		  )
    SELECT

			#tmpItemBasePrice.[ItemShortCode]
			 , #tmpItemBasePrice.[ItemLongCode]
			  , #tmpItemBasePrice.[AddressNumber]
			   , #tmpItemBasePrice.[CurrencyCode]
			    , #tmpItemBasePrice.[UOM]
				, #tmpItemBasePrice.[EffectiveDate]
				 , #tmpItemBasePrice.[ExpiryDate]
				  , #tmpItemBasePrice.[Price]
				   , #tmpItemBasePrice.[CustomerGroupID]
			   , #tmpItemBasePrice.[ItemGroupId]
     FROM #tmpItemBasePrice



	 
PRINT N'Insert CustomerGroupForPricing'

		INSERT INTO [dbo].[CustomerGroupForPricing]
           (CustomerGroupID
			,CustomerPriceGroup
			 
		  )
    SELECT

			#tmpCustomerGroupForPricing.[CustomerGroupID]
			 , #tmpCustomerGroupForPricing.[CustomerPriceGroup]
			 
     FROM #tmpCustomerGroupForPricing
	   


	   
PRINT N'Insert ItemGroupForPricing'

		INSERT INTO [dbo].[ItemGroupForPricing]
           (ItemPriceGroupID
			,ItemPriceGroup
			 
		  )
    SELECT

			#tmpItemGroupForPricing.[ItemPriceGroupID]
			 , #tmpItemGroupForPricing.[ItemPriceGroup]
			 
     FROM #tmpItemGroupForPricing
	   

	 ----drop 

	 	drop table  #tmpItemMasterForPricing

		drop table  #tmpAddressBookMasterForPricing

			drop table  #tmpCustomerMasterForPricing
				drop table  #tmpItemBasePrice
					drop table  #tmpCustomerGroupForPricing
        		drop table  #tmpItemGroupForPricing
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
