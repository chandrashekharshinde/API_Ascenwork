CREATE PROCEDURE [dbo].[USP_ItemSoldToMapping] --'<Json><ServicesAction>InsertItemSoldToMapping</ServicesAction><ItemList><ItemId>68</ItemId><ItemName></ItemName><ItemCode></ItemCode><Amount></Amount><PrimaryUnitOfMeasure></PrimaryUnitOfMeasure><UOM></UOM><ProductType>9</ProductType><StockInQuantity>1500</StockInQuantity><CreatedBy>507</CreatedBy><NewAddedItem>0</NewAddedItem><CompanyList><CompanyId>256</CompanyId><CompanyName>D11 - CTY TNHH NGOC YEN</CompanyName><CompanyMnemonic>11000006</CompanyMnemonic><CompanyNameAndMnemonic>D11 - CTY TNHH NGOC YEN (11000006)</CompanyNameAndMnemonic><CompanyType>22</CompanyType><CountryId>0</CountryId><TaxId>400555038</TaxId><CreatedBy>507</CreatedBy><CreatedDate>2019-05-16T00:00:00</CreatedDate><IsActive>1</IsActive><Field1>SCO</Field1><Field8 /><Field9>0</Field9><ItemSoldToMappingId>0</ItemSoldToMappingId><IsActiveForItem>0</IsActiveForItem><IsSelected>false</IsSelected><SoldTo>11000006</SoldTo></CompanyList><CompanyList><CompanyId>257</CompanyId><CompanyName>QN3 - TRAN THI BICH CHI</CompanyName><CompanyMnemonic>11000016</CompanyMnemonic><CompanyNameAndMnemonic>QN3 - TRAN THI BICH CHI (11000016)</CompanyNameAndMnemonic><CompanyType>22</CompanyType><CountryId>0</CountryId><TaxId>4000121107</TaxId><CreatedBy>507</CreatedBy><CreatedDate>2019-05-16T00:00:00</CreatedDate><IsActive>1</IsActive><Field1 /><Field8 /><Field9>0</Field9><ItemSoldToMappingId>12</ItemSoldToMappingId><IsActiveForItem>0</IsActiveForItem><SoldTo>11000016</SoldTo></CompanyList></ItemList></Json>'

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
            DECLARE @ItemId bigint
			Declare @itemCode nvarchar(100)
			Declare @itemShortCode nvarchar(100)

			select * into #tmpItemList
    FROM OPENXML(@intpointer,'Json/ItemList',2)
        WITH
        (
		
		[ItemId] bigint
		
        )tmp
			 
			 SET @ItemId = (Select top 1 ItemId from #tmpItemList)
	select * into #tmpCompanyList
    FROM OPENXML(@intpointer,'Json/ItemList/CompanyList',2)
        WITH
        (
		[ItemSoldToMappingId] bigint,
		[ItemId] bigint,
		[SoldTo] nvarchar(50),
        [CreatedBy] bigint
        )tmp

	update ItemSoldToMapping set IsActive = 0 where ItemId = @ItemId

	--update ItemSoldToMapping set IsActive = 1 from #tmpCompanyList where ItemSoldToMapping.ItemId = @ItemId and ItemSoldToMapping.SoldTo = #tmpCompanyList.[SoldTo]
	update ItemSoldToMapping set IsActive = 1 from #tmpCompanyList where ItemSoldToMapping.ItemSoldToMappingId=  #tmpCompanyList.ItemSoldToMappingId

	
		INSERT INTO	ItemSoldToMapping
        (
        	ItemId,
			SoldTo,
			ShipTo,			
			IsActive,
			CreatedBy,
			CreatedDate
        	
        )
     SELECT  	@ItemId, 
	        	#tmpCompanyList.[SoldTo], 	
		        0,
            	1,
		    	#tmpCompanyList.CreatedBy,
		     	GETDATE()
                FROM #tmpCompanyList
                WHERE #tmpCompanyList.ItemSoldToMappingId=0
	
			


             SELECT @ItemId as ItemId FOR XML RAW('Json'),ELEMENTS
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
