
-- =============================================
-- Author:		Vinod Yadav
-- Create date: 20 jan 2020
-- Description:	<Description,,>
-- exec [dbo].[SSP_GetEnquiryDetailsOfCustomerV2] '',1288,'0','','','','','','','','','','','','','','','','','','','','','','',''
-- exec [dbo].[SSP_GetEnquiryDetailsOfCustomerV2] 0,0,0,'',0,'6410',0
-- exec [dbo].[SSP_GetEnquiryDetailsOfCustomerV2] 0,0,0,0,5 
-- PREVOUSLY ITS WAS NAME [dbo].[SSP_GetEnquiryDetailsOfCustomerV2]
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetEnquiryDetailsV2]

	@EnquiryDescription nvarchar(500),
	@EnquiryId bigint=0,
	@EnquiryAutoNumber nvarchar(500),
	@PickDateTimeFrom date,
	@PickDateTimeTo date,
	@EnquiryType nvarchar(500),
	@EnquiryDateFrom date,
	@EnquiryDateTo date,
	@RequestDateFrom date,
	@RequestDateTo date,
	@ShipToCode nvarchar(500),
	@ShipToName nvarchar(500),
	@BillToCode nvarchar(500),
	@BillToName nvarchar(500),
	@SoldToCode nvarchar(500),
	@SoldToName nvarchar(500),
	@CompanyId bigint=0,
	@CompanyCode nvarchar(500),
	@CompanyName nvarchar(500),
	@CarrierCode nvarchar(500),
	@CarrierName nvarchar(500),
	@CollectionLocationCode nvarchar(500),
	@CollectionLocationName nvarchar(500),
	@TruckSize nvarchar(500),
	@PONumber nvarchar(500),
	@SONumber nvarchar(500),
	@CurrentState bigint=0,
	@RoleId bigint,
	@PageIndex int,
	@PageSize int,
	@LastSyncDate DateTime

AS

BEGIN

DECLARE  @xmlDoc XML
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
Declare @RoleIdNvarchar nvarchar(10)
Declare @PageIndexNvarchar nvarchar(10)
Declare @PageSizeNvarchar nvarchar(10)
DECLARE @whereClause NVARCHAR(max)

set @whereClause='1=1'


set @RoleIdNvarchar=CONVERT(nvarchar(30),@RoleId)
set @PageIndexNvarchar=CONVERT(nvarchar(30),(@PageIndex*@PageSize))
set @PageSizeNvarchar=CONVERT(nvarchar(30),@PageSize)



	IF @EnquiryId IS NOT NULL AND @EnquiryId <> 0 
	SET @whereClause = @whereClause+ ' AND enq.EnquiryId ='+  CONVERT(varchar(50),@EnquiryId)+'';

	IF @EnquiryAutoNumber IS NOT NULL AND @EnquiryAutoNumber <> 0 
	SET @whereClause = @whereClause+ ' AND enq.EnquiryAutoNumber = '''+@EnquiryAutoNumber+''''

	IF @EnquiryDescription IS NOT NULL AND @EnquiryDescription <> ''
	SET @whereClause = @whereClause+ ' AND enq.Description1 Like ''%'+@EnquiryDescription+'%'''

	IF @PickDateTimeFrom IS NOT NULL AND @PickDateTimeFrom <>'' AND @PickDateTimeTo IS NOT NULL AND @PickDateTimeTo <> ''
	SET @whereClause = @whereClause+ ' AND CONVERT(varchar(11),enq.PickDateTime,103) between '+ CONVERT(varchar(11),@PickDateTimeFrom,103)+''' and '''+ CONVERT(varchar(11),@PickDateTimeTo,103) +''')'

	IF @EnquiryType IS NOT NULL AND @EnquiryType <>''
	SET @whereClause = @whereClause+ ' AND enq.EnquiryType= '''+@EnquiryType+''''

	IF @ShipToCode IS NOT NULL AND @ShipToCode <>''
	SET @whereClause = @whereClause+ ' AND enq.ShipToCode= '''+@ShipToCode+''''

	IF @ShipToName IS NOT NULL AND @ShipToName <>''
	SET @whereClause = @whereClause+ ' AND enq.ShipToName= '''+@ShipToName+''''

	IF @BillToCode IS NOT NULL AND @BillToCode <>''
	SET @whereClause = @whereClause+ ' AND enq.BillToCode= '''+@BillToCode+''''

	IF @BillToName IS NOT NULL AND @BillToName <>''
	SET @whereClause = @whereClause+ ' AND enq.BillToName= '''+@BillToName+''''

	IF @SoldToCode IS NOT NULL AND @SoldToCode <>''
	SET @whereClause = @whereClause+ ' AND enq.SoldToCode= '''+@SoldToCode+''''

	IF @SoldToName IS NOT NULL AND @SoldToName <>''
	SET @whereClause = @whereClause+ ' AND enq.SoldToName= '''+@SoldToName+''''

	IF @CollectionLocationCode IS NOT NULL AND @CollectionLocationCode <>''
	SET @whereClause = @whereClause+ ' AND enq.CollectionLocationCode= '''+@CollectionLocationCode+''''

	IF @CollectionLocationName IS NOT NULL AND @CollectionLocationName <>''
	SET @whereClause = @whereClause+ ' AND enq.CollectionLocationName= '''+@CollectionLocationName+''''

	IF @CompanyId IS NOT NULL AND @CompanyId <>0
	SET @whereClause = @whereClause+ ' AND enq.CompanyId= '+ CONVERT(varchar(50),@CompanyId)+''

	IF @CompanyCode IS NOT NULL AND @CompanyCode <>''
	SET @whereClause = @whereClause+ ' AND enq.CompanyCode= '''+@CompanyCode+''''

	IF @CompanyName IS NOT NULL AND @CompanyName <>''
	SET @whereClause = @whereClause+ ' AND enq.CompanyName= '''+@CompanyName+''''

	IF @CarrierCode IS NOT NULL AND @CarrierCode <>''
	SET @whereClause = @whereClause+ ' AND enq.CarrierCode= '''+@CarrierCode+''''

	IF @CarrierName IS NOT NULL AND @CarrierName <>''
	SET @whereClause = @whereClause+ ' AND enq.CarrierName= '''+@CarrierName+''''

		IF @TruckSize IS NOT NULL AND @TruckSize <>''
	SET @whereClause = @whereClause+ ' AND enq.TruckSize= '''+@TruckSize+''''

		IF @PONumber IS NOT NULL AND @PONumber <>''
	SET @whereClause = @whereClause+ ' AND enq.PONumber= '''+@PONumber+''''

		IF @SONumber IS NOT NULL AND @SONumber <>''
	SET @whereClause = @whereClause+ ' AND enq.SONumber= '''+@SONumber+''''

	IF @CurrentState IS NOT NULL AND @CurrentState <>0
	SET @whereClause = @whereClause+ ' AND enq.CurrentState= '+ CONVERT(varchar(50),@CurrentState)+''

	IF @LastSyncDate IS NOT NULL AND @LastSyncDate <>''
	SET @whereClause = @whereClause+ 'AND (CONVERT(varchar(23),isnull(enq.ModifiedDate,enq.CreatedDate),120) > '''+CONVERT(varchar(23),@LastSyncDate,120)+''')'

	IF @RequestDateFrom IS NOT NULL AND @RequestDateFrom <>'' AND @RequestDateTo IS NOT NULL AND @RequestDateTo <> ''
	SET @whereClause = @whereClause+ 'AND (CONVERT(varchar(11),enq.RequestDate,103) between '''+ CONVERT(varchar(11),@RequestDateFrom,103) +''' and '''+ CONVERT(varchar(11),@RequestDateTo,103) +''')'

	IF @EnquiryDateFrom IS NOT NULL AND @EnquiryDateFrom <>'' AND @EnquiryDateTo IS NOT NULL AND @EnquiryDateTo <> ''
	SET @whereClause = @whereClause+ 'AND (CONVERT(varchar(11),enq.EnquiryDate,103) between '''+ CONVERT(varchar(11),@EnquiryDateFrom,103)  +''' and '''+ CONVERT(varchar(11),@EnquiryDateTo,103)  +''')'

	--,(Select top 1 rws.ResourceKey from RoleWiseStatus rws where rws.IsActive=1 and rws.StatusId=enq.CurrentState and rws.RoleId='+@RoleIdNvarchar+') AS StatusResourceKey
--,(Select top 1 rws.Class from RoleWiseStatus rws where rws.IsActive=1 and rws.StatusId=enq.CurrentState and rws.RoleId='+@RoleIdNvarchar+') AS StatusClass,

   set @sql=' WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT ''true'' AS [@json:Array] ,22222 as [TotalCount]
	, '''' as CopyOrderGUID, enq.EnquiryGuid as OrderGUID, enq.Description1 as InquiryDescription, enq.[EnquiryId], enq.[EnquiryAutoNumber], enq.[PickDateTime],
	enq.[EnquiryType], '''' as IsOrderSelfCollect, enq.EnquiryDate as ActivityStartTime, enq.[EnquiryDate], enq.[RequestDate], enq.[ShipTo], enq.[ShipToCode],
	enq.[ShipToName],enq. BillToId as BillTo, [BillToCode], '''' as BillToName , enq.[SoldTo], enq.[SoldToCode], '''' as SoldToName, enq.[CompanyId], 
	enq.[CompanyCode],  '''' as CompanyName, 0 as CarrierId, enq.[CarrierCode], enq.[CarrierName], 0 CollectionLocationId,
	enq.[CollectionLocationCode], '''' CollectionLocationName, enq.[PreSellerCode], enq.[PreSellerName], enq.[TruckSizeId], 
	'''' as TruckSize, enq.[PONumber], enq.[SONumber], enq.Field8 as NoOfDays, enq.[IsActive], enq.[IsRecievingLocationCapacityExceed],
	enq.[OrderProposedETD], enq.[PreviousState], enq.[CurrentState], enq.[NumberOfPalettes], enq.[PalletSpace],
	-1 as CollectionDateFromSettingValue, enq.[TotalAmount], enq.[TotalQuantity], enq.[TotalPrice], enq.[TotalWeight], 
	enq.[TotalVolume], enq.[TruckWeight], enq.[TotalDepositeAmount], enq.[TotalTaxAmount], enq.[TotalDiscountAmount], enq.TotalAmount as TotalOrderAmount,
	0 as IsSynced, enq.[Field1], enq.[Field2], enq.[Field3], enq.[Field4], enq.[Field5], enq.[Field6], enq.[Field7], enq.[Field8], enq.[Field9], enq.[Field10]
		,(select cast ((SELECT ''true'' AS [@json:Array] 
		,enq.EnquiryGuid As OrderGUID, [EnquiryProductId], 0 as ItemId, 0 as ParentItemId, ep.[ParentProductCode], ep.[AssociatedOrder],
		ep.ProductName , ep.UnitPrice as ItemPricesPerUnit,ep.[ProductCode], ep.UOM as PrimaryUnitOfMeasure, ep.[ProductQuantity], ep.[ProductType],
		0 as WeightPerUnit, ep.[IsActive], ep.[ItemType], 0 as CurrentItemPalettesCorrectWeight, 0 as CurrentItemTruckCapacityFullInTon, 
		ep.[PackingItemCount], ep.[PackingItemCode], ep.[IsPackingItem], 0 as NumberOfExtraPalettes, 0 as DepositeAmountPerUnit,
		ep.[CollectionLocationCode], 0 as AllocationExists, 0 as AllocationQty from [EnquiryProduct] ep
		WHERE ep.IsActive = 1 AND ep.EnquiryId = enq.EnquiryId 
	   FOR XML path(''ProductList''),ELEMENTS) AS xml))
	,(select cast ((SELECT ''true'' AS [@json:Array]  
			,n.RoleId
			,n.ObjectId
			,n.ObjectType
			,n.Note
			,n.IsActive
			,n.CreatedBy
			from Notes n where n.ObjectType =1220 
			and n.ObjectId = enq.EnquiryId 
			FOR XML path(''NoteList''),ELEMENTS) AS xml))
	from enquiry enq  where   '+ @whereClause +' and enq.IsActive=1
	ORDER BY enq.[EnquiryId] DESC
	OFFSET ('+@PageIndexNvarchar+') ROWS
	FETCH NEXT '+@PageSizeNvarchar+' ROWS ONLY
  FOR XML PATH(''EnquiryList''),ELEMENTS,ROOT(''Enquiry'')) AS XML)'
  print @sql
  EXEC sp_executesql @sql
 end