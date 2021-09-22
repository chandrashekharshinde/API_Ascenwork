
CREATE PROCEDURE [dbo].[ISP_ItemFromSubDApp] 
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

			
        INSERT INTO	[Item]
        (
        	[ItemName],
        	[ItemCode],
        	[PrimaryUnitOfMeasure],
        	[StockInQuantity],
        	[ImageUrl],
			[ProductType],
        	[CreatedBy],
        	[CreatedDate],        	
        	[IsActive],
			[ItemOwner]
        	--[Field10]
        )

        SELECT
        	tmp.[ProductName],
        	tmp.[ProductCode],
        	tmp.[UOM],
        	tmp.[OpeningBalanceQuantity],
        	CASE WHEN tmp.[ImageUrl] = '' THEN NULL ELSE tmp.[ImageUrl] END,
			9,
        	tmp.[CreatedBy],
        	GETDATE(),        	
        	1,
			tmp.[ItemOwner]
        	--tmp.[Price]
            FROM OPENXML(@intpointer,'Json/ItemList',2)
        WITH
        (
            [ProductName] nvarchar(500),
            [ProductCode] nvarchar(200),
            [UOM] nvarchar(20),
            [OpeningBalanceQuantity] decimal(10, 2),
            [ImageUrl] nvarchar(max),
            [CreatedBy] bigint,
			[ItemOwner] bigint,
            [Price] nvarchar(500)
        )tmp
        
        DECLARE @Item bigint
	    SET @Item = @@IDENTITY

		select * into #ItemList
		FROM OPENXML(@intpointer,'Json/ItemList',2)
		WITH
		(
			[ProductName] nvarchar(500),
			[ProductCode] nvarchar(200),
			[UOM] nvarchar(20),
			[OpeningBalanceQuantity] decimal(10, 2),
			[ImageUrl] nvarchar(max),
			[CreatedBy] bigint,
			[ItemOwner] bigint,
			[Price] nvarchar(500)
		)tmp1

		INSERT INTO [dbo].[ItemBasePrice]
           ([ItemShortCode]
           ,[ItemLongCode]
           ,[AddressNumber]
           ,[CurrencyCode]
           ,[UOM]
           ,[EffectiveDate]
           ,[ExpiryDate]
           ,[Price]
           ,[CustomerGroupID]
           ,[ItemGroupId])
     VALUES
           (0
           ,(select top 1 #ItemList.[ProductCode] from #ItemList)
           ,0
           ,'VND'
           ,'CR'
           ,[dbo].[DMYTOJUL] (getdate())
           ,[dbo].[DMYTOJUL] (DATEADD(year, 20, getdate()))
           ,(select top 1 #ItemList.[Price] from #ItemList)
           ,0
           ,0)

		   drop table #ItemList

        
        --Add child table insert procedure when required.
     --SELECT @Item as ItemId FOR XML RAW('Json'),ELEMENTS
	 SELECT @Item AS ItemId 
          FOR xml raw('Json'), elements 
   
    
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
