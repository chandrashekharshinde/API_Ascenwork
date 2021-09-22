CREATE PROCEDURE [dbo].[SSP_AllItemList] --'<Json><ServicesAction>LoadAllProducts</ServicesAction><CompanyId>274</CompanyId></Json>'
(
@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @companyId bigint=0

declare @ItemValue  nvarchar(250)=''
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId],
@ItemValue = tmp.[ItemValue]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint,
			[ItemValue] nvarchar(250)
			)tmp


			IF @ItemValue is  nullBEGIN SET @ItemValue = '';END;

Set @ItemValue=(SELECT [dbo].[fn_GetItemSearchText] (@ItemValue));


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)

SELECT CAST((SELECT   distinct       'true' AS [@json:Array],  I.[ItemId]
      ,I.[ItemName]
      ,I.[ItemCode]
	  ,I.[ItemName] + ' (' + I.[ItemCode] + ')' as ItemNameCode
	  ,I.[ItemCode] as Id
	  ,I.[ItemName] + ' (' + I.[ItemCode] + ')' as Name
      ,I.[ItemShortCode]
	  	  ,I.[ProductType]
	  ,I.[PrimaryUnitOfMeasure]
     ,(SELECT [dbo].[fn_GetWeightPerUnitOfItem] (I.ItemId)) as [WeightPerUnit]
	 ,umo.[ConversionFactor]

  FROM [Item] I  
  left join UnitOfMeasure umo on I.ItemId=umo.ItemId  WHERE I.IsActive =1 
  and I.ItemId not in (select ItemId from ItemSoldToMapping where IsActive = 1 and SoldTo in (select CompanyMnemonic from Company where (CompanyId = @companyId or @companyId = 0))) 
    and umo.RelatedUOM in (select top 1 SettingValue from SettingMaster where SettingParameter = 'UOMForPalletConversion' and isactive = 1) 
	and I.PrimaryUnitOfMeasure=umo.UOM 
	and (@ItemValue='"**"' or (CONTAINS (ItemName,@ItemValue) or CONTAINS (ItemCode,@ItemValue)))
  --and  (ItemName like '%'+@ItemValue+'%' or ItemCode like '%'+@ItemValue+'%')
	FOR XML path('ItemList'),ELEMENTS,ROOT('Item')) AS XML)
END