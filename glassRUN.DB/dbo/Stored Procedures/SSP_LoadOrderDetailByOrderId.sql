CREATE PROCEDURE [dbo].[SSP_LoadOrderDetailByOrderId]

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;

declare @OrderId  bigint

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @OrderId = tmp.[OrderId]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				
				[OrderId] bigint
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((SELECT  e.[EnquiryId],
	e.OrderId,
    o.[EnquiryAutoNumber],
	--  CONVERT(varchar(11),e.RequestDate,103) as RequestDate,
	-- CONVERT(varchar(11),e.OrderProposedETD,103) as  OrderProposedETD,
	  e.SoldTo,
	  e.SoldToName,
	 -- e.CurrentProcess,
	  e.CurrentState,
	--  e.PreviousProcess,
	  e.PreviousState,
	  e.ShipTo,
	  e.ShipToCode,
	  e.SoldToCode,
	  e.ShipToName,
	  e.PrimaryAddressId,
	  e.SecondaryAddressId,
	  e.OrderType ,
	  e.PurchaseOrderNumber,
	  e.Remarks,
	  e.NumberOfPalettes,
	  e.TruckSizeId,
	  e.TruckWeight,
	  e.IsRecievingLocationCapacityExceed,
	  e.StockLocationId,
	  e.StockLocationId as branchPlant,
	  e.Field2,
	  e.Field3,
	  	  e.TotalPrice,
		  '' as CreatedBy,
		  e.ReferenceNumber,
	   (select cast ((SELECT  'true' AS [@json:Array]  , 
	   OrderProductId
      ,e.[EnquiryId]
      ,[ProductCode]
	   ,[ItemShortCode]
	  ,isnull(ep.DepositeAmount,0) as DepositeAmount 
      ,ep.[ProductType]
	  ,ep.ItemType
	  ,ep.Remarks
      ,ep.[ProductQuantity]
	  ,isnull(ep.DiscountAmount,0) as DiscountAmount
	  ,ISNULL(ep.UnitPrice,0) as UnitPrice
	  ,ISNULL(ep.AssociatedOrder,0) as GratisOrderId
	  ,ISNULL(ep.StockLocationCode,'') as StockLocationCode
	  ,ISNULL(ep.StockLocationName,'') as  StockLocationName    
		from OrderProduct ep left join Item i on ep.ProductCode = i.ItemCode
		
   WHERE ep.IsActive = 1 AND ep.OrderId = e.orderid  
 FOR XML path('Item'),ELEMENTS) AS xml))

	FROM [dbo].[order] e left join TruckSize ts on e.TruckSizeId = ts.TruckSizeId
	left join [Location] dl on e.ShipTo = dl.[LocationId]
	  left join Company c on c.CompanyId = dl.CompanyId
	  left join Enquiry o on o.EnquiryId =e.EnquiryId
	 WHERE e.OrderId=@OrderId AND e.IsActive=1
	FOR XML path('Enquiry'),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END
