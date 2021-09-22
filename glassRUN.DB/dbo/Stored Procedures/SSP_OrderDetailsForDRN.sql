CREATE PROCEDURE [dbo].[SSP_OrderDetailsForDRN] 
 @OrderID bigint
as
WITH Order_CTE (OrderId, OrderNumber,Orderdate,StockLocationId,LoadNumber,InvoiceNumber,RedInvoiceNumber,TruckSize, SoldToCode, ShipToCode, CompanyName, ShipToName,CompanyAddress, TotalDepositeAmount, TotalTaxAmount,TotalQuantity, TotalPrice, TotalVolume, TotalWeight, ShipToAddress )
AS
(SELECT o.OrderId ,o.OrderNumber,o.orderdate,o.StockLocationId,o.LoadNumber,o.InvoiceNumber,o.RedInvoiceNumber,ts.TruckSize, o.SoldToCode, o.ShipToCode, c.CompanyName, l.LocationName, 
                  isnull(c.AddressLine1,'') + ', ' + isnull(c.AddressLine2,'') + ', ' + isnull(c.AddressLine3,'') + ', ' + isnull(c.Country,'') AS CompanyAddress, o.TotalDepositeAmount, 
				  o.TotalTaxAmount,o.TotalQuantity, o.TotalPrice, o.TotalVolume, o.TotalWeight, 
                  isnull(l.AddressLine1,'') + ', ' + isnull(l.AddressLine2,'') + ', ' + isnull(l.AddressLine3,'') + ', ' + isnull(l.Country,'') AS ShipToAddress
FROM     dbo.Location l INNER JOIN
                  dbo.[Order] o INNER JOIN
                  dbo.Company c ON o.SoldTo = c.CompanyId ON l.LocationId = o.ShipTo 
				  Inner Join TruckSize ts on o.TruckSizeid = ts.TruckSizeID
				  Where o.OrderId=@OrderId)  
,
CollectionLocation_CTE (Orderid, OrderNumber, CollectionDPName, CollectionTruckNumber,CollectionTime ) 
AS
(Select  O.OrderId,O.OrderNumber,lo.Name as CollectionDPName, ol.TruckPlateNumber as CollectionTruckNumber,om.ActualTimeOfAction as CollectionTime 
FROM              dbo.[Order] o INNER JOIN
                  dbo.OrderMovement om ON o.OrderId = om.OrderId INNER JOIN
                  dbo.OrderLogistics ol ON om.OrderMovementId = ol.OrderMovementId INNER JOIN
                  dbo.Login lo ON om.DeliveryPersonnelId = lo.LoginId Where LocationType=1  and o.OrderId=@OrderId)
,DeliveryLocation_CTE (Orderid, OrderNumber, DeliveryDPName, DeliveryTruckNumber,DeliveryTime) 
AS
(Select O.OrderId,O.OrderNumber,lo.Name as DeliveryDPName, ol.TruckPlateNumber as DeliveryTruckNumber,om.ActualTimeOfAction as DeliveryTime
FROM              dbo.[Order] o INNER JOIN
                  dbo.OrderMovement om ON o.OrderId = om.OrderId INNER JOIN
                  dbo.OrderLogistics ol ON om.OrderMovementId = ol.OrderMovementId INNER JOIN
                  dbo.Login lo ON om.DeliveryPersonnelId = lo.LoginId Where LocationType=2 and o.OrderId=@OrderId)
Select o.OrderId, o.OrderNumber,o.Orderdate, StockLocationId,LoadNumber,InvoiceNumber,RedInvoiceNumber, TruckSize,SoldToCode, ShipToCode, CompanyName, ShipToName,CompanyAddress, TotalDepositeAmount, TotalTaxAmount,TotalQuantity, TotalPrice, TotalVolume, TotalWeight, ShipToAddress,
 CollectionDPName, CollectionTruckNumber, DeliveryDPName, DeliveryTruckNumber,CollectionTime,DeliveryTime
 from Order_CTE o 
				Inner Join CollectionLocation_CTE  cl on o.orderid = cl.orderid 
				Inner Join DeliveryLocation_CTE dl on o.orderid = dl.orderid 


