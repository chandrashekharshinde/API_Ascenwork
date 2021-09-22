
CREATE PROCEDURE [dbo].[SSP_LoadEnquiryDetailsByEnquiryNumber] --'<Json><EnquiryAutoNumber>INQ010236</EnquiryAutoNumber></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @enquiryNumber nvarchar(max)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @enquiryNumber = tmp.[EnquiryAutoNumber]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[EnquiryAutoNumber] nvarchar(max)
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((SELECT 'true' AS [@json:Array]  ,  [EnquiryId]
      ,[EnquiryAutoNumber],
	  CONVERT(varchar(25),e.RequestDate,120) as RequestDate,
	 CONVERT(varchar(25),e.OrderProposedETD,120) as  OrderProposedETD,
	 e.PickDateTime,
	  e.SoldTo,
	  e.SoldToName,
	  e.CurrentProcess,
	  e.CurrentState,
	  e.PreviousProcess,
	  e.PreviousState,
	  e.EnquiryType,
	  e.ShipTo,
	   e.ShipToCode,
	  e.SoldToCode,
	  e.ShipToName,
	  e.PrimaryAddressId,
	  e.SecondaryAddressId,
	  e.PromisedDate,
	  e.PONumber,
	  e.Remarks,
	  e.PreviousState,
	  e.NumberOfPalettes,
	  e.TruckSizeId,
	  e.TruckWeight,
	  e.IsRecievingLocationCapacityExceed,
	  e.StockLocationId,
	  e.StockLocationId as branchPlant,
	  e.Field2,
	  e.Field3,
	  e.CreatedBy,
	   (select cast ((SELECT  'true' AS [@json:Array]  ,  [EnquiryProductId]
      ,[EnquiryId]
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
		from [EnquiryProduct] ep left join Item i on ep.ProductCode = i.ItemCode
			--left join UnitOfMeasure umo on I.ItemId=umo.ItemId 
   WHERE ep.IsActive = 1 AND ep.EnquiryId = e.EnquiryId  
   --and i.PrimaryUnitOfMeasure=umo.UOM and umo.RelatedUOM=16
 FOR XML path('EnquiryProductList'),ELEMENTS) AS xml))

	FROM [dbo].[Enquiry] e left join TruckSize ts on e.TruckSizeId = ts.TruckSizeId
	left join Location dl on e.ShipTo = dl.LocationId
	  left join Company c on c.CompanyId = dl.CompanyId
	 WHERE (EnquiryAutoNumber in (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] (CONVERT(NVARCHAR(500),@enquiryNumber)))) AND e.IsActive=1
	FOR XML path('EnquiryDetailList'),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END
