
CREATE PROCEDURE [dbo].[SSP_GetOrderDetailsOfCustomerB2BApp] --'<Json><ServicesAction>GetEnquiryForSubDApp</ServicesAction><CompanyId>10056</CompanyId><SoldToCode>76666002</SoldToCode><searchValue></searchValue><OrderStatus>Active</OrderStatus><FromDate>2020-1-1</FromDate><ToDate>2020-1-1</ToDate><orderBy></orderBy></Json>'

@xmlDoc XML


AS

BEGIN


declare @soldToCode nvarchar(500)
DECLARE @roleId BIGINT
DECLARE @CultureId BIGINT

DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
DECLARE @whereClause NVARCHAR(max)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

set  @whereClause =''

SELECT 

@soldToCode = tmp.CustomerCode
,@roleId = tmp.[RoleId]
,@CultureId = tmp.[CultureId]

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			CustomerCode nvarchar(500)
			,[RoleId] BIGINT
			,[CultureId] BIGINT
			)tmp;


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT top 50 'true' AS [@json:Array]
		  ,enq.EnquiryId
		  ,enq.EnquiryAutoNumber
		  ,'' As SupplierslocationName
		  ,(select l.LocationName from [Location] l where l.LocationCode = enq.BillToCode) As BillToName
		  ,1 As CurrentStateDraft
		  ,o.PickDateTime
		  ,enq.EnquiryDate
		  ,enq.RequestDate
		  ,o.ShipToCode
		  ,o.ShipTo
		  ,c.CompanyName As CompanyName
		  ,o.CompanyCode As CompanyMnemonic
		  ,o.ShipToCode As DeliveryLocation
		  ,o.SoldTo
		  ,o.TruckSizeId
		  ,o.OrderDate
		  ,o.CurrentState
		  ,(SELECT [dbo].[fn_RoleWiseStatus] (@roleId,o.CurrentState,@CultureId)) AS [Status]
		  ,(SELECT [dbo].[fn_RoleWiseClass] (@roleId,o.CurrentState)) AS Class
		  ,o.OrderId
		  ,o.OrderType
		  ,o.ModifiedDate
		  ,o.OrderNumber
		  ,o.SalesOrderNumber
		  ,o.PurchaseOrderNumber
		  ,c.CompanyName As DeliveryLocationName
		  ,o.ShipToName As LocationName
		  ,c1.CompanyName As SupplierName
		  ,c1.CompanyMnemonic As SupplierCode
		  ,o.OrderedBy
		  ,o.CompanyId As OrderCompanyId
		  ,(select cast ((SELECT 'true' AS [@json:Array] 
				,0 As AssociatedOrder
				,i.ItemName
				,ISNULL((op.UnitPrice),0) as ItemPricesPerUnit
				,op.ProductCode
				,op.ProductQuantity
				,op.ProductType
				,0 As DepositeAmountPerUnit
				,op.OrderProductId
				,op.OrderId
				,op.ItemType
				,ISNULL((op.UnitPrice * op.ProductQuantity),0) as ItemPrices
				,0 As ItemTotalDepositeAmount
				,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) AS UOM
				from [OrderProduct] op left join Item i on op.ProductCode = i.ItemCode
				left join UnitOfMeasure umo on i.ItemId=umo.ItemId and i.PrimaryUnitOfMeasure=umo.UOM and umo.RelatedUOM=16
				WHERE op.IsActive = 1 AND op.OrderId = o.OrderId 
				FOR XML path('OrderProductList'),ELEMENTS) AS xml))
		  From [Order] o 
		  INNER JOIN Enquiry enq on enq.EnquiryId = o.EnquiryId and enq.IsActive = 1 and enq.RequestDate is not null
		  INNER JOIN [Company] c on c.CompanyMnemonic = o.CompanyCode
		  INNER JOIN [Company] c1 on c1.CompanyId = o.CompanyId
		  where o.IsActive = 1 and (o.SoldToCode =  @soldToCode  or @soldToCode = '')
		  order by  enq.RequestDate desc

		  FOR XML PATH('OrderList'),ELEMENTS,ROOT('Json')) AS XML)


END
