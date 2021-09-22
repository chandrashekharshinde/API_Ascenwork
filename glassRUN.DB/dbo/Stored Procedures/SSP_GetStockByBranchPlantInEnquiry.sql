

CREATE PROCEDURE [dbo].[SSP_GetStockByBranchPlantInEnquiry] --'<Json><ServicesAction>LoadStockAndCarrierEnquiry</ServicesAction><EnquiryId>27005</EnquiryId><RoleId>3</RoleId><CultureId>1101</CultureId><UserId>507</UserId></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @enquiryId BIGINT
declare @roleId BIGINT
declare @CultureId BIGINT


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @enquiryId = tmp.[EnquiryId],
@roleId = tmp.[RoleId],
@CultureId = tmp.[CultureId]

FROM OPENXML(@intpointer,'Json',2)
WITH
(
[EnquiryId] bigint,
[RoleId] bigint,
[CultureId] bigint
)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

Select Cast((SELECT [EnquiryId]
,[EnquiryAutoNumber]
,CarrierId
,CarrierCode
,CarrierName
,CollectionLocationCode
,(select LocationName from Location where LocationCode=CollectionLocationCode) as CollectionLocationName

,(select cast ((SELECT 'true' AS [@json:Array] , [EnquiryProductId]
,[EnquiryId]
,[ProductCode]
,ProductQuantity
--,i.StockInQuantity
,Case when (select SettingValue from SettingMaster where SettingParameter='StockAccordingToBranchPlant') = '1' then 
   Convert(Decimal(18,0),(SELECT ISNULL([dbo].[fn_AvailableProductQuantityFloat] (ep.ProductCode,e.StockLocationId),0)))  
  else ISNULL(Convert(Decimal(18,0),(select top 1 ItemQuantity from ItemStock where  ItemCode = ep.ProductCode)),0)  end as CurrentStockPosition

--,Convert(Decimal(18,0),(SELECT ISNULL([dbo].[fn_AvailableProductQuantityFloat] (ep.ProductCode,ep.StockLocationCode),0))) as CurrentStockPosition
, (SELECT ISNULL([dbo].[fn_UsedEnquiryQuantityFloat] (ep.ProductCode,ep.StockLocationCode,e.CreatedDate),0)) as UsedQuantityInEnquiry

from [EnquiryProduct] ep left join Item i on ep.ProductCode = i.ItemCode
left join UnitOfMeasure umo on I.ItemId=umo.ItemId and i.PrimaryUnitOfMeasure=umo.UOM and umo.RelatedUOM=16
left join TruckSize ts on ts.TruckSizeId = e.TruckSizeId 
WHERE ep.IsActive = 1 AND ep.EnquiryId = e.EnquiryId 
FOR XML path('EnquiryProductList'),ELEMENTS) AS xml))

FROM [dbo].[Enquiry] e 

WHERE (EnquiryId=@enquiryId OR @enquiryId=0) AND e.IsActive=1
FOR XML path('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)



END