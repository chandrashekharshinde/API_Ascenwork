Create PROCEDURE [dbo].[ISP_ItemSoldToMapping] --'<Json><ServicesAction>InsertItemSoldToMapping</ServicesAction><ItemList><ItemId>242</ItemId><ItemName></ItemName><ItemCode></ItemCode><Amount></Amount><PrimaryUnitOfMeasure></PrimaryUnitOfMeasure><UOM></UOM><ProductType>9</ProductType><StockInQuantity>1500</StockInQuantity><CreatedBy>467</CreatedBy><NewAddedItem>1</NewAddedItem><CompanyList><CompanyId>1483</CompanyId><CompanyName>Customer 1</CompanyName><CompanyMnemonic>228690</CompanyMnemonic><CompanyNameAndMnemonic>Customer 1 (228690)</CompanyNameAndMnemonic><CompanyType>22</CompanyType><AddressLine1>Surrey, BC CanadaV4N4E6</AddressLine1><AddressLine2 /><AddressLine3 /><City /><State>43</State><CountryId>0</CountryId><Region>1272</Region><CategoryCode /><TaxId /><SiteURL>www.e.com</SiteURL><logo /><CreatedBy>467</CreatedBy><CreatedDate>2019-03-04T10:08:44.62</CreatedDate><ModifiedBy>409</ModifiedBy><ModifiedDate>2019-04-03T11:14:26.32</ModifiedDate><IsActive>1</IsActive><Field1>H</Field1><Field2 /><Field3 /><Field4 /><Field5 /><Field6 /><Field7 /><Field8 /><Field9 /><ItemSoldToMappingId>0</ItemSoldToMappingId><Field10 /><IsActiveForItem>0</IsActiveForItem><IsSelected>false</IsSelected><SoldTo>228690</SoldTo></CompanyList></ItemList></Json>'
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

			Declare @itemid nvarchar(50)
			
		
		Select * INTO #tmpItem 
		FROM OPENXML(@intpointer,'Json/ItemList',2)
        WITH
        (
            [ItemId] nvarchar(500)                  
           
        )tmp


		SET @itemId=(Select [ItemId] from #tmpItem)
		
		
		

		INSERT INTO	ItemSoldToMapping
        (
        	ItemId,
			SoldTo,
			ShipTo,			
			IsActive,
			CreatedBy,
			CreatedDate
        	
        )

        SELECT
        	@itemId,
        	tmp.[SoldTo],
        	0,
        	1,
			tmp.CreatedBy,
			GETDATE()
        
            FROM OPENXML(@intpointer,'Json/ItemList/CompanyList',2)
        WITH
        (
            [ItemId] nvarchar(500),
            [SoldTo] nvarchar(50),			
			ShipTo bigint,
            IsActive bit,
            CreatedBy bigint,
			CreatedDate datetime
         
        )tmp

		 DECLARE @ItemSoldToMapping bigint
	    SET @ItemSoldToMapping = @@IDENTITY


		SELECT @itemId as ItemId FOR XML RAW('Json'),ELEMENTS

  


     
   
    
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
