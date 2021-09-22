
CREATE PROCEDURE [dbo].[SSP_GetAllOrderBySalesOrderNumber]--'<Json><ServicesAction>GetAllOrderBySalesOrderNumber</ServicesAction><SalesOrderNumber>34534555</SalesOrderNumber></Json>'
(
@xmlDoc XML
)
AS



BEGIN

DECLARE @intPointer INT;


Declare @SalesOrderNumber NVARCHAR(250)
Declare @RoleId bigint
Declare @CultureId  bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @SalesOrderNumber = tmp.[SalesOrderNumber],
	 @RoleId = tmp.[RoleId],
	  @CultureId = tmp.[CultureId]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   
   [SalesOrderNumber] nvarchar(250),
   [RoleId]  bigint,
   [CultureId] bigint
  
   )tmp ;




   WITH  XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

  select cast ((SELECT  'true' AS [@json:Array]  ,    o.OrderId,  o.OrderNumber  , OrderType  ,o.PurchaseOrderNumber,o.SalesOrderNumber,
   isnull( (SELECT top 1 [ResourceValue] FROM [dbo].[RoleWiseStatusView] where [RoleId]=@RoleId and [StatusId]=o.CurrentState and [CultureId]=@CultureId),'-')    AS 'StatusDescription',
	  (SELECT top 1 [Class] FROM [dbo].[RoleWiseStatusView] where [RoleId]=@RoleId  and [StatusId]=o.CurrentState) AS 'Class',
  CONVERT(VARCHAR(10), com.ActualTimeOfAction, 103) as 'CollectionDate' , 
  CONVERT(VARCHAR(10),  dom.ActualTimeOfAction, 103) as 'DeliveryDate' ,
  isnull(otc.TripCost,0) as  'TripCost',
   isnull(otc.TripRevenue,0) as  'TripRevenue',
 
  l.UserName
  , (select  top 1 VehicleRegistrationNumber from  TransportVehicle  tv where tv.TransportVehicleId=col.TransportVehicleId)  as 'VehicleRegistrationNumber'
     from  [order]  o  
	  left join  OrderMovement  com  on com.OrderId  = o.OrderId  and com.LocationType=1
	    left join  OrderMovement  dom  on dom.OrderId  = o.OrderId  and dom.LocationType=2
		left join Login l on l.LoginId = com.DeliveryPersonnelId
		left join OrderLogistics  col on col.OrderMovementId = com.OrderMovementId
		left join  OrderTripCost  otc on otc.OrderId = o.OrderId
	   where o.SalesOrderNumber  =@SalesOrderNumber
	   FOR XML PATH('OrderList'),ELEMENTS,ROOT('Json')) AS XML)


	

END
