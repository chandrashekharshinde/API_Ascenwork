
-- =============================================
-- Author:		Sushil Sharma
-- Create date: 07-02-2020
-- Description:	Getting order details
-- =============================================

--exec SSP_GetOrderDetailsV2 @BillTo=NULL,@BillToCode=NULL,@BillToName=NULL,@CarrierCode=NULL,@CarrierETA=NULL,@CarrierETD=NULL,@CarrierName=NULL,@CarrierNumber=NULL,@CollectionLocationCode=NULL,@CollectionLocationName=NULL,@CompanyCode=NULL,@CurrentState=NULL,@Description1=NULL,@Description2=NULL,@ExpectedTimeOfDelivery=NULL,@Field1=NULL,@Field10=NULL,@Field2=NULL,@Field3=NULL,@Field4=NULL,@Field5=NULL,@Field6=NULL,@Field7=NULL,@Field8=NULL,@Field9=NULL,@GratisCode=NULL,@InvoiceNumber=NULL,@IsActive=NULL,@IsSelfCollect=NULL,@LoadNumber=NULL,@ModeOfDelivery=NULL,@NumberOfCrate=NULL,@NumberOfPalettes=NULL,@OrderDate=NULL,@OrderNumber=NULL,@OrderType=NULL,@PalletSpace=NULL,@PickDateTime=NULL,@PickNumber=NULL,@PresellerCode=NULL,@PresellerName=NULL,@PrimaryAddress=NULL,@PurchaseOrderNumber=NULL,@ReferenceNumber=NULL,@Remarks=NULL,@SalesOrderNumber=NULL,@ShipTo=NULL,@ShipToCode=NULL,@ShipToName=NULL,@SoldTo=NULL,@SoldToCode=NULL,@SoldToName=NULL,@TotalPrice=NULL,@TruckSize=NULL,@TruckWeight=NULL,@RoleId=3,@PageIndex=0,@PageSize=10

CREATE PROCEDURE [dbo].[SSP_GetOrderDetailsV2]
@BillTo bigint ,
@BillToCode nvarchar (200),
@BillToName nvarchar (200),
@CarrierCode nvarchar (250),
@CarrierETA datetime ,
@CarrierETD datetime ,
@CarrierName nvarchar (250),
@CarrierNumber nvarchar (50),
@CollectionLocationCode nvarchar (200),
@CollectionLocationName nvarchar (200),
@CompanyCode nvarchar (250),
@CurrentState bigint ,
@Description1 nvarchar (500),
@Description2 nvarchar (500),
@ExpectedTimeOfDelivery datetime ,
@Field1 nvarchar (500),
@Field2 nvarchar (500),
@Field3 nvarchar (500),
@Field4 nvarchar (500),
@Field5 nvarchar (500),
@Field6 nvarchar (500),
@Field7 nvarchar (500),
@Field8 nvarchar (500),
@Field9 nvarchar (500),
@Field10 nvarchar (500),
@GratisCode nvarchar (50),
@InvoiceNumber nvarchar (150),
@IsActive bit ,
@IsSelfCollect bit ,
@LoadNumber nvarchar (500),
@ModeOfDelivery nvarchar (200),
@NumberOfCrate bigint ,
@NumberOfPalettes decimal ,
@OrderDate datetime ,
@OrderNumber nvarchar (100),
@OrderType nvarchar (200),
@PalletSpace decimal ,
@PickDateTime datetime ,
@PickNumber nvarchar (200),
@PresellerCode nvarchar (100),
@PresellerName nvarchar (500),
@PrimaryAddress nvarchar (500),
@PurchaseOrderNumber nvarchar (200),
@ReferenceNumber nvarchar (100),
@Remarks nvarchar (max),
@SalesOrderNumber nvarchar (200),
@ShipTo bigint ,
@ShipToCode nvarchar (250),
@ShipToName nvarchar (250),
@SoldTo bigint ,
@SoldToCode nvarchar (250),
@SoldToName nvarchar (250),
@TotalPrice decimal ,
@TruckSize nvarchar (50),
@TruckWeight decimal ,
@PageIndex int,
@PageSize int,
@RoleId bigint,
@LastSyncDate datetime
AS
BEGIN
DECLARE  @xmlDoc XML
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sqlscript nvarchar(max)
DECLARE @sqlscript2 nvarchar(max)
DECLARE @sqlscript3 nvarchar(max)
Declare @username nvarchar(max)
DECLARE @whereClause NVARCHAR(max)
--Declare @RoleIdNvarchar nvarchar(10)
Declare @PageIndexNvarchar nvarchar(10)
Declare @PageSizeNvarchar nvarchar(10)
set @whereClause='1=1'


--set @RoleIdNvarchar=CONVERT(nvarchar(30),@RoleId)
set @PageIndexNvarchar=CONVERT(nvarchar(30),(@PageIndex*@PageSize))
set @PageSizeNvarchar=CONVERT(nvarchar(30),@PageSize)




IF @BillTo IS NOT NULL AND @BillTo <> 0 SET @whereClause = @whereClause+ ' AND ord.BillTo ='+CONVERT(varchar(100),@BillTo);
IF @BillToCode IS NOT NULL AND @BillToCode <> '' SET @whereClause = @whereClause+ ' AND ord.BillToCode ='''+@BillToCode+''''
IF @BillToName IS NOT NULL AND @BillToName <> '' SET @whereClause = @whereClause+ ' AND ord.BillToName ='''+@BillToName+''''
IF @CarrierCode IS NOT NULL AND @CarrierCode <> '' SET @whereClause = @whereClause+ ' AND ord.CarrierCode ='''+@CarrierCode+''''
IF @CarrierETA IS NOT NULL AND @CarrierETA <> '' SET @whereClause = @whereClause+ ' AND ord.CarrierETA ='''+@CarrierETA+''''
IF @CarrierETD IS NOT NULL AND @CarrierETD <> '' SET @whereClause = @whereClause+ ' AND ord.CarrierETD ='''+@CarrierETD+''''
IF @CarrierName IS NOT NULL AND @CarrierName <> '' SET @whereClause = @whereClause+ ' AND ord.CarrierName ='''+@CarrierName+''''
IF @CarrierNumber IS NOT NULL AND @CarrierNumber <> '' SET @whereClause = @whereClause+ ' AND ord.CarrierNumber ='''+@CarrierNumber+''''
IF @CollectionLocationCode IS NOT NULL AND @CollectionLocationCode <> '' SET @whereClause = @whereClause+ ' AND ord.CollectionLocationCode ='''+@CollectionLocationCode+''''
IF @CollectionLocationName IS NOT NULL AND @CollectionLocationName <> '' SET @whereClause = @whereClause+ ' AND ord.CollectionLocationName ='''+@CollectionLocationName+''''
IF @CompanyCode IS NOT NULL AND @CompanyCode <> '' SET @whereClause = @whereClause+ ' AND ord.CompanyCode ='''+@CompanyCode+''''
IF @CurrentState IS NOT NULL AND @CurrentState <> 0 SET @whereClause = @whereClause+ ' AND ord.CurrentState ='+CONVERT(varchar(100),@CurrentState);
IF @Description1 IS NOT NULL AND @Description1 <> '' SET @whereClause = @whereClause+ ' AND ord.Description1 ='''+@Description1+''''
IF @Description2 IS NOT NULL AND @Description2 <> '' SET @whereClause = @whereClause+ ' AND ord.Description2 ='''+@Description2+''''
IF @ExpectedTimeOfDelivery IS NOT NULL AND @ExpectedTimeOfDelivery <> '' SET @whereClause = @whereClause+ ' AND ord.ExpectedTimeOfDelivery ='''+@ExpectedTimeOfDelivery+''''
IF @Field1 IS NOT NULL AND @Field1 <> '' SET @whereClause = @whereClause+ ' AND ord.Field1 ='''+@Field1+''''
IF @Field10 IS NOT NULL AND @Field10 <> '' SET @whereClause = @whereClause+ ' AND ord.Field10 ='''+@Field10+''''
IF @Field2 IS NOT NULL AND @Field2 <> '' SET @whereClause = @whereClause+ ' AND ord.Field2 ='''+@Field2+''''
IF @Field3 IS NOT NULL AND @Field3 <> '' SET @whereClause = @whereClause+ ' AND ord.Field3 ='''+@Field3+''''
IF @Field4 IS NOT NULL AND @Field4 <> '' SET @whereClause = @whereClause+ ' AND ord.Field4 ='''+@Field4+''''
IF @Field5 IS NOT NULL AND @Field5 <> '' SET @whereClause = @whereClause+ ' AND ord.Field5 ='''+@Field5+''''
IF @Field6 IS NOT NULL AND @Field6 <> '' SET @whereClause = @whereClause+ ' AND ord.Field6 ='''+@Field6+''''
IF @Field7 IS NOT NULL AND @Field7 <> '' SET @whereClause = @whereClause+ ' AND ord.Field7 ='''+@Field7+''''
IF @Field8 IS NOT NULL AND @Field8 <> '' SET @whereClause = @whereClause+ ' AND ord.Field8 ='''+@Field8+''''
IF @Field9 IS NOT NULL AND @Field9 <> '' SET @whereClause = @whereClause+ ' AND ord.Field9 ='''+@Field9+''''
IF @GratisCode IS NOT NULL AND @GratisCode <> '' SET @whereClause = @whereClause+ ' AND ord.GratisCode ='''+@GratisCode+''''
IF @InvoiceNumber IS NOT NULL AND @InvoiceNumber <> '' SET @whereClause = @whereClause+ ' AND ord.InvoiceNumber ='''+@InvoiceNumber+''''
IF @IsActive IS NOT NULL AND @IsActive <> 0 SET @whereClause = @whereClause+ ' AND ord.IsActive ='+CONVERT(varchar(100),@IsActive);
IF @IsSelfCollect IS NOT NULL AND @IsSelfCollect <> 0 SET @whereClause = @whereClause+ ' AND ord.IsSelfCollect ='+CONVERT(varchar(100),@IsSelfCollect);
IF @LoadNumber IS NOT NULL AND @LoadNumber <> '' SET @whereClause = @whereClause+ ' AND ord.LoadNumber ='''+@LoadNumber+''''
IF @ModeOfDelivery IS NOT NULL AND @ModeOfDelivery <> '' SET @whereClause = @whereClause+ ' AND ord.ModeOfDelivery ='''+@ModeOfDelivery+''''
IF @NumberOfCrate IS NOT NULL AND @NumberOfCrate <> 0 SET @whereClause = @whereClause+ ' AND ord.NumberOfCrate ='+CONVERT(varchar(100),@NumberOfCrate);
IF @NumberOfPalettes IS NOT NULL AND @NumberOfPalettes <> 0 SET @whereClause = @whereClause+ ' AND ord.NumberOfPalettes ='+CONVERT(varchar(100),@NumberOfPalettes);
IF @OrderDate IS NOT NULL AND @OrderDate <> '' SET @whereClause = @whereClause+ ' AND ord.OrderDate ='''+@OrderDate+''''
IF @OrderNumber IS NOT NULL AND @OrderNumber <> '' SET @whereClause = @whereClause+ ' AND ord.OrderNumber ='''+@OrderNumber+''''
IF @OrderType IS NOT NULL AND @OrderType <> '' SET @whereClause = @whereClause+ ' AND ord.OrderType ='''+@OrderType+''''
IF @PalletSpace IS NOT NULL AND @PalletSpace <> 0 SET @whereClause = @whereClause+ ' AND ord.PalletSpace ='+CONVERT(varchar(100),@PalletSpace);
IF @PickDateTime IS NOT NULL AND @PickDateTime <> '' SET @whereClause = @whereClause+ ' AND ord.PickDateTime ='''+@PickDateTime+''''
IF @PickNumber IS NOT NULL AND @PickNumber <> '' SET @whereClause = @whereClause+ ' AND ord.PickNumber ='''+@PickNumber+''''
IF @PresellerCode IS NOT NULL AND @PresellerCode <> '' SET @whereClause = @whereClause+ ' AND ord.PresellerCode ='''+@PresellerCode+''''
IF @PresellerName IS NOT NULL AND @PresellerName <> '' SET @whereClause = @whereClause+ ' AND ord.PresellerName ='''+@PresellerName+''''
IF @PrimaryAddress IS NOT NULL AND @PrimaryAddress <> '' SET @whereClause = @whereClause+ ' AND ord.PrimaryAddress ='''+@PrimaryAddress+''''
IF @PurchaseOrderNumber IS NOT NULL AND @PurchaseOrderNumber <> '' SET @whereClause = @whereClause+ ' AND ord.PurchaseOrderNumber ='''+@PurchaseOrderNumber+''''
IF @ReferenceNumber IS NOT NULL AND @ReferenceNumber <> '' SET @whereClause = @whereClause+ ' AND ord.ReferenceNumber ='''+@ReferenceNumber+''''
IF @Remarks IS NOT NULL AND @Remarks <> '' SET @whereClause = @whereClause+ ' AND ord.Remarks ='''+@Remarks+''''
IF @SalesOrderNumber IS NOT NULL AND @SalesOrderNumber <> '' SET @whereClause = @whereClause+ ' AND ord.SalesOrderNumber ='''+@SalesOrderNumber+''''
IF @ShipTo IS NOT NULL AND @ShipTo <> 0 SET @whereClause = @whereClause+ ' AND ord.ShipTo ='+CONVERT(varchar(100),@ShipTo);
IF @ShipToCode IS NOT NULL AND @ShipToCode <> '' SET @whereClause = @whereClause+ ' AND ord.ShipToCode ='''+@ShipToCode+''''
IF @ShipToName IS NOT NULL AND @ShipToName <> '' SET @whereClause = @whereClause+ ' AND ord.ShipToName ='''+@ShipToName+''''
IF @SoldTo IS NOT NULL AND @SoldTo <> 0 SET @whereClause = @whereClause+ ' AND ord.SoldTo ='+CONVERT(varchar(100),@SoldTo);
IF @SoldToCode IS NOT NULL AND @SoldToCode <> '' SET @whereClause = @whereClause+ ' AND ord.SoldToCode ='''+@SoldToCode+''''
IF @SoldToName IS NOT NULL AND @SoldToName <> '' SET @whereClause = @whereClause+ ' AND ord.SoldToName ='''+@SoldToName+''''
IF @TotalPrice IS NOT NULL AND @TotalPrice <> 0 SET @whereClause = @whereClause+ ' AND ord.TotalPrice ='+CONVERT(varchar(100),@TotalPrice);
IF @TruckSize IS NOT NULL AND @TruckSize <> '' SET @whereClause = @whereClause+ ' AND ord.TruckSize ='''+@TruckSize+''''
IF @TruckWeight IS NOT NULL AND @TruckWeight <> 0 SET @whereClause = @whereClause+ ' AND ord.TruckWeight ='+CONVERT(varchar(100),@TruckWeight);

IF @LastSyncDate IS NOT NULL AND @LastSyncDate <>''
SET @whereClause = @whereClause+ 'AND (CONVERT(varchar(23),isnull(ord.ModifiedDate,ord.CreatedDate),120) > '''+CONVERT(varchar(23),@LastSyncDate,120)+''')'

--(Select top 1 rws.ResourceKey from RoleWiseStatus rws where rws.IsActive=1 and rws.StatusId=ord.CurrentState and rws.RoleId='+@RoleIdNvarchar+') AS StatusResourceKey,
--(Select top 1 rws.Class from RoleWiseStatus rws where rws.IsActive=1 and rws.StatusId=ord.CurrentState and rws.RoleId='+@RoleIdNvarchar+') AS StatusClass,
 set @sqlscript=';WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)  select cast ((SELECT ''true'' AS [@json:Array],50 as [TotalCount],
ord.BillTo,
ord.BillToCode,
ord.BillToName,
ord.CarrierCode,
ord.CarrierETA,
ord.CarrierETD,
ord.CarrierName,
ord.CarrierNumber,
ord.CollectionLocationCode,
ord.CollectionLocationId,
ord.CollectionLocationName,
ord.CompanyCode,
ord.CompanyId,
ord.CreatedBy,
ord.CreatedDate,
ord.CurrentState,
ord.Description1,
ord.Description2,
ord.DiscountAmount,
ord.DiscountPercent,
ord.EnquiryId,
ord.ExpectedTimeOfDelivery,
ord.Field1,
ord.Field10,
ord.Field2,
ord.Field3,
ord.Field4,
ord.Field5,
ord.Field6,
ord.Field7,
ord.Field8,
ord.Field9,
ord.GratisCode,
ord.HoldStatus,
ord.InvoiceNumber,
ord.IsActive,
ord.IsInventoryTransfer,
ord.IsLockFromWMS,
ord.IsPickConfirmed,
ord.IsPrintPickSlip,
ord.IsRecievingLocationCapacityExceed,
ord.IsSelfCollect,
ord.IsSendToWMS,
ord.IsSIOI,
ord.IsSTOTUpdated,
ord.IsVatIntegrationProcessed,
ord.LoadNumber,
ord.ModeOfDelivery,
ord.ModifiedBy,
ord.ModifiedDate,
ord.NextState,
ord.NumberOfCrate,
ord.NumberOfPalettes,
ord.OI,
ord.OrderDate,
ord.OrderedBy,
ord.OrderId,
ord.OrderNumber,
ord.OrderType,
ord.PalletSpace,
ord.ParentOrderId,
ord.PaymentTerm,
ord.PickDateTime,
ord.PickNumber,
ord.PresellerCode,
ord.PresellerName,
ord.PreviousState,
ord.PrimaryAddress,
ord.PrimaryAddressId,
ord.Province,
ord.PurchaseOrderNumber,
ord.RedInvoiceNumber,
ord.ReferenceForSIOI,
ord.ReferenceNumber,
ord.Remarks,
ord.SalesOrderNumber,
ord.SecondaryAddress,
ord.SecondaryAddressId,
ord.SequenceNo,
ord.ShipTo,
ord.ShipToCode,
ord.ShipToName,
ord.SI,
ord.SoldTo,
ord.SoldToCode,
ord.SoldToName,
ord.StockLocationId,
ord.TotalAmount,
ord.TotalDepositeAmount,
ord.TotalDiscountAmount,
ord.TotalPrice,
ord.TotalQuantity,
ord.TotalTaxAmount,
ord.TotalVolume,
ord.TotalWeight,
ord.TruckBranchPlantLocationId,
ord.TruckSize,
ord.TruckSizeId,
''1''IsSynced,
ord.TruckWeight'
set @sqlscript2=',(select cast ((SELECT ''true'' AS [@json:Array] , 
op.[OrderProductId]
      ,op.[CompanyId],op.[CompanyCode],op.[OrderId],op.[OrderNumber],op.[ProductCode],op.[ProductName],op.[ParentProductCode]
      ,op.[ProductType],op.[ProductQuantity],op.[UnitPrice],op.[TotalUnitPrice],op.[EffectiveDate]
      ,op.[DepositeAmount],op.[ShippableQuantity],op.[BackOrderQuantity],op.[CancelledQuantity],op.[ReturnQuantity]
      ,op.[AssociatedOrder],op.[ItemType],op.[Remarks],op.[CreatedBy],op.[CreatedDate],op.[ModifiedBy]
      ,op.[ModifiedDate],op.[IsActive],op.[LineNumber],op.[InvoiceNumber] ,op.[Field1],op.[Field2],op.[Field3]
      ,op.[Field4],op.[Field5],op.[Field6],op.[Field7],op.[Field8],op.[Field9],op.[Field10],op.[DiscountPercent]
      ,op.[DiscountAmount],op.[IsProductShipConfirmed],op.[ReferenceOrderId],op.[ReferenceOrderProductId],op.[OrderProductGuid]
      ,op.[PalletNumber],op.[ReplacementParentProductId],op.[IsReplaceable],op.[LotNumber],op.[CollectedQuantity],op.[DeliveredQuantity]
      ,op.[LastStatus]    ,op.[NextStatus],op.[StockLocationCode],op.[StockLocationName],op.[TotalVolume]
      ,op.[TotalWeight],op.[IsGRN],op.[SignalValue],op.[PackingItemCount],op.[PackingItemCode],op.[IsPackingItem]
  FROM [dbo].[OrderProduct] op WITH(NOLOCK) where op.[OrderID]=ord.OrderID and op.IsActive=1
FOR XML path(''OrderProductList''),ELEMENTS) AS xml))'
set @sqlscript3= ',(select cast ((SELECT ''true'' AS [@json:Array]  
			,n.RoleId
			,n.ObjectId
			,n.ObjectType
			,n.Note
			,n.IsActive
			,n.CreatedBy
			from Notes n WITH(NOLOCK) where n.ObjectType =1221 
			and n.ObjectId = ord.OrderId 
			FOR XML path(''NoteList''),ELEMENTS) AS xml))
from [order] ord WITH (NOLOCK) where   '+ @whereClause +' and ord.IsActive=1
ORDER BY ord.OrderDate DESC
OFFSET ('+@PageIndexNvarchar+') ROWS
FETCH NEXT '+@PageSizeNvarchar+' ROWS ONLY
 FOR XML PATH(''OrderList''),ELEMENTS,ROOT(''Order'')) AS XML)'

 --print @sqlscript + @sqlscript2 + @sqlscript3
 exec(@sqlscript + @sqlscript2 + @sqlscript3)
 --EXEC sp_executesql @sqlscript
END
