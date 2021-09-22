
CREATE PROCEDURE [dbo].[SSP_GetPickSlipReportById] --76399 
@orderid bigint
AS

BEGIN
 

 select * ,(isnull(SubTotal ,0) +isnull(CdDeposit ,0)) as'Total', (isnull(SubTotal ,0) +isnull(CdDeposit ,0)+ ISNULL(SalesTax,0)) as'GrandTotal'   From (

select 
       o.OrderId
    ,o.OrderNumber as SalesOrderNumber
    ,o.LoadNumber
    ,(select top 1 ol.TruckPlateNumber from OrderLogistics ol join OrderMovement om on ol.OrderMovementId=om.OrderMovementId where om.OrderId=o.OrderId and om.LocationType=1) as TruckNumber
      ,op.[ProductCode]
      ,op.[ProductType]
   ,(select isnull(e.RequestDate,e.OrderProposedETD) from Enquiry e where e.Enquiryid=o.Enquiryid)  RequestedDateOfDelivery
      ,op.[ProductQuantity] as Quantity
      ,op.[UnitPrice] as Prices
      ,(SELECT [dbo].[fn_ShortCodeLookupValueById] (I.PrimaryUnitOfMeasure)) as UnitOfMeasure
      ,op.[ShippableQuantity]
      ,op.[BackOrderQuantity]
      ,op.[CancelledQuantity]
      ,op.[AssociatedOrder]
      ,op.[Remarks] 
   ,I.ItemName as [Name]
   ,(select DeliveryLocationName from DeliveryLocation where DeliveryLocationId=o.ShipTo ) as DeliveryLocationAddress
    ,c.CompanyName as CustomerName
    ,c.CompanyMnemonic as CustomerCode
    , isnull((select c.AddressLine1+''+c.AddressLine2+''+c.AddressLine3),'') as SoldTo
   ,c.TaxId 
   , (select top 1 SettingValue From SettingMaster where SettingParameter='ItemTaxInPec' ) as TaxPercent
    ,'' as BRANCHPLANT
	 , (select isnull(sum(ProductQuantity*isnull(UnitPrice,0)) , 0)From OrderProduct where OrderId=o.orderid and ItemType !=39 ) as 'SubTotal'
 , (select isnull(sum(ProductQuantity*isnull(DepositeAmount,0)) , 0)From OrderProduct where OrderId=o.orderid  and ItemType !=39) as 'CdDeposit'
,(select isnull(sum(ProductQuantity*isnull(UnitPrice,0)) , 0)From OrderProduct where OrderId=o.orderid and ItemType !=39 ) /(select top 1 SettingValue From SettingMaster where SettingParameter='ItemTaxInPec' ) as 'SalesTax'
   from OrderProduct op
   left join [Order] o on op.OrderId=o.OrderId
   left join [Item] I on I.ItemCode=op.[ProductCode]
   left join Company c on c.CompanyId =o.SoldTo
   where o.OrderId=@orderid and ISNULL(op.AssociatedOrder,0) = 0 and   ISNULL(op.ItemType,0)  !=39)tmp
   order by tmp.OrderId  


 

END
