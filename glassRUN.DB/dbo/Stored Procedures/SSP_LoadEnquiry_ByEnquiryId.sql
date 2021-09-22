

CREATE PROCEDURE [dbo].[SSP_LoadEnquiry_ByEnquiryId] --'<Json><ServicesAction>LoadEnquiryByEnquiryId</ServicesAction><EnquiryId>405</EnquiryId><RoleId>4</RoleId><CultureId>1101</CultureId><UserId>536</UserId></Json>'

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
,[EnquiryAutoNumber],isnull(c.CreditLimit,0) as CreditLimit,isnull(c.AvailableCreditLimit,0) as AvailableCreditLimit ,
isnull(DiscountAmount,0) as DiscountAmount,
CONVERT(varchar(11),EnquiryDate,103) as EnquiryDate,
ISNULL(PromisedDate,RequestDate) as RequestDate,
PickDateTime as PickDateTime,
e.ShipTo,
dl.LocationCode as ShipToCode,
dl.LocationName,

ISNULL(dl.AddressLine1,'') + ' ' + ISNULL(dl.AddressLine2,'') + ' ' + ISNULL(dl.AddressLine3,'') + ' ' +
ISNULL(dl.AddressLine4,'') + ' ' + ISNULL((select CityName from City where CityId = dl.City),'') + ' ' + ISNULL((select StateName from [State] where StateId = dl.[State]),'') + ' ' + ISNULL(dl.Pincode,'') as ShipToLocationAddress

,e.StockLocationId,
e.SoldTo,
(SELECT [dbo].[fn_RoleWiseStatus] (@roleId,e.CurrentState,@CultureId)) AS 'Status',
  (SELECT [dbo].[fn_RoleWiseClass] (@roleId,e.CurrentState)) AS 'Class',
c.EmptiesLimit,
c.ActualEmpties,
ISNULL(e.PONumber,'') as PONumber,
ISNULL(e.SONumber,'') as SONumber,
c.CompanyMnemonic,
c.CompanyId,
c.CompanyName,
c.CompanyType,
ISNULL(c.Field9,'') as CompanyZone,
ISNULL(dl.Field1,'') as IsSelfCollectEnquiry,
e.NumberOfPalettes
,e.PalletSpace
,e.CurrentState
,(select COUNT(EnquiryProductId) from EnquiryProduct where EnquiryId = e.EnquiryId and IsActive = 1 and IsPackingItem <> 1) as TotalProductCounts
,e.Field8
,e.TruckWeight,
e.TruckSizeId,
ISNULL(e.TotalPrice,0) as TotalPrice,
ts.TruckSize
,ts.TruckCapacityWeight
,ts.TruckCapacityPalettes,
dl.Capacity,
ISNULL((select isnull(sum(ep1.ProductQuantity*isnull(ep1.UnitPrice,0)) , 0) from EnquiryProduct ep1 join Enquiry e1 on ep1.EnquiryId=e1.EnquiryId where 
e1.EnquiryId !=e.[EnquiryId] and
(e1.CurrentState in (1) or (e1.EnquiryId in (select o.EnquiryId from [Order] o where o.CurrentState=32)))
and e1.IsActive=1 and ep1.IsActive=1 and e1.SoldTo=e.SoldTo),0) AS TotalEnquiryCreated,

ISNULL((select isnull(sum(ep1.ProductQuantity*isnull(ep1.DepositeAmount,0)) , 0) from EnquiryProduct ep1 join Enquiry e1 on ep1.EnquiryId=e1.EnquiryId where 
e1.EnquiryId != e.[EnquiryId] and 
(e1.CurrentState in (1) or (e1.EnquiryId in (select o.EnquiryId from [Order] o where o.CurrentState=32)))
and e1.IsActive=1 and ep1.IsActive=1 and e1.SoldTo=e.SoldTo),0) AS EnquiryTotalDepositAmount,

ISNULL(e.IsRecievingLocationCapacityExceed, 0) as IsRecievingLocationCapacityExceed,
dl.LocationCode,
dl.Area,
(select top 1 rolemasterid from login where referenceid = e.soldto) as RoleId,
(select top 1 loginId from login where referenceid = e.soldto) as loginId,
(select cast ((SELECT 'true' AS [@json:Array] , [EnquiryProductId]
,[EnquiryId]
,[ProductCode]
,	i.ItemName as ItemName
,i.ItemId as ItemId
,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) AS PrimaryUnitOfMeasure
,isnull((SELECT [dbo].[fn_GetWeightPerUnitOfItem] (i.ItemId)),0) as [WeightPerUnit]
,umo.[ConversionFactor]
,ISNULL((ep.UnitPrice),0) as ItemPricesPerUnit
,ISNULL((ep.UnitPrice * ep.ProductQuantity),0) as ItemPrices,
isnull(ep.DepositeAmount,0) as DepositeAmount ,
isnull(ep.DepositeAmount,0) as DepositeAmountPerUnit,
ISNULL((isnull(ep.DepositeAmount,0) * ep.ProductQuantity),0) as ItemTotalDepositeAmount,
isnull((SELECT [dbo].[fn_GetCurrentDepositOfItem] (I.[ItemId],dl.CompanyID)),0)  as CurrentDeposit
,ep.[ProductType]
,ep.[ProductQuantity]
,ep.ParentProductCode
,isnull(ep.DiscountAmount,0) as DiscountAmount
,ISNULL(ep.UnitPrice,0) as UnitPrice
,ISNULL(ep.AssociatedOrder,0) as GratisOrderId
,ep.IsActive
,ISNULL(ep.ItemType,0) as ItemType
,ep.NumberOfExtraPallet as NumberOfExtraPalettes
,ISNULL(ep.IsPackingItem,'0') as IsPackingItem
,ISNULL(ep.PackingItemCode,'0') as PackingItemCode
,ISNULL(ep.PackingItemCount,0) as PackingItemCount
,ISNULL(ep.TotalVolume,0) as CurrentItemPalettesCorrectWeight
,ISNULL(ep.TotalWeight,0) as CurrentItemTruckCapacityFullInTone
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
FOR XML path('EnquiryProductList'),ELEMENTS) AS xml)),

(select cast ((SELECT  'true' AS [@json:Array]  ,  [NotesId]
      ,[RoleId]
      ,[ObjectId]
      ,[ObjectType]
      ,[Note]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
			From [Notes]
   WHERE IsActive = 1 AND ObjectId =  e.EnquiryId   and ObjectType=1220

FOR XML path('NoteList'),ELEMENTS) AS xml)),

(select cast ((SELECT  'true' AS [@json:Array]  ,  [ReturnPakageMaterialId]
      ,[EnquiryId]
      ,[ProductCode]
	  ,(SELECT top 1 ItemId FROM dbo.Item WHERE ItemCode=[ProductCode] and IsActive=1) AS ProductId
	  ,(SELECT top 1 ItemName FROM dbo.Item WHERE ItemCode=[ProductCode] and IsActive=1) AS ProductName

	    ,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) AS PrimaryUnitOfMeasure
	
      ,rpm.[ProductType]
      ,rpm.[ProductQuantity]
	
	  ,i.StockInQuantity
	   ,i.ItemShortCode
	    ,rpm.ItemType
		from [ReturnPakageMaterial] rpm left join Item i on rpm.ProductCode = i.ItemCode
			
   WHERE rpm.IsActive = 1 AND rpm.EnquiryId =  e.EnquiryId   

FOR XML path('ReturnPakageMaterialList'),ELEMENTS) AS xml))

FROM [dbo].[Enquiry] e 
left join Location dl on e.ShipTo = dl.LocationId
left join Company c on c.CompanyId = e.SoldTo
left join TruckSize ts on e.TruckSizeId = ts.TruckSizeId
WHERE (EnquiryId=@enquiryId OR @enquiryId=0) AND e.IsActive=1
FOR XML path('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)



END