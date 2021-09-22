
CREATE PROCEDURE [dbo].[SSP_GetMissingAllReport] 

AS

BEGIN
 
 ----get customer missing data regarding of ship location and Proposed date
 select CompanyName  as 'Sold To' ,CompanyMnemonic as 'Sold To Code',(case when ShipToLocationCount=0 then 'Missing' else 'Available' end) as 'ShipToLocation' 
,(case when ProposedDeliveryDateCount=0 then 'Missing' else 'Available' end) as 'ProposedDeliveryDate'From (
select  c.CompanyId , c.CompanyName , c.CompanyType , Field1 as IsSelfCollect,c.CompanyMnemonic ,

 (select COUNT(*)from DeliveryLocation dl where dl.CompanyID=c.CompanyId  and dl.IsActive=1) as 'ShipToLocationCount' ,
 (select COUNT(*)  from rules  r where Remarks='ProposedDeliveryDate'  and  CONVERT(bigint ,r.CompanyType ) =c.CompanyMnemonic  and r.IsActive=1) as 'ProposedDeliveryDateCount' 


From Company c  where c.IsActive=1 and c.CompanyType in (22,26) and   isnull(c.Field10,'') !='G' )tmp where tmp.ShipToLocationCount=0 Or  tmp.ProposedDeliveryDateCount=0
 
 ----------------get shipto lcation missing data


select DeliveryLocationName as 'Ship To' , DeliveryLocationCode  as 'Ship To Code', CompanyName as 'Sold To',CompanyMnemonic as 'Sold To Code'
,(case when Area is null then 'Missing' else 'Available' end) as 'Area'
,(case when Capacity is null then 'Missing' else 'Available' end) as 'Capacity'
, (case when TruckSizeCount=0 then 'Missing' else 'Available' end) as 'Truck Size'
,(case when BranchPlantCount=0 then 'Missing' else 'Available' end) as 'Branch Plant' 
,(case when CarrierCount=0 then 'Missing' else 'Available' end) as 'Carrier'  From (

select dl.DeliveryLocationId , dl.DeliveryLocationName,dl.DeliveryLocationCode ,C.CompanyId , C.CompanyName,C.Field1,c.CompanyMnemonic,

dl.Area,
dl.Capacity,

(select count(*) From TruckSize ts where ts.TruckSizeId in (select TruckSizeId from Route r where r.DestinationId=dl.DeliveryLocationId) and ts.IsActive=1) as 'TruckSizeCount',

(select count(*) From DeliveryLocation bp where bp.DeliveryLocationId in (select OriginId from Route r where r.DestinationId=dl.DeliveryLocationId) and bp.IsActive=1) as 'BranchPlantCount',
(select count(*) From Company cr where cr.CompanyId in (select CarrierNumber from Route r where r.DestinationId=dl.DeliveryLocationId) and cr.IsActive=1) as 'CarrierCount'


From DeliveryLocation dl left join Company c on c.CompanyId=dl.CompanyID

where dl.IsActive=1 and c.IsActive=1 and dl.LocationType=27  and   isnull(c.Field10,'') !='G' ) tmp where tmp.TruckSizeCount =0 or tmp.BranchPlantCount=0 or (tmp.CarrierCount=0 AND tmp.Field1 !='SCO')   or Area is null or Capacity is null


 ------------------------get item missing data regarding unitof messuare and Prices

 select ItemName ,ItemCode
,(case when WeightCount=0 then 'Missing' else 'Available' end) as 'Weight Conversion'
,(case when LayerCount=0 then 'Missing' else 'Available' end) as 'Layer Conversion'
,(case when PalletCount=0 then 'Missing' else 'Available' end) as 'Pallet Conversion'
,(case when ISNULL(tmp.ItemPrice,0)=0 then 'Missing' else 'Available' end) as 'Price' From (
select i.ItemId , i.ItemName ,i.ItemCode,i.ItemShortCode , i.PrimaryUnitOfMeasure ,
(select COUNT(*)from UnitOfMeasure u where (u.UOM=18 or u.RelatedUOM=18)   and u.ItemId=i.ItemId) as 'WeightCount',
(select COUNT(*)from UnitOfMeasure u where (u.UOM=17 or u.RelatedUOM=17)   and u.ItemId=i.ItemId) as 'LayerCount',
(select COUNT(*)from UnitOfMeasure u where (u.UOM=16 or u.RelatedUOM=16)   and u.ItemId=i.ItemId) as 'PalletCount',

(select dbo.fn_GetPriceOfItem(i.ItemId , 0)) as 'ItemPrice'

from Item i where i.IsActive=1)tmp where  ISNULL(tmp.ItemPrice,0) =0 or WeightCount=0 or LayerCount =0 or PalletCount=0




----------------------get truck size missing data

select TruckSize,  (case when isnull(TruckCapacityPalettes,0)=0 then 'Missing' else 'Available' end) as 'Palette Capacity'
,(case when isnull(TruckCapacityWeight,0)=0 then 'Missing' else 'Available' end) as 'Maximum Permissible Weight'
from TruckSize ts where ts.IsActive=1 and isnull(TruckCapacityPalettes,0)=0 or ISNULL(TruckCapacityWeight,0)=0


END
