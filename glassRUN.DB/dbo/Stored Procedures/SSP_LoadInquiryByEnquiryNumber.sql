CREATE PROCEDURE [dbo].[SSP_LoadInquiryByEnquiryNumber] --'<Json><ServicesAction>LoadEnquiryByEnquiryId</ServicesAction><EnquiryAutoNumber>INQ000017</EnquiryAutoNumber></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @enquiryNumber nvarchar(max)
Declare @UserId bigint=0


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @enquiryNumber = tmp.[EnquiryAutoNumber],
@UserId=tmp.[UserId]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[EnquiryAutoNumber] nvarchar(max),
				[UserId] nvarchar(max)
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((SELECT 'true' AS [@json:Array]  ,  
	[EnquiryId]
      ,[EnquiryAutoNumber],
	  CONVERT(varchar(11),e.RequestDate,103) as RequestDate,
	 CONVERT(varchar(11),e.OrderProposedETD,103) as  OrderProposedETD,
	 e.CompanyCode  as 'SupplierCode',
	  e.CompanyCode  ,
	  isnull(e.CarrierCode ,'0')   as CarrierCode   ,
	 
  Convert(nvarchar(250), DATEPART( DD,GETDATE()))   +Convert(nvarchar(250), DATEPART( MM,GETDATE()))  +Convert(nvarchar(250), DATEPART( YYYY,GETDATE())) 
+Convert(nvarchar(250), EnquiryId)    as 'BatchNumber',
	  e.PickDateTime ,
	  e.EnquiryDate ,
	  e.PromisedDate,
	  e.SoldTo,
	  e.SoldToName,
	  e.CurrentProcess,
	  e.CurrentState,
	  e.PreviousProcess,
	  e.PreviousState,
	  e.ShipTo,
	  e.ShipToCode,
	  e.SoldToCode,
	  e.ShipToName,
	  e.PrimaryAddressId,
	  e.SecondaryAddressId,
	  e.EnquiryType,
	  e.PONumber,
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
		  @UserId as CreatedBy,
		 CONVERT(varchar(11),e.EnquiryDate ,101)  as  EnquiryDateInMMDDYYY   ,
		  CONVERT(varchar(11),e.PromisedDate ,101)  as  PromisedDateInMMDDYYY   ,
		   CONVERT(varchar(11),e.RequestDate ,101)  as  RequestDateInMMDDYYY   ,
		      CONVERT(varchar(11),getdate() ,101)  as  OrderDateInMMDDYYY   ,
			  Description1,
			  Description2,
			  Province,
			  GratisCode,
			  OrderedBy,
	  
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
	,  Case when (select SettingValue from SettingMaster where SettingParameter='StockAccordingToBranchPlant') = '1' then 
   Convert(Decimal(18,0),(SELECT ISNULL([dbo].[fn_AvailableProductQuantityFloat] (ep.ProductCode,e.StockLocationId),0)))  
  else ISNULL(Convert(Decimal(18,0),(select top 1 ItemQuantity from ItemStock where  ItemCode = ep.ProductCode)),0)  end as CurrentStockPosition  
		
		from [EnquiryProduct] ep left join Item i on ep.ProductCode = i.ItemCode
			--left join UnitOfMeasure umo on I.ItemId=umo.ItemId 
   WHERE ep.IsActive = 1 AND ep.EnquiryId = e.EnquiryId  
   --and i.PrimaryUnitOfMeasure=umo.UOM and umo.RelatedUOM=16
 FOR XML path('Item'),ELEMENTS) AS xml))

	FROM [dbo].[Enquiry] e left join TruckSize ts on e.TruckSizeId = ts.TruckSizeId
	left join [Location] dl on e.ShipTo = dl.[LocationId]
	  left join Company c on c.CompanyId = dl.CompanyId
	 WHERE (EnquiryAutoNumber in (SELECT * FROM [dbo].[fnSplitValuesForNvarchar] (CONVERT(NVARCHAR(500),@enquiryNumber)))) AND e.IsActive=1
	FOR XML path('Enquiry'),ELEMENTS,ROOT('Json')) AS XML)
	
	
	
END
