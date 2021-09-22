

CREATE PROCEDURE [dbo].[SSP_SearchEnquiryDetailsV2] --4,0,50,'SalesAdminApproval','Enquiry',574,''
	
	@RoleId bigint,
	@PageIndex int,
	@PageSize int,
	@PageName NVARCHAR(150),
	@PageControlName NVARCHAR(150),
	@LoginId BIGINT,
	@whereClause NVARCHAR(max)='1=1'

AS

BEGIN

DECLARE  @xmlDoc XML
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
DECLARE @sql1 nvarchar(max)
DECLARE @sql2 nvarchar(max)
DECLARE @sql3 nvarchar(max)
Declare @username nvarchar(max)
Declare @RoleIdNvarchar nvarchar(10)
Declare @PageIndexNvarchar nvarchar(10)
Declare @PageSizeNvarchar nvarchar(10)
--DECLARE @whereClause NVARCHAR(max)

--set @whereClause='1=1'

SET @whereClause = '1=1' + @whereClause + '' + (
			SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause](@LoginId, @PageName, @PageControlName)
			) + ''

	IF @RoleId = 4
	BEGIN
		PRINT @RoleId

		SET @whereClause = @whereClause + ' and (enq.SoldTo in (Select ReferenceId from Login where Loginid= ' + CONVERT(NVARCHAR(10), @LoginId) + 
			') or enq.CompanyId in (Select ReferenceId from Login where Loginid= ' + CONVERT(NVARCHAR(10), @LoginId) + '))'
	END


set @RoleIdNvarchar=CONVERT(nvarchar(30),@RoleId)
set @PageIndexNvarchar=CONVERT(nvarchar(30),(@PageIndex*@PageSize))
set @PageSizeNvarchar=CONVERT(nvarchar(30),@PageSize)

set @sql='WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)
,EnquiryMainCTE
AS (
SELECT 0 as CheckedEnquiry,
	 enq.EnquiryGuid as OrderGUID, enq.[EnquiryId], enq.[EnquiryAutoNumber], enq.[PickDateTime], enq.[PromisedDate]
	, enq.[EnquiryType], '''' as IsOrderSelfCollect, enq.EnquiryDate as ActivityStartTime, enq.[EnquiryDate], enq.[RequestDate], enq.[ShipTo], enq.[ShipToCode],
	enq.[ShipToName],enq. BillToId as BillTo, [BillToCode], '''' as BillToName , enq.[SoldTo], enq.[SoldToCode], enq.SoldToName, enq.[CompanyId], 
	enq.[CompanyCode],  cp.CompanyName, enq.CarrierId, enq.[CarrierCode], enq.[CarrierName], 0 CollectionLocationId,
	enq.[CollectionLocationCode], cl.LocationName As CollectionLocationName
	,LTRIM(RTRIM(SUBSTRING(enq.SoldToName, 0, CHARINDEX(''-'', enq.SoldToName)))) as ShortName
	, enq.[PreSellerCode], enq.[PreSellerName], enq.[TruckSizeId], 
	tz.TruckSize, enq.[PONumber], enq.[SONumber], enq.Field8 as NoOfDays, enq.[IsActive], ISNULL(enq.[IsRecievingLocationCapacityExceed], 0) As [IsRecievingLocationCapacityExceed],
	enq.[OrderProposedETD], enq.[PreviousState], enq.[CurrentState], enq.[NumberOfPalettes], enq.[PalletSpace],
	enq.[TotalAmount], enq.[TotalQuantity], 
	enq.TotalPrice,
	format(ISNULL(enq.TotalPrice,0), N''C'', (select SettingValue from SettingMaster where SettingParameter = ''CurrencyCultureCode'')) As TotalPriceWithCurreny, 
	enq.[TotalWeight], 
	enq.[TotalVolume], enq.[TruckWeight], enq.[TotalDepositeAmount], enq.[TotalTaxAmount], enq.[TotalDiscountAmount], enq.TotalAmount as TotalOrderAmount,
	enq.[Field1], enq.[Field2], enq.[Field3], enq.[Field4], enq.[Field5], enq.[Field6], enq.[Field7], enq.[Field8], enq.[Field9], enq.[Field10]
	,(Case When (Select Count(*) from ReturnPakageMaterialView where ReturnPakageMaterialView.EnquiryId = enq.EnquiryId) > 0 then ''1'' else ''0'' end) as RPMValue
	,c.EmptiesLimit as EmptiesLimit,
	c.ActualEmpties as ActualEmpties,
	case when (c.ActualEmpties < 0) then ''C'' else ''W'' end as Empties,
	ISNULL(d.Area,''-'') as Area,
	zc.ZoneName,
	ISNULL(CONVERT(bigint,d.Capacity),0) As Capacity,
	(SELECT 
       (Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep  with (nolock) where EnquiryId = enq.EnquiryId and isactive=1 and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
) ) as AssociatedOrder, enq.CreatedDate
	from enquiry enq
	Left join Location cl with (nolock) on enq.CollectionLocationCode = cl.LocationCode
	LEFT join TruckSize tz with (nolock) on enq.[TruckSizeId] = tz.TruckSizeId
	left join Company c with (nolock) on c.CompanyId = enq.SoldTo
	left join [Location] d  with (nolock) on enq.ShipTo = d.LocationId
	left join ZoneCode zc on zc.CompanyId=enq.SoldTo
	left join Company cp with (nolock) on cp.CompanyId = c.CompanyId
	  where '+ @whereClause +' and enq.IsActive=1
	ORDER BY enq.[EnquiryId] DESC 
	OFFSET ('+@PageIndexNvarchar+') ROWS
	FETCH NEXT '+@PageSizeNvarchar+' ROWS ONLY
),
	EnquiryPallateCTE (ShipTo, SoldTo, RequestDate, EnquiryTotalPalettes)
	AS (
		select enq.ShipTo, enq.SoldTo, CONVERT(date,enq.RequestDate) As RequestDate, isnull(sum(enq.NumberOfPalettes),0) As EnquiryTotalPalettes from Enquiry enq with (nolock)
		where enq.CurrentState = 1
		group by enq.ShipTo, enq.SoldTo, enq.RequestDate
	)
	,
	OrderPallateCTE (ShipTo, SoldTo, RequestDate, OrderTotalPalettes)
	AS (
		select ord.ShipTo, ord.SoldTo, CONVERT(date,ord.ExpectedTimeOfDelivery) As RequestDate, isnull(sum(ord.NumberOfPalettes),0) As OrderTotalPalettes from [Order] ord with (nolock)
		group by ord.ShipTo, ord.SoldTo, ord.ExpectedTimeOfDelivery
	)'

	set @sql3 = ',EnquiryProductCTE
	AS (
		
		select ep.EnquiryProductId, ep.EnquiryId, ep.ProductCode, ep.ProductQuantity, ISNULL(EnquiryMainCTE.[CollectionLocationCode],'''') As [CollectionLocationCode], EnquiryMainCTE.CreatedDate from EnquiryProduct ep with (nolock)
		INNER JOIN EnquiryMainCTE ON EnquiryMainCTE.EnquiryId = ep.EnquiryId
		WHERE ISNULL(ep.IsPackingItem,0) =0
		and ep.ItemType !=30

	),
	ItemStockCTE
	AS (
		
		select ist.ItemCode, ist.DeliveryLocationCode, SUM(ist.ItemQuantity) As ItemQuantity from ItemStock ist with (nolock)
		INNER JOIN EnquiryProductCTE ON EnquiryProductCTE.ProductCode = ist.ItemCode
		where ist.LocationCode in (''F'',''F2'')
		and ist.DeliveryLocationCode in (ISNULL(EnquiryProductCTE.[CollectionLocationCode],''''),''07'' + SUBSTRING(ISNULL(EnquiryProductCTE.[CollectionLocationCode],''''),Len(ISNULL(EnquiryProductCTE.[CollectionLocationCode],''''))-1,2))
		group by ist.ItemCode, ist.DeliveryLocationCode

	),
	WaitingForApprovalEnquiryCTE
	AS (
			
		select e.EnquiryId, ep1.ProductCode, e.[CollectionLocationCode], e.CreatedDate, ep1.ProductQuantity as ProductQuantity
		from Enquiry e with (nolock)
		left join EnquiryProduct ep1 with (nolock) 
		on e.EnquiryId = ep1.EnquiryId
		where e.CurrentState = 1 and e.[StockLocationId] is not null
		
	),
	AvailableStockCTE
	AS (

		select epc.ProductQuantity
		, (ISNULL((select sum(ItemQuantity) from ItemStockCTE ist where ist.ItemCode in (epc.ProductCode)
	and ist.DeliveryLocationCode in (ISNULL(epc.[CollectionLocationCode],''''),''07'' + SUBSTRING(ISNULL(epc.[CollectionLocationCode],''''),Len(ISNULL(epc.[CollectionLocationCode],''''))-1,2))),0)) As AvailableProductQty,
	ISNULL((select Sum(wfa.ProductQuantity) from WaitingForApprovalEnquiryCTE wfa 
			where wfa.ProductCode = epc.ProductCode and wfa.[CollectionLocationCode] = epc.[CollectionLocationCode]
			and wfa.CreatedDate < epc.CreatedDate),0) As UsedProductQty,
			epc.EnquiryId
		 from EnquiryProductCTE epc

	),
	AvailableStockMainCTE
	As (
		
		select EnquiryId, case when ProductQuantity >  Cast(ISNULL(AvailableProductQty - UsedProductQty,0) As decimal) Then 0 else 1 end as pending
		from AvailableStockCTE

	)'

	set @sql1 = 'select cast ((SELECT ''true'' AS [@json:Array] , EnquiryMainCTE.*, 
	CAST(((ISNULL(EnquiryMainCTE.Capacity,0))-(ISNULL(EnquiryPallateCTE.EnquiryTotalPalettes,0)+ISNULL(OrderPallateCTE.OrderTotalPalettes,0))) As bigint) As ReceivedCapacityPalettes
	,case when (select count(1) from AvailableStockMainCTE ast where ast.EnquiryId = EnquiryMainCTE.EnquiryId and ast.pending=0) != 0 then 0 else 1 end As IsAvailableStock
	 ,(select cast ((SELECT ''true'' AS [@json:Array] 
		,EnquiryMainCTE.OrderGUID, [EnquiryProductId], ItemId, ParentItemId, ep.[ParentProductCode], ep.[AssociatedOrder],
		ep.ProductName , ep.UnitPrice as ItemPricesPerUnit,ep.[ProductCode], ep.UOM as PrimaryUnitOfMeasure, ep.[ProductQuantity], ep.[ProductType],
		0 as WeightPerUnit, ep.[IsActive], ep.[ItemType], 0 as CurrentItemPalettesCorrectWeight, 0 as CurrentItemTruckCapacityFullInTon, 
		ep.[PackingItemCount], ep.[PackingItemCode], ISNULL(ep.[IsPackingItem],0) AS IsPackingItem, 0 as NumberOfExtraPalettes, 0 as DepositeAmountPerUnit,
		ep.[CollectionLocationCode], 0 as AllocationExists, 0 as AllocationQty, ep.CreatedDate from [EnquiryProduct] ep
		WHERE ep.IsActive = 1 AND ep.EnquiryId = EnquiryMainCTE.EnquiryId 
	   FOR XML path(''ProductList''),ELEMENTS) AS xml))
	   ,(select cast ((SELECT ''true'' AS [@json:Array]  
			,n.RoleId
			,n.ObjectId
			,n.ObjectType
			,n.Note
			,n.IsActive
			,n.CreatedBy
			from Notes n 
			inner join NotesRoleWiseConfiguration nc ON nc.RoleId = n.RoleId and nc.ObjectType = 1220
			where n.ObjectType =1220 
			and n.ObjectId = EnquiryMainCTE.EnquiryId  and nc.ViewNotesByRoleId = '+@RoleIdNvarchar+'
			FOR XML path(''NoteList''),ELEMENTS) AS xml))
	 
	 from EnquiryMainCTE
	 LEFT JOIN EnquiryPallateCTE
	ON EnquiryMainCTE.ShipTo = EnquiryPallateCTE.ShipTo
	AND EnquiryMainCTE.SoldTo = EnquiryPallateCTE.SoldTo
	AND EnquiryMainCTE.RequestDate = EnquiryPallateCTE.RequestDate
	LEFT JOIN OrderPallateCTE
	ON EnquiryPallateCTE.ShipTo = OrderPallateCTE.ShipTo
	AND EnquiryPallateCTE.SoldTo = OrderPallateCTE.SoldTo
	AND EnquiryPallateCTE.RequestDate = OrderPallateCTE.RequestDate

	FOR XML PATH(''EnquiryList''),ELEMENTS,ROOT(''Enquiry'')) AS XML);'

--   set @sql=' WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT ''true'' AS [@json:Array] , 0 as CheckedEnquiry,
--	 enq.EnquiryGuid as OrderGUID, enq.[EnquiryId], enq.[EnquiryAutoNumber], enq.[PickDateTime], enq.[PromisedDate]
--	, enq.[EnquiryType], '''' as IsOrderSelfCollect, enq.EnquiryDate as ActivityStartTime, enq.[EnquiryDate], enq.[RequestDate], enq.[ShipTo], enq.[ShipToCode],
--	enq.[ShipToName],enq. BillToId as BillTo, [BillToCode], '''' as BillToName , enq.[SoldTo], enq.[SoldToCode], enq.SoldToName, enq.[CompanyId], 
--	enq.[CompanyCode],  cp.CompanyName, enq.CarrierId, enq.[CarrierCode], enq.[CarrierName], 0 CollectionLocationId,
--	enq.[CollectionLocationCode], cl.LocationName As CollectionLocationName
--	,LTRIM(RTRIM(SUBSTRING(enq.SoldToName, 0, CHARINDEX(''-'', enq.SoldToName)))) as ShortName
--	, enq.[PreSellerCode], enq.[PreSellerName], enq.[TruckSizeId], 
--	tz.TruckSize, enq.[PONumber], enq.[SONumber], enq.Field8 as NoOfDays, enq.[IsActive], ISNULL(enq.[IsRecievingLocationCapacityExceed], 0) As [IsRecievingLocationCapacityExceed],
--	enq.[OrderProposedETD], enq.[PreviousState], enq.[CurrentState], enq.[NumberOfPalettes], enq.[PalletSpace],
--	enq.[TotalAmount], enq.[TotalQuantity], 
--	enq.TotalPrice,
--	format(ISNULL(enq.TotalPrice,0), N''C'', (select SettingValue from SettingMaster where SettingParameter = ''CurrencyCultureCode'')) As TotalPriceWithCurreny, 
--	enq.[TotalWeight], 
--	enq.[TotalVolume], enq.[TruckWeight], enq.[TotalDepositeAmount], enq.[TotalTaxAmount], enq.[TotalDiscountAmount], enq.TotalAmount as TotalOrderAmount,
--	enq.[Field1], enq.[Field2], enq.[Field3], enq.[Field4], enq.[Field5], enq.[Field6], enq.[Field7], enq.[Field8], enq.[Field9], enq.[Field10]
--	,(Case When (Select Count(*) from ReturnPakageMaterialView where ReturnPakageMaterialView.EnquiryId = enq.EnquiryId) > 0 then ''1'' else ''0'' end) as RPMValue
--	,c.EmptiesLimit as EmptiesLimit,
--	c.ActualEmpties as ActualEmpties,
--	case when (c.ActualEmpties < 0) then ''C'' else ''W'' end as Empties,
--	--((SELECT [dbo].[fn_GetTotalRecivingCapacityPalettes] (ISNULL(enq.RequestDate,enq.OrderProposedETD),enq.ShipTo,enq.SoldTo,ISNULL(CONVERT(bigint,d.Capacity),0)))) as ReceivedCapacityPalettes,
--	ISNULL(d.Area,''-'') as Area,
--	zc.ZoneName,
--	ISNULL(CONVERT(bigint,d.Capacity),0) As Capacity,
--	(SELECT 
--       (Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [EnquiryProduct] ep  with (nolock) where EnquiryId = enq.EnquiryId and isactive=1 and AssociatedOrder IS NOT NULL and AssociatedOrder <> 0) FOR XML PATH(''''))
--) ) as AssociatedOrder, enq.CreatedDate
----,(select [dbo].[fn_CheckStockValidation_New](enq.EnquiryId)) as IsAvailableStock
--	,(select cast ((SELECT ''true'' AS [@json:Array] 
--		,enq.EnquiryGuid as OrderGUID, [EnquiryProductId], ItemId, ParentItemId, ep.[ParentProductCode], ep.[AssociatedOrder],
--		ep.ProductName , ep.UnitPrice as ItemPricesPerUnit,ep.[ProductCode], ep.UOM as PrimaryUnitOfMeasure, ep.[ProductQuantity], ep.[ProductType],
--		0 as WeightPerUnit, ep.[IsActive], ep.[ItemType], 0 as CurrentItemPalettesCorrectWeight, 0 as CurrentItemTruckCapacityFullInTon, 
--		ep.[PackingItemCount], ep.[PackingItemCode], ISNULL(ep.[IsPackingItem],0) AS IsPackingItem, 0 as NumberOfExtraPalettes, 0 as DepositeAmountPerUnit,
--		ep.[CollectionLocationCode], 0 as AllocationExists, 0 as AllocationQty, ep.CreatedDate from [EnquiryProduct] ep
--		WHERE ep.IsActive = 1 AND ep.EnquiryId = enq.EnquiryId 
--	   FOR XML path(''ProductList''),ELEMENTS) AS xml))'

--  set @sql1 = ',(select cast ((SELECT ''true'' AS [@json:Array]  
--			,n.RoleId
--			,n.ObjectId
--			,n.ObjectType
--			,n.Note
--			,n.IsActive
--			,n.CreatedBy
--			from Notes n 
--			inner join NotesRoleWiseConfiguration nc ON nc.RoleId = n.RoleId and nc.ObjectType = 1220
--			where n.ObjectType =1220 
--			and n.ObjectId = enq.EnquiryId  and nc.ViewNotesByRoleId = '+@RoleIdNvarchar+'
--			FOR XML path(''NoteList''),ELEMENTS) AS xml))
--	from enquiry enq
--	Left join Location cl with (nolock) on enq.CollectionLocationCode = cl.LocationCode
--	LEFT join TruckSize tz with (nolock) on enq.[TruckSizeId] = tz.TruckSizeId
--	left join Company c with (nolock) on c.CompanyId = enq.SoldTo
--	left join [Location] d  with (nolock) on enq.ShipTo = d.LocationId
--	left join ZoneCode zc on zc.CompanyId=enq.SoldTo
--	left join Company cp with (nolock) on cp.CompanyId = c.CompanyId
--	  where '+ @whereClause +' and enq.IsActive=1
--	ORDER BY enq.[EnquiryId] DESC 
--	OFFSET ('+@PageIndexNvarchar+') ROWS
--	FETCH NEXT '+@PageSizeNvarchar+' ROWS ONLY 
--  FOR XML PATH(''EnquiryList''),ELEMENTS,ROOT(''Enquiry'')) AS XML);'

  print @sql
  print @sql3
  print @sql1
  --EXEC sp_executesql @sql
  EXECUTE (@sql + @sql3 + @sql1)

  set @sql2 = 'select count(*) as TotalCount from enquiry enq
	Left join Location cl with (nolock) on enq.CollectionLocationCode = cl.LocationCode
	LEFT join TruckSize tz with (nolock) on enq.[TruckSizeId] = tz.TruckSizeId
	left join Company c with (nolock) on c.CompanyId = enq.SoldTo
	left join [Location] d  with (nolock) on enq.ShipTo = d.LocationId
	left join ZoneCode zc on zc.CompanyId=enq.SoldTo
	left join Company cp with (nolock) on cp.CompanyId = c.CompanyId
	  where   '+ @whereClause +' and enq.IsActive=1'

	EXECUTE (@sql2)

 end