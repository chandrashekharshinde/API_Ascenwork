 
CREATE PROCEDURE [dbo].[ISP_CFRReport]
 
AS 
BEGIN 
	
	TRUNCATE TABLE [glassRUN-VBL_CFR]..CFRReport

	INSERT INTO [glassRUN-VBL_CFR]..[CFRReport]
           ([OrderId]
		   ,[Date]
           ,[Month]
           ,[Week]
           ,[BranchPlant]
           ,[Area]
           ,[Customer]
           ,[Carrier]
           ,[SalesOrderNumber]
           ,[PurchaseOrderNumber]
           ,[Remarks]
           ,[ItemCode]
           ,[ItemName]
           ,[ProductQuantity]
           ,[RevisedQuantity]
           ,[CasesNotAvailable]
           ,[PA_Percentage]
           ,[ReasonCodePreferToCSPortal]
           ,[CasesNotDeliverInFull]
           ,[ReasonCodePreferToCustomerFeedback]
           ,[IF_Percentage]
           ,[OrderDate]
           ,[ApprovalDate]
           ,[RequestDate]
           ,[PromisedDate]
           ,[ReasonCodeWarehousePortal]
           ,[ETD]
           ,[ActualDeliveryDate]
           ,[ETA]
           ,[CasesNotDeliveryOnTime]
           ,[OT_Percentage]
           ,[ReasonCode]
           ,[ActualReceiveDate]
           ,[CFR_Percentage]
           ,[ConfirmedTruckPlate]
           ,[ConfirmedDriver]
           ,[TruckInTruckOutPlateNumber]
           ,[TruckInTruckOutDriver]
           ,[TruckInDataTime]
           ,[TruckOutDataTime]
		   ,[OrderCreatedDate]
		   ,[OrderModifiedDate])

		   select OrderId,[Date]
,[Month]
,[Week]
,BranchPlant
,Area
,Customer
,Carrier
,SalesOrderNumber
,PurchaseOrderNumber
,Remarks
,ItemCode
,ItemName
,OriginalProductQuantity As ProductQuantity
,OriginalProductQuantity AS RevisedQuantity
,CASE WHEN OriginalProductQuantity > OriginalRevisedQuantity
		THEN 0 ELSE Floor(ISNULL((OriginalRevisedQuantity-OriginalProductQuantity),0)) END AS CasesNotAvailable

--,Floor(ISNULL((ProductQuantity-RevisedQuantity),0)) as CasesNotAvailable
,ROUND(CAST(((1-((CASE WHEN OriginalProductQuantity > OriginalRevisedQuantity
		THEN 0 ELSE Floor(ISNULL((OriginalRevisedQuantity-OriginalProductQuantity),0)) END)/(Case when ISNULL(OriginalRevisedQuantity,0) != 0 then OriginalRevisedQuantity 
	ELSE OriginalProductQuantity END)))*100) As Decimal(18,2)), 1) as PA_Percentage
,ReasonCodePreferToCSPortal
,Floor(ISNULL(ReturnQuantity,0))  as CasesNotDeliverInFull
,CustomerFeedback as ReasonCodePreferToCustomerFeedback
--,Case when ISNULL(ReturnQuantity,0) != 0 then ROUND(CAST(((1-(ReturnQuantity/ISNULL(RevisedQuantity,ProductQuantity)))*100) As Decimal(18,2)),0) ELSE 0 END As IF_Percentage
,ROUND(CAST(((1-(ISNULL(ReturnQuantity,0)/OriginalProductQuantity))*100) As Decimal(18,2)),1) As IF_Percentage --Changed By Chetan Tambe (26 Sept 2019)
--,Case when ISNULL(ReturnQuantity,0) != 0 then 
--ROUND(CAST(((1-(ReturnQuantity/OriginalProductQuantity))*100) As Decimal(18,2)),0) ELSE 0 END As IF_Percentage
,OrderDate
,ApprovalDate
,RequestDate
,PromisedDate
,ReasonCodeWarehousePortal
,ETD
,ActualDeliveryDate
,DateAdd(day, CONVERT(int,LeadTime), ActualDeliveryDate) As ETA

,case when CustomerFeedbackCasesnotDeliveryOnTime is null 
	then Case when Convert(date,convert(datetime,isnull(ActualDeliveryDate,'1900-01-01')))<=Convert(date,convert(datetime,ETD)) 
				then 0 
				else OriginalProductQuantity end 
	else OriginalProductQuantity end as CasesNotDeliveryOnTime

,CASE WHEN (case when CustomerFeedbackCasesnotDeliveryOnTime is null 
	then Case when Convert(date,convert(datetime,isnull(ActualDeliveryDate,'1900-01-01')))<=Convert(date,convert(datetime,ETD)) 
				then 0 
				else OriginalProductQuantity end 
	else OriginalProductQuantity end) > 0 THEN 0 ELSE 100.00 END AS OT_Percentage
,CustomerFeedbackCasesnotDeliveryOnTime AS ReasonCode
,ActualTimeOfAction As ActualReceiveDate

,CASE WHEN (case when CustomerFeedbackCasesnotDeliveryOnTime is null 
	then Case when Convert(date,convert(datetime,isnull(ActualDeliveryDate,'1900-01-01')))<=Convert(date,convert(datetime,ETD)) 
				then 0 
				else OriginalProductQuantity end 
	else OriginalProductQuantity END) = OriginalProductQuantity
THEN 0 ELSE ROUND(Convert(Decimal(18,2), ((1 - ((case when CustomerFeedbackCasesnotDeliveryOnTime is null 
	THEN (CASE WHEN OriginalProductQuantity > OriginalRevisedQuantity
		THEN 0 ELSE Floor(ISNULL((OriginalRevisedQuantity-OriginalProductQuantity),0)) + Floor(ISNULL(ReturnQuantity,0)) END) ELSE 0 END) * 1.0
		/ (CASE WHEN OriginalRevisedQuantity = 0 THEN OriginalProductQuantity ELSE OriginalRevisedQuantity END))) * 100)),1) END  as CFR_Percentage --Changed By Chetan Tambe (26 Sept 2019)
		
--,Convert(Decimal(18,2), ((1 - ((case when CustomerFeedbackCasesnotDeliveryOnTime is null 
--	THEN (CASE WHEN OriginalProductQuantity > OriginalRevisedQuantity
--		THEN 0 ELSE Floor(ISNULL((OriginalRevisedQuantity-OriginalProductQuantity),0)) + Floor(ISNULL(ReturnQuantity,0)) END) ELSE 0 END)
--		/ OriginalRevisedQuantity)) * 100))  as CFR_Percentage

--,Convert(Decimal(18,2),(1 - (OriginalProductQuantity
-- +  case when CustomerFeedbackCasesnotDeliveryOnTime is null 
--	then Case when Convert(date,convert(datetime,isnull(ActualDeliveryDate,'1900-01-01')))<=Convert(date,convert(datetime,ETD)) 
--	then 0 else OriginalProductQuantity end 
--	else OriginalProductQuantity end + Case when CustomerFeedbackCasesnotDeliveryOnTime is null 
--	then Floor(ISNULL(ReturnQuantity,0)) else 0 end) / OriginalProductQuantity) * 100) as CFR_Percentage

,ConfirmedTruckPlate
,ConfirmedDriver
,TruckInTruckOutPlateNumber
,TruckInTruckOutDriver
,TruckInDataTime
,TruckOutDataTime
,OrderCreatedDate
,OrderModifiedDate

from (
select ROW_NUMBER() OVER (ORDER BY ISNULL(o.ModifiedDate,o.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,o.OrderId,
	datepart(DAY, o.OrderDate) as [Date],   
	 datepart(MM, o.OrderDate) as [Month], 
	 datepart(WK, o.OrderDate) as [Week], 
  sl.LocationName as BranchPlant,
  a.Area as Area,
  cs.CompanyName as Customer,
  cr.CompanyMnemonic as Carrier,
  o.OrderNumber as SalesOrderNumber,
  o.PurchaseOrderNumber As PurchaseOrderNumber,
  o.Remarks As Remarks,
  i.ItemCode as ItemCode,
  i.ItemName as ItemName,

--  Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
--then (select Top 1 CAST(ProductQuantity AS decimal(18,2)) from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc)
----else CAST(op.ProductQuantity AS decimal(18,2))  end as ProductQuantity,
--else (select Top 1 CAST(ProductQuantity AS decimal(18,2)) from EnquiryProduct where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId) end as ProductQuantity,

--Case when 
--(Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
--then op.ProductQuantity  end) > (Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
--then (select Top 1 CAST(ProductQuantity AS decimal(18,2)) from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc)
--else (select Top 1 CAST(ProductQuantity AS decimal(18,2)) from EnquiryProduct where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId)  end) then '0' else (Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
--then (select Top 1 CAST(ProductQuantity AS decimal(18,2)) from EnquiryProduct where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId)  end) end as RevisedQuantity,

(select Top 1 CAST(ProductQuantity AS decimal(18,2)) from EnquiryProduct where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId) As OriginalProductQuantity,

Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
then (select Top 1 CAST(ProductQuantity AS decimal(18,2)) from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc)
else 0 end As OriginalRevisedQuantity,

--CAST(op.ProductQuantity AS decimal(18,2)) as OriginalProductQuantity,
(select [Name] from LookUp where LookupId in (select top 1 ReasonCodeId from ReasonCodeObjectMapping where EventName = 'EditEnquiry' and ObjectId = o.EnquiryId order by CreatedDate desc)) as ReasonCodePreferToCSPortal
,(Select [Name] from lookup where lookupid in (select top 1 orf.feedbackid from OrderFeedback orf where orf.OrderId = o.OrderId
and  orf.feedbackId in (1501) and ISNULL(orf.ParentOrderFeedbackReplyId,0) = 0 order by CreatedDate desc)) as CustomerFeedbackCasesnotDeliveryOnTime
,ISNULL((select top 1 CAST(orf.Quantity AS decimal(18,2)) from OrderFeedback orf where orf.OrderId = o.OrderId and orf.OrderProductId = op.OrderproductId 
and  orf.feedbackId in (1502,1503) and ISNULL(orf.ParentOrderFeedbackReplyId,0) = 0 order by CreatedDate desc),0) As ReturnQuantity
,(Select [Name] from lookup where lookupid in (select top 1 orf.feedbackId from OrderFeedback orf where orf.OrderId = o.OrderId and orf.OrderProductId = op.OrderproductId 
and  orf.Field1 in (select LookUpId from LookUp where LookupCategory = 14 and ParentId in (1502,1503)) and ISNULL(orf.ParentOrderFeedbackReplyId,0) = 0 order by CreatedDate desc)) as CustomerFeedback
,(select top 1 EnquiryDate from Enquiry where EnquiryId=o.EnquiryId) as OrderDate
,o.OrderDate As ApprovalDate
,(select top 1 RequestDate from Enquiry where EnquiryId=o.EnquiryId) as RequestDate
,o.ExpectedTimeOfDelivery as PromisedDate
,(select [Name] from LookUp where LookupId in (select top 1 ReasonCodeId from ReasonCodeObjectMapping where EventName='UpdateRequestDate' and ObjectType = 'Order' and ObjectId = o.OrderId order by CreatedDate desc)) as ReasonCodeWarehousePortal
,o.PickDateTime As ETD
,tio.TruckOutDataTime As ActualDeliveryDate
,om1.ActualTimeOfAction
,(SELECT top 1 TruckPlateNumber FROM orderlogistics WHERE ordermovementid IN (om.ordermovementid)) AS ConfirmedTruckPlate
,ISNULL(lo1.[Name],'') as ConfirmedDriver
,ISNULL(tio.PlateNumber,'') As TruckInTruckOutPlateNumber
,ISNULL(lo.[Name],'') as TruckInTruckOutDriver
,tio.TruckInDataTime
,tio.TruckOutDataTime
,ISNULL((Select top 1 REPLACE(Field8, '''', '') from Enquiry where EnquiryId=o.EnquiryId),0) as LeadTime
,o.CreatedDate As OrderCreatedDate
,o.ModifiedDate As OrderModifiedDate
 from OrderProduct op
JOIN [Order] o ON o.OrderId = op.OrderId
Left JOIN [Location] sl ON o.StockLocationId = sl.LocationCode
Left JOIN [Location] a ON o.ShipTo = a.LocationId
Left JOIN [Company] cs ON o.SoldTo = cs.CompanyId
Left JOIN [Company] cr ON o.CarrierNumber = cr.CompanyId
Left JOIN [OrderMovement] om ON o.OrderId = om.OrderId and om.LocationType = 1
Left JOIN [Login] lo1 ON om.DeliveryPersonnelId = lo1.LoginId
Left JOIN [OrderMovement] om1 ON o.OrderId = om1.OrderId and om1.LocationType = 2
INNER JOIN [Item] i ON op.ProductCode = i.ItemCode
LEFT JOIN [TruckInOrder] tio ON o.OrderNumber = tio.OrderNumber
LEFT JOIN [TruckInDeatils] tid ON tio.TruckInDeatilsId = tid.TruckInDeatilsId
Left JOIN [Login] lo ON tid.DriverId = lo.LoginId
where op.ProductCode not in (select ProductCode from EnquiryProduct where ISNULL(IsPackingItem,0) = 1)
and op.ProductCode<>65999001 and o.SalesOrderNumber is not null and op.ItemType=32 --Added By Chetan Tambe (26 Sept 2019)
and o.OrderType = 'SO'--Added By Chetan Tambe (26 Sept 2019)
and o.CurrentState not in (34)
--and ISNULL(convert(date,o.ModifiedDate),convert(date,o.CreatedDate)) > 
--isnull(convert(date,(select Max(OrderModifiedDate) from [glassRUN-VBL_CFR]..CFRReport)),isnull(convert(date,(select Max(OrderCreatedDate) from [glassRUN-VBL_CFR]..CFRReport)),'1900-01-01'))
--and o.ModifiedDate is null
--and (o.ShipTO in (284) or 284='') and 1=1
--and o.OrderNumber = 'T027235'
) tmp
ORDER BY OrderId desc

		   
--select OrderId,[Date]
--,[Month]
--,[Week]
--,BranchPlant
--,Area
--,Customer
--,Carrier
--,SalesOrderNumber
--,PurchaseOrderNumber
--,Remarks
--,ItemCode
--,ItemName
--,ProductQuantity
--,Floor(ISNULL(RevisedQuantity,ProductQuantity)) as RevisedQuantity
--,Floor(ISNULL((OriginalProductQuantity-RevisedQuantity),0)) as CasesNotAvailable
--,Floor((1-(ISNULL((OriginalProductQuantity-RevisedQuantity),0)/OriginalProductQuantity))*100) as PA_Percentage
--,ReasonCodePreferToCSPortal
--,Floor(ISNULL(ReturnQuantity,0))  as CasesNotDeliverInFull
--,CustomerFeedback as ReasonCodePreferToCustomerFeedback
--,Case when ISNULL(ReturnQuantity,0) != 0 then ROUND(CAST(((1-(ReturnQuantity/ISNULL(RevisedQuantity,ProductQuantity)))*100) As Decimal(18,2)),0) ELSE 0 END As IF_Percentage
--,OrderDate
--,ApprovalDate
--,RequestDate
--,PromisedDate
--,ReasonCodeWarehousePortal
--,ETD
--,ActualDeliveryDate
--,DateAdd(day, CONVERT(int,LeadTime), ActualDeliveryDate) As ETA

--,case when CustomerFeedbackCasesnotDeliveryOnTime is null 
--	then Case when Convert(date,convert(datetime,isnull(ActualDeliveryDate,'1900-01-01')))<=Convert(date,convert(datetime,ETD)) 
--				then 0 
--				else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end 
--	else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end as CasesNotDeliveryOnTime
--,CASE WHEN (case when CustomerFeedbackCasesnotDeliveryOnTime is null 
--	then Case when Convert(date,convert(datetime,isnull(ActualDeliveryDate,'1900-01-01')))<=Convert(date,convert(datetime,ETD)) 
--				then 0 
--				else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end 
--	else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end) > 0 THEN 0 ELSE 100.00 END AS OT_Percentage
--,CustomerFeedbackCasesnotDeliveryOnTime AS ReasonCode
--,ActualTimeOfAction As ActualReceiveDate
--,Convert(Decimal(18,2),(1 - (Floor(ISNULL((ProductQuantity-RevisedQuantity),0)) +  case when CustomerFeedbackCasesnotDeliveryOnTime is null 
--	then Case when Convert(date,convert(datetime,isnull(ActualDeliveryDate,'1900-01-01')))<=Convert(date,convert(datetime,ETD)) 
--	then 0 else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end else Floor(ISNULL(RevisedQuantity,ProductQuantity)) end + Case when CustomerFeedbackCasesnotDeliveryOnTime is null 
--	then Floor(ISNULL(ReturnQuantity,0)) else 0 end) / OriginalProductQuantity) * 100)  as CFR_Percentage
--,ConfirmedTruckPlate
--,ConfirmedDriver
--,TruckInTruckOutPlateNumber
--,TruckInTruckOutDriver
--,TruckInDataTime
--,TruckOutDataTime
--,OrderCreatedDate
--,OrderModifiedDate

--from (
--select ROW_NUMBER() OVER (ORDER BY ISNULL(o.ModifiedDate,o.CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,o.OrderId,
--	datepart(DAY, o.OrderDate) as [Date],   
--	 datepart(MM, o.OrderDate) as [Month], 
--	 datepart(WK, o.OrderDate) as [Week], 
--  sl.LocationName as BranchPlant,
--  a.Area as Area,
--  cs.CompanyName as Customer,
--  cr.CompanyMnemonic as Carrier,
--  o.OrderNumber as SalesOrderNumber,
--  o.PurchaseOrderNumber As PurchaseOrderNumber,
--  o.Remarks As Remarks,
--  i.ItemCode as ItemCode,
--  i.ItemName as ItemName,
--  Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
--then (select Top 1 CAST(ProductQuantity AS decimal(18,2)) from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc)
--else CAST(op.ProductQuantity AS decimal(18,2))  end as ProductQuantity,
--Case when 
--(Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
--then op.ProductQuantity  end) > (Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
--then (select Top 1 CAST(ProductQuantity AS decimal(18,2)) from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc)
--else CAST(op.ProductQuantity AS decimal(18,2))  end) then '0' else (Case when (select Top 1 ProductQuantity from EnquiryProductHistory where ProductCode=op.ProductCode and EnquiryId=o.EnquiryId order by EnquiryProductHistoryId desc) is not null
--then CAST(op.ProductQuantity AS decimal(18,2))  end) end as RevisedQuantity,
--CAST(op.ProductQuantity AS decimal(18,2)) as OriginalProductQuantity,
--(select [Name] from LookUp where LookupId in (select top 1 ReasonCodeId from ReasonCodeObjectMapping where EventName = 'EditEnquiry' and ObjectId = o.EnquiryId order by CreatedDate desc)) as ReasonCodePreferToCSPortal
--,(Select [Name] from lookup where lookupid in (select top 1 orf.feedbackid from OrderFeedback orf where orf.OrderId = o.OrderId
--and  orf.feedbackId in (1501) and ISNULL(orf.ParentOrderFeedbackReplyId,0) = 0 order by CreatedDate desc)) as CustomerFeedbackCasesnotDeliveryOnTime
--,ISNULL((select top 1 CAST(orf.Quantity AS decimal(18,2)) from OrderFeedback orf where orf.OrderId = o.OrderId and orf.OrderProductId = op.OrderproductId 
--and  orf.feedbackId in (1502,1503) and ISNULL(orf.ParentOrderFeedbackReplyId,0) = 0 order by CreatedDate desc),0) As ReturnQuantity
--,(Select [Name] from lookup where lookupid in (select top 1 orf.Field1 from OrderFeedback orf where orf.OrderId = o.OrderId and orf.OrderProductId = op.OrderproductId 
--and  orf.Field1 in (select LookUpId from LookUp where LookupCategory = 14 and ParentId in (1502,1503)) and ISNULL(orf.ParentOrderFeedbackReplyId,0) = 0 order by CreatedDate desc)) as CustomerFeedback
--,(select top 1 EnquiryDate from Enquiry where EnquiryId=o.EnquiryId) as OrderDate
--,o.OrderDate As ApprovalDate
--,(select top 1 RequestDate from Enquiry where EnquiryId=o.EnquiryId) as RequestDate
--,o.ExpectedTimeOfDelivery as PromisedDate
--,(select [Name] from LookUp where LookupId in (select top 1 ReasonCodeId from ReasonCodeObjectMapping where EventName='UpdateRequestDate' order by CreatedDate desc)) as ReasonCodeWarehousePortal
--,o.PickDateTime As ETD
--,tio.TruckOutDataTime As ActualDeliveryDate
--,om1.ActualTimeOfAction
--,(SELECT top 1 TruckPlateNumber FROM orderlogistics WHERE ordermovementid IN (om.ordermovementid)) AS ConfirmedTruckPlate
--,ISNULL(lo1.[Name],'') as ConfirmedDriver
--,ISNULL(tio.PlateNumber,'') As TruckInTruckOutPlateNumber
--,ISNULL(lo.[Name],'') as TruckInTruckOutDriver
--,tio.TruckInDataTime
--,tio.TruckOutDataTime
--,ISNULL((Select top 1 REPLACE(Field8, '''', '') from Enquiry where EnquiryId=o.EnquiryId),0) as LeadTime
--,o.CreatedDate As OrderCreatedDate
--,o.ModifiedDate As OrderModifiedDate
-- from OrderProduct op
--JOIN [Order] o ON o.OrderId = op.OrderId
--Left JOIN [Location] sl ON o.StockLocationId = sl.LocationCode
--Left JOIN [Location] a ON o.ShipTo = a.LocationId
--Left JOIN [Company] cs ON o.SoldTo = cs.CompanyId
--Left JOIN [Company] cr ON o.CarrierNumber = cr.CompanyId
--Left JOIN [OrderMovement] om ON o.OrderId = om.OrderId and om.LocationType = 1
--Left JOIN [Login] lo1 ON om.DeliveryPersonnelId = lo1.LoginId
--Left JOIN [OrderMovement] om1 ON o.OrderId = om1.OrderId and om1.LocationType = 2
--INNER JOIN [Item] i ON op.ProductCode = i.ItemCode
--LEFT JOIN [TruckInOrder] tio ON o.OrderNumber = tio.OrderNumber
--LEFT JOIN [TruckInDeatils] tid ON tio.TruckInDeatilsId = tid.TruckInDeatilsId
--Left JOIN [Login] lo ON tid.DriverId = lo.LoginId
--where op.ProductCode not in (select ProductCode from EnquiryProduct where ISNULL(IsPackingItem,0) = 1)
--and op.ProductCode<>65999001 and o.SalesOrderNumber is not null and op.ItemType<>31
--and o.CurrentState not in (34) 
----and ISNULL(convert(date,o.ModifiedDate),convert(date,o.CreatedDate)) > 
----isnull(convert(date,(select Max(OrderModifiedDate) from [glassRUN-VBL_CFR]..CFRReport)),isnull(convert(date,(select Max(OrderCreatedDate) from [glassRUN-VBL_CFR]..CFRReport)),'1900-01-01'))
----and o.ModifiedDate is null
----and (o.ShipTO in (284) or 284='') and 1=1
--) tmp
--ORDER BY OrderId desc


END


