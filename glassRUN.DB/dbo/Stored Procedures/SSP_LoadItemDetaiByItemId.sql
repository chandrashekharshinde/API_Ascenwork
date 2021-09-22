CREATE PROCEDURE [dbo].[SSP_LoadItemDetaiByItemId] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><SalesOrderNumber>18016808</SalesOrderNumber><RoleId>3</RoleId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @companyId bigint=0
Declare @ItemId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId],
 @ItemId = tmp.[ItemId] 
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[ItemId] bigint,
				[CompanyId] bigint
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	
SELECT CAST((SELECT    'true' AS [@json:Array] ,     I.[ItemId]
      ,I.[ItemName]
      ,I.[ItemCode]
	  ,I.[ItemName] + ' (' + I.[ItemCode] + ')' as ItemNameCode
	  ,I.[ItemCode] as Id
	  ,I.[ItemName] + ' (' + I.[ItemCode] + ')' as Name
      ,I.[ItemShortCode]
      ,I.[PrimaryUnitOfMeasure]
      ,I.[SecondaryUnitOfMeasure]
      ,I.[ProductType]
      ,I.[BussinessUnit]
      ,I.[DangerGoods]
      ,I.[Description]
      ,I.[StockInQuantity]
      ,(SELECT [dbo].[fn_GetWeightPerUnitOfItem] (I.ItemId)) as [WeightPerUnit]
      ,I.[ImageUrl]
      ,I.[PackSize]
      ,I.[BranchPlant]
      ,I.[CreatedBy]
      ,I.[CreatedDate]
      ,I.[ModifiedBy]
      ,I.[ModifiedDate]
      ,I.[IsActive]
      ,I.[SequenceNo]
      ,I.[Field1]
      ,I.[Field2]
      ,I.[Field3]
      ,I.[Field4]
      ,I.[Field5]
      ,I.[Field6]
      ,I.[Field7]
      ,I.[Field8]
      ,I.[Field9]
      ,I.[Field10]
	 ,(SELECT [dbo].[fn_GetPriceOfItem] (I.[ItemId],@CompanyId)) as Amount
	 , isnull((SELECT [dbo].[fn_GetCurrentDepositOfItem] (I.[ItemId],@CompanyId)),0)  as CurrentDeposit
	 ,isnull((select top 1 ul.[ConversionFactor] from UnitOfMeasure ul where ul.UOM=I.PrimaryUnitOfMeasure and ul.RelatedUOM=17 and ul.ItemId=I.ItemId),0) as QtyPerLayer
      ,(SELECT [dbo].[fn_LookupValueById] (I.PrimaryUnitOfMeasure)) as UOM
      , (SELECT [dbo].[fn_LookupValueById] (umo.[RelatedUOM])) as [RelatedUOM]
      ,umo.[UOMStructure]
      ,umo.[ConversionFactor]
      ,umo.[ConversionFactorSecondaryToPrimary]
	  ,(select cast ((SELECT  'true' AS [@json:Array] , [PromotionFocItemDetailId]
      ,p.[ItemCode]
	  ,(Select I.ItemId from Item I where I.ItemCode=p.[ItemCode]) as ItemId
      ,p.[ItemQuanity]
      ,p.[FocItemCode]
	   ,(Select I.ItemId from Item I where I.ItemCode=p.[FocItemCode]) as FocItemId
      ,p.[FocItemQuantity]
      ,p.[Region]
     
  FROM [dbo].[PromotionFocItemDetail] p    where p.IsActive=1 
 and (Convert(date,GETDATE())  between   Convert(date,p.FromDate)  and   Convert(date,p.ToDate)   ) and p.ItemCode = i.ItemCode  
				FOR XML path('PromotionFocItemDetailList'),ELEMENTS) AS xml))
  FROM [Item] I  
  left join UnitOfMeasure umo on I.ItemId=umo.ItemId  WHERE I.IsActive =1 and I.ItemId 
  not in (select ItemId from ItemSoldToMapping where IsActive = 1 and SoldTo in (select CompanyMnemonic from Company where (CompanyId = @companyId or @companyId = 0))) 
  and umo.RelatedUOM in (select top 1 SettingValue from SettingMaster where SettingParameter = 'UOMForPalletConversion' and isactive = 1) 
 and i.ItemId=@ItemId  or  i.ItemType  = 'Pallet'
	FOR XML path('ItemList'),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END
