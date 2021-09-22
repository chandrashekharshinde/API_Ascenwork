






CREATE  PROCEDURE [dbo].[USP_ItemInsertAndUpdateFromJDE] --''

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

			SELECT * INTO #tmpItem
			FROM OPENXML(@intpointer,'Json/ItemList',2)
			 WITH
             (
		
			ItemName nvarchar(500),
			ItemCode  nvarchar(200),			        
			ItemShortCode nvarchar(200),
			PrimaryUOM bigint ,
			PricingUOM bigint,
			ShippingUOM  bigint,			        
			ComponentUOM bigint,
			ItemClass nvarchar(500),
			ShelfLife  nvarchar(200),			        
			BBD nvarchar(200),
			Barcode nvarchar(500),
			ItemOwner  nvarchar(200),	        
			JDEUpdatedDate  nvarchar(200),
			ItemType   nvarchar(250)

			 ) tmp

			 

			 --select * from  #tmpItem

PRINT N'Insert Item'

		INSERT INTO [dbo].[Item]
           ([ItemName]
		     ,[ItemCode]
           ,[ItemShortCode]
		   ,[PrimaryUnitOfMeasure]
		   ,[ProductType]
		   ,[StockInQuantity]
		   ,[PricingUnit]
		   ,[ShippingUnit]
		   ,[ComponentUnit]
		   ,[ItemClass]
		   ,[ShelfLife]
		   ,BBD
		   ,Barcode
		   ,ItemOwner
		   ,IsActive
		   ,CreatedBy
		   ,CreatedDate
		  ,ItemType

          )
    SELECT
			 #tmpItem.ItemName
			 , #tmpItem.ItemCode
			  , #tmpItem.ItemShortCode
			 , case when #tmpItem.ItemType ='pallet'  then 19 else #tmpItem.PrimaryUOM end
			 ,9
			 ,0
			 ,#tmpItem.PricingUOM
			 ,#tmpItem.ShippingUOM
			 ,#tmpItem.ComponentUOM
			 ,#tmpItem.ItemClass
			 ,#tmpItem.ShelfLife
			 ,#tmpItem.BBD
			 ,#tmpItem.Barcode
			 ,(Select top 1 LookUpId from LookUp where Name=#tmpItem.ItemOwner)
			 ,1
			 ,1
			 ,GETDATE()
			,#tmpItem.ItemType

     FROM #tmpItem 
	 left join Item   I  ON   #tmpItem.[ItemShortCode]=i.ItemShortCode
	 WHERE i.ItemId is null  --and   #tmpItem.ItemType != 0

	 
--UPDATE  dbo.Item set IsActive=0

PRINT N'Update Item'


UPDATE  dbo.Item

SET ItemName =#tmpItem.[ItemName],
ItemCode =#tmpItem.[ItemCode],
PrimaryUnitOfMeasure = case when #tmpItem.ItemType ='pallet'  then 19 else #tmpItem.PrimaryUOM end,
PricingUnit =#tmpItem.[PricingUOM],
ShippingUnit =#tmpItem.[ShippingUOM],
ComponentUnit =#tmpItem.[ComponentUOM],
ItemClass =#tmpItem.[ItemClass],
BBD =#tmpItem.[BBD],
Barcode =#tmpItem.[Barcode],
ItemType =#tmpItem.ItemType,
isactive=1
from  #tmpItem
 left join Item   I  ON  #tmpItem.[ItemShortCode]=i.ItemShortCode
		 WHERE i.ItemId is not  null 
		 --and #tmpItem.JDEUpdatedDate < (SELECT [dbo].[DMYTOJUL] (GETDATE()))



		


			
        	
           SELECT 1 as CompanyId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure Item'
