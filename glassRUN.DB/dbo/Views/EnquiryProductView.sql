

CREATE View [dbo].[EnquiryProductView] as
SELECT EnquiryProductId,ep.EnquiryId
  ,ProductCode
  ,ProductType
  ,ProductQuantity  
  ,UnitPrice as UnitPrice
  ,DepositeAmount
  ,(ep.DepositeAmount * ep.ProductQuantity) as ItemTotalDepositeAmount
  ,ep.[SequenceNo],
    ISNULL(ep.AssociatedOrder,0) as GratisOrderId,
     (SELECT ISNULL([dbo].[fn_UsedEnquiryQuantity] (ep.ProductCode,ep.StockLocationCode,t.CreatedDate),0))  as UsedQuantityInEnquiry,
	 0 as UsedQuantityInOrder,
	 (SELECT ISNULL([dbo].[fn_AvailableProductQuantity] (ep.ProductCode,ep.StockLocationCode),0)) as ProductAvailableQuantity
	 ,(Select top 1 ItemShortCode from Item where ItemCode=ep.ProductCode) as ItemShortCode
		  ,ep.ItemType
		  ,ep.IsActive
   FROM dbo.EnquiryProduct ep join [Enquiry] t on ep.EnquiryId=t.EnquiryId
