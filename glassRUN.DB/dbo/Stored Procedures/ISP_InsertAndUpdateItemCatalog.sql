
CREATE PROCEDURE [dbo].[ISP_InsertAndUpdateItemCatalog] --'<Rules><RuleId>0</RuleId><RuleType>2</RuleType><RuleName>''Allocation ==1111026 for  ( ''{Item.SKUCode}'' == ''65105011'')''</RuleName><RuleText>if ''{Company.CompanyMnemonic}'' ==''1111026'' &amp; ( ''{Item.SKUCode}'' == ''65105011'') Then {Rule.Result} = literal(''{780}'')</RuleText><SKUCode>65105011</SKUCode><CompanyType>1111026</CompanyType><Remarks>ItemAllocation</Remarks><ShipTo>0</ShipTo><SequenceNumber>0</SequenceNumber><FromDate>2019-07-01T00:00:00</FromDate><ToDate>2019-07-01T00:00:00</ToDate><CreatedBy>0</CreatedBy><CreatedDate>2019-07-01T18:06:47.3952565+05:30</CreatedDate><IsActive>1</IsActive><SequenceNo>0</SequenceNo><AddOrDelete>Y</AddOrDelete><Description>PROM125</Description></Rules>'
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


        
        Select * Into #tempItemCatalog  FROM OPENXML(@intpointer,'Json/ItemCatalogList',2)
        WITH
        (
		[ItemId] bigint,
		[ItemCode] nvarchar(200),
		[ItemShortCode] nvarchar(200) ,
		[CompanyId] bigint,
		[CompanyMnemonic] nvarchar(200) ,
		[IsActive] bit,
		[CreatedBy] bigint,
		[CreatedDate] datetime
        )tmp
        
		    --Select * from #tempItemCatalog
	--SELECT [ItemSupplierId]
	--,[ItemId]
	--,[ItemCode]
	--,[ItemShortCode]
	--,[CompanyId]
	--,[CompanyMnemonic]
	--,[IsActive]
	--,[CreatedBy]
	--,[CreatedDate]
	--,[ModifiedBy]
	--,[ModifiedDate]
	-- FROM [dbo].[ItemSupplier]

		Update [dbo].[ItemSupplier] set IsActive=tmp.[IsActive],ModifiedBy=tmp.[CreatedBy],ModifiedDate=GETDATE() from #tempItemCatalog tmp 
		where tmp.[CompanyId]=[ItemSupplier].[CompanyId] and tmp.[CompanyMnemonic]=[ItemSupplier].[CompanyMnemonic] and tmp.[ItemCode]=[ItemSupplier].[ItemCode] 
		
		INSERT INTO [dbo].[ItemSupplier]
           ([ItemId]
           ,[ItemCode]
           ,[ItemShortCode]
           ,[CompanyId]
           ,[CompanyMnemonic]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate])
		Select [ItemId]
           ,[ItemCode]
           ,[ItemShortCode]
           ,[CompanyId]
           ,[CompanyMnemonic]
           ,[IsActive]
           ,[CreatedBy]
           ,GETDATE() from #tempItemCatalog tmp where tmp.[IsActive]=1
		   and  NOT EXISTS
(
  Select [dbo].[ItemSupplier].ItemSupplierId from [dbo].[ItemSupplier] where tmp.[CompanyId]=[ItemSupplier].[CompanyId] and tmp.[CompanyMnemonic]=[ItemSupplier].[CompanyMnemonic] and tmp.[ItemCode]=[ItemSupplier].[ItemCode] 
)
		
    
    SELECT 1 as ItemCatalogId FOR XML RAW('Json'),ELEMENTS
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END