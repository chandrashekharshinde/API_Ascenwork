
CREATE PROCEDURE [dbo].[SSP_GetEnquiryDetailsOfCustomerB2BApp] --'<Json><ServicesAction>GetEnquiryForSubDApp</ServicesAction><CompanyId>10056</CompanyId><SoldToCode>76666002</SoldToCode><searchValue></searchValue><OrderStatus>Active</OrderStatus><FromDate>2020-1-1</FromDate><ToDate>2020-1-1</ToDate><orderBy></orderBy></Json>'

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
		  ,'' As CopyOrderGUID
		  ,enq.EnquiryGuid As OrderGUID
		  ,enq.Description1 As InquiryDescription
		  ,enq.Field5
		  ,enq.EnquiryId
		  ,'Enquiry' As ObjectType
		  ,enq.EnquiryId As objectId
		  ,enq.EnquiryAutoNumber
		  ,enq.EnquiryAutoNumber As ObjectAutoNumber
		  ,enq.PickDateTime
		  ,enq.EnquiryType
		  ,ISNULL(enq.IsSelfCollect,0) As IsOrderSelfCollect
		  ,'' As SupplierslocationName
		  ,Replace(TRIM(CONVERT(varchar(12),enq.EnquiryDate,13)),' ','-') As ActivityStartTime
		  ,Replace(TRIM(CONVERT(varchar(12),enq.EnquiryDate,13)),' ','-') + ' ' + Replace(TRIM(CONVERT(varchar(20),enq.EnquiryDate,108)),' ','-') As EnquiryDate
		  ,Replace(TRIM(CONVERT(varchar(12),enq.RequestDate,13)),' ','-') As RequestDate
		  ,enq.ShipToName
		  ,enq.ShipToCode
		  ,enq.ShipTo
		  ,enq.BillToCode
		  ,enq.BillToId As BillTo
		  ,(select l.LocationName from [Location] l where l.LocationCode = enq.BillToCode) As BillToName
		  ,(select c.CompanyName from [Company] c where c.CompanyMnemonic = enq.CompanyCode) As CompanyName
		  ,enq.CompanyCode As CompanyMnemonic
		  ,enq.CompanyCode
		  ,enq.CompanyId
		  ,(select cast ((SELECT 'true' AS [@json:Array] ,  enq.CompanyCode As CompanyMnemonic
				FOR XML path('Supplier'),ELEMENTS) AS xml))
		  ,(select cast ((SELECT 'true' AS [@json:Array] ,  enq.ShipToCode As LocationCode
				FOR XML path('DeliveryLocation'),ELEMENTS) AS xml))
		  ,enq.SoldTo
		  ,enq.PONumber
		  ,enq.SONumber
		  ,enq.CollectionLocationCode As CollectionCode
		  ,enq.Field8 As NoOfDays
		  ,enq.IsActive
		  ,ISNULL(enq.IsRecievingLocationCapacityExceed, 0) As IsRecievingLocationCapacityExceed
		  ,enq.TruckSizeId
		  ,enq.NumberOfPalettes
		  ,enq.PalletSpace
		  ,Replace(TRIM(CONVERT(varchar(12),enq.EnquiryDate,13)),' ','-') + ' ' + Replace(TRIM(CONVERT(varchar(20),enq.EnquiryDate,108)),' ','-') As OrderDate
		  ,-1 As CollectionDateFromSettingValue
		  ,Replace(TRIM(CONVERT(varchar(12),enq.RequestDate,13)),' ','-') + ' ' + Replace(TRIM(CONVERT(varchar(20),enq.RequestDate,108)),' ','-') As OrderProposedETD
		  ,enq.PreviousState
		  ,enq.CurrentState
		  ,1 As CurrentStateDraft
		  ,enq.CreatedBy
		  ,(select cast ((SELECT 'true' AS [@json:Array] 
				,enq.EnquiryGuid As OrderGUID
				,ep.[EnquiryProductId] As EnquiryProductId
				,i.ItemId
				,(select i1.ItemId from Item i1 where i1.ItemCode = ep.ProductCode) As ParentItemId
				,ep.ParentProductCode
				,0 As AssociatedOrder
				,ep.ProductName As ItemName
				,ISNULL((ep.UnitPrice),0) as ItemPricesPerUnit
				,ep.[ProductCode]
				,ep.UOM As PrimaryUnitOfMeasure
				,ep.[ProductQuantity]
				,ep.ProductType
				,0 As WeightPerUnit
				,ep.IsActive
				,0 As CurrentItemPalettesCorrectWeight
				,0 As CurrentItemTruckCapacityFullInTone
				,0 As PackingItemCount
				,0 As PackingItemCode
				,0 As IsPackingItem
				,0 As NumberOfExtraPalettes
				,1 As AllocationExcited
				,0 As AllocationQty
				,0.00 As DepositeAmountPerUnit
				,'' As CollectionCode
				,ep.[ItemType]
				from [EnquiryProduct] ep left join Item i on ep.ProductCode = i.ItemCode
				WHERE ep.IsActive = 1 AND ep.EnquiryId = enq.EnquiryId 
				FOR XML path('OrderProductList'),ELEMENTS) AS xml))
		 
		 ,enq.TotalAmount
		 ,enq.TotalQuantity
		 ,enq.TotalPrice
		 ,enq.TotalWeight
		 ,enq.TotalVolume
		 ,enq.TruckWeight
		 ,enq.TotalDepositeAmount
		 ,enq.TotalTaxAmount
		 ,enq.TotalDiscountAmount
		 ,enq.TotalAmount As totalorderamount
		 ,enq.TotalDepositeAmount As totalDepositeamount
		 ,(select cast ((SELECT 'true' AS [@json:Array]  
				,n.RoleId
				,n.ObjectId
				,n.ObjectType
				,n.Note
				,n.IsActive
				,n.CreatedBy
				from Notes n where n.ObjectType = 1220 and n.ObjectId = enq.RequestDate
				FOR XML path('NoteList'),ELEMENTS) AS xml))
		  ,1 As IsSynced
		  ,(SELECT [dbo].[fn_RoleWiseStatus] (@roleId,enq.CurrentState,@CultureId)) AS [Status]
		  ,(SELECT [dbo].[fn_RoleWiseClass] (@roleId,enq.CurrentState)) AS Class
		  from Enquiry enq WHERE enq.IsActive = 1 and enq.CurrentState not in (320,370) and enq.RequestDate is not null and (enq.SoldToCode =  @soldToCode  or @soldToCode = '')
		  order by  enq.RequestDate desc

		  FOR XML PATH('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)


END
