CREATE PROCEDURE [dbo].[SSP_AllItemListForMOT] --'<Json><ServicesAction>LoadAllProducts</ServicesAction></Json>'
(
@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @companyId bigint=0

declare @ItemValue  nvarchar(250)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId],
@ItemValue = tmp.[ItemValue]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint,
			[ItemValue] nvarchar(250)
			)tmp


			
IF @ItemValue is  null
BEGIN

 SET @ItemValue = '';
END;




WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)

SELECT CAST((SELECT   distinct   'true' AS [@json:Array],  I.[ItemId]
      ,I.[ItemName]
      ,I.[ItemCode]
	  ,I.[ItemName] + ' (' + I.[ItemCode] + ')' as ItemNameCode
	  ,I.[ItemCode] as Id
	  ,I.[ItemName] + ' (' + I.[ItemCode] + ')' as Name
      ,I.[ItemShortCode]
	  ,I.[ProductType]
	  
	  ,(SELECT [dbo].[fn_LookupValueById] (I.PrimaryUnitOfMeasure)) as UOM
      ,(SELECT [dbo].[fn_GetWeightPerUnitOfItem] (I.ItemId)) as [WeightPerUnit]     
	  ,(SELECT [dbo].[fn_GetPriceOfItem] (I.[ItemId],@CompanyId)) as Amount
	  , isnull((SELECT [dbo].[fn_GetCurrentDepositOfItem] (I.[ItemId],@CompanyId)),0)  as CurrentDeposit
	  ,isnull((select top 1 ul.[ConversionFactor] from UnitOfMeasure ul where ul.UOM=I.PrimaryUnitOfMeasure and ul.RelatedUOM=17 and ul.ItemId=I.ItemId),0) as QtyPerLayer
      
      , (SELECT [dbo].[fn_LookupValueById] (umo.[RelatedUOM])) as [RelatedUOM]
      ,umo.[UOMStructure]
      ,umo.[ConversionFactor]
      ,umo.[ConversionFactorSecondaryToPrimary]
  FROM [Item] I  
  left join UnitOfMeasure umo on I.ItemId=umo.ItemId  WHERE I.IsActive =1 and I.ItemId 
  not in (select ItemId from ItemSoldToMapping where IsActive = 1 and SoldTo in (select CompanyMnemonic from Company where (CompanyId = @companyId or @companyId = 0))) 
  and umo.RelatedUOM in (select top 1 SettingValue from SettingMaster where SettingParameter = 'UOMForPalletConversion' and isactive = 1) 
  
	FOR XML path('ItemList'),ELEMENTS,ROOT('Item')) AS XML)
END