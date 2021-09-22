CREATE FUNCTION [dbo].[fn_UsedProductQuantityByItemAndCompany] --66605001, 6410
(
 @ProductCode nvarchar(100),
 @FromDate nvarchar(100),
 @ToDate nvarchar(100),
 @CompanyType nvarchar(100)

)



RETURNS decimal(18,2)

BEGIN



    RETURN (


SELECT
 (ISNULL((Select Sum(ep.ProductQuantity) from Enquiry e join EnquiryProduct ep on e.EnquiryId=ep.EnquiryId 
 left join [Order] o on e.EnquiryId = o.EnquiryId
where ep.IsActive =1 and e.CurrentState not in  (8,7,33,34,999) and ISNULL(o.CurrentState,0) not in (34) and  ep.ItemType = 32 and e.SoldTo = @CompanyType
 and Isnull(ep.AssociatedOrder,0) = 0 and ep.ProductCode in (SELECT * FROM [dbo].[fnSplitValues] (@ProductCode))  
 
and convert(varchar, convert(datetime, e.CreatedDate, 103), 101) between convert(varchar, convert(datetime, @FromDate, 103), 101) and convert(varchar, convert(datetime, @ToDate, 103), 101)),0)) as UsedQuantity
  )
END
