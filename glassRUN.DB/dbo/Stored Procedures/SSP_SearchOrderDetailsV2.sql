
CREATE PROCEDURE [dbo].[SSP_SearchOrderDetailsV2] --3,1,100,'OrderList','Order',11663,''
	
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
DECLARE @sql1 nvarchar(max)
DECLARE @sql2 nvarchar(max)
DECLARE @sql3 nvarchar(max)
DECLARE @sql4 nvarchar(max)
Declare @username nvarchar(max)
Declare @RoleIdNvarchar nvarchar(10)
Declare @PageIndexNvarchar nvarchar(10)
Declare @PageSizeNvarchar nvarchar(10)
--DECLARE @whereClause NVARCHAR(max)

Declare @CurrencyCultureCode nvarchar(100)

set @CurrencyCultureCode = (select SettingValue from SettingMaster where SettingParameter = 'CurrencyCultureCode')

--set @whereClause='1=1'

SET @whereClause = '1=1' + @whereClause + '' + (
			SELECT [dbo].[fn_GetUserAndDimensionWiseWhereClause](@LoginId, @PageName, @PageControlName)
			) + ''


	IF @RoleId IN (4, 14, 15)
	BEGIN
		PRINT @RoleId

		SET @whereClause = @whereClause + ' and  (o.SoldTo in (Select ReferenceId from Login where Loginid= ' + CONVERT(NVARCHAR(10), @LoginId) + 
			') or o.CompanyId in (Select ReferenceId from Login where Loginid= ' + CONVERT(NVARCHAR(10), @LoginId) + '))'
	END

	IF @RoleId = 7 
	BEGIN
		DECLARE @checkParentId BIGINT

		SET @checkParentId = (
				SELECT ISNULL(ParentId, 0)
				FROM LOGIN
				WHERE LoginId = '' + CONVERT(NVARCHAR(10), @LoginId) + ''
				)

		IF @checkParentId = 0
		BEGIN
			PRINT '1'

			DECLARE @companyid BIGINT

			SELECT @companyid = c.CompanyId
			FROM Company c
			LEFT JOIN LOGIN l ON l.ReferenceId = c.CompanyId
			WHERE c.CompanyType = 28 AND c.IsActive = 1 AND l.LoginId = @LoginId

			SET @whereClause = @whereClause + 'and o.CarrierNumber = ' + CONVERT(NVARCHAR(10), @companyid) + ' '
		END
		ELSE
		BEGIN
			PRINT '2'

			SET @whereClause = @whereClause + ' and o.CollectionLocationCode in (select DimensionValue from UserDimensionMapping where UserId=' + CONVERT(NVARCHAR(10), @LoginId) + 
				') and  (select top 1 carriernumber from [dbo].route where destinationid=txtp.ShipTo and TruckSizeId=txtp.TruckSizeId)=' + CONVERT(NVARCHAR(10), @LoginId) + ''
		END
				
	END

	If @roleId = 2
		Begin
			DECLARE @parentcompanyid BIGINT

			SELECT @parentcompanyid = c.CompanyId
			FROM Company c
			LEFT JOIN LOGIN l ON l.ReferenceId = c.CompanyId
			WHERE c.CompanyType = 28 AND c.IsActive = 1 AND l.LoginId = @LoginId

			SET @whereClause = @whereClause + 'and carriernumber = (' + CONVERT(NVARCHAR(10), @parentcompanyid) + ')'
		End



	IF (@roleId = 7 OR @roleId = 2 OR @roleId = 5 OR @roleId = 6 OR @roleId = 3 OR @roleId = 4 OR @roleId = 1)
	BEGIN
		
		IF (@roleId = 7 OR @roleId = 5)
		BEGIN
			BEGIN
				SET @whereClause = @whereClause + ' and o.CurrentState !=1105'
			END

			DECLARE @settingValue NVARCHAR(50)

			SET @settingValue = (
					SELECT SettingValue
					FROM SettingMaster
					WHERE SettingParameter = 'OrderShownToCarrier' AND IsActive = 1
					)

			IF @settingValue = 1
			BEGIN
				SET @whereClause = @whereClause + ' and oV2.PickDateTimeFromOM is not null and oV2.PraposedShift is not null'
			END
		END
	END


set @RoleIdNvarchar=CONVERT(nvarchar(30),@RoleId)
set @PageIndexNvarchar=CONVERT(nvarchar(30),(@PageIndex*@PageSize))
set @PageSizeNvarchar=CONVERT(nvarchar(30),@PageSize)

set @sql1='WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json)
,OrderCTE
AS (
select o.OrderId, o.OrderType, o.OrderNumber, o.EnquiryId, 
ISNULL(o.HoldStatus,''-'') AS HoldStatus,
 o.TotalPrice, 
 format(o.[TotalPrice], N''C'', '''+ @CurrencyCultureCode +''') AS TotalPriceWithCurrency,
 ISNULL(o.ModifiedDate, o.CreatedDate) AS ModifiedDate
 ,d.LocationName
 ,d.LocationCode
 ,o.ShipToName As DeliveryLocationName
 ,CASE WHEN LEN(d.LocationCode) > 15 THEN LEFT(d.LocationCode, 15) + ''...'' ELSE d.LocationCode END AS DeliveryLocation
 ,o.SoldToName As CompanyName,
LTRIM(RTRIM(SUBSTRING(o.SoldToName, 0, CHARINDEX(''-'', o.SoldToName)))) as ShortCompanyName,
o.SoldToCode AS CompanyMnemonic,
c.CompanyName as SupplierName,
o.CompanyCode AS SupplierCode,
o.ExpectedTimeOfDelivery AS ExpectedTimeOfDelivery,
o.ExpectedTimeOfDelivery AS ExpectedTimeOfDeliveryValue,
oV2.ExpectedTimeOfDeliveryFromOM,
o.ExpectedTimeOfDelivery AS RequestDate, 
o.PickDateTime AS PickDateTime,
o.PickDateTime AS PickDateTimeValue,
oV2.PickDateTimeFromOM,
IsNULl(o.SalesOrderNumber, ''-'') AS SOGratisNumber,
IsNULl(o.SalesOrderNumber, ''-'') AS SalesOrderNumber, 
IsNULl(o.PurchaseOrderNumber, ''-'') AS PurchaseOrderNumber, 
oV2.PraposedShift, 
oV2.PraposedTimeOfAction, 
o.OrderDate, 
ISNULL(CONVERT(bigint, d.Capacity), 0) As Capacity, 
--CASE WHEN (SELECT Count(ReturnPakageMaterialId)  FROM [dbo].ReturnPakageMaterial rpm with (nolock)  WHERE rpm.EnquiryId = o.EnquiryId AND IsActive = 1) > 0 THEN 1 ELSE 0 END AS IsRPMPresent,
 o.Remarks,
 o.CurrentState,
ISNULL (o.EnquiryAutoNumber, ''-'') AS EnquiryAutoNumber,
 ISNULL (o.EnquiryDate, NULL) AS EnquiryDate,
 o.ShipTo, 
 o.GratisCode, 
 o.Province, 
 o.OrderedBy,
  o.LoadNumber,
   o.Description1, 
   o.Description2, 
   ISNULL(d.Field1, '''') AS Field1, 
 o.SoldTo, o.CompanyId AS OrderCompanyId, 
 0 as ReceivedCapacityPalettes,
 0 as ReceivedCapacityPalettesCheck,
o.PrimaryAddressId, 
o.[SecondaryAddressId], 
o.[PrimaryAddress], 
o.[SecondaryAddress],
o.CollectionLocationId AS StockLocationId,
o.CollectionLocationName AS DeliveryLocationBranchName,
 o.CollectionLocationName AS BranchPlantName,
 o.CollectionLocationCode AS BranchPlantCode, 
 CASE WHEN (c.ActualEmpties < 0) THEN ''C'' ELSE ''W'' END AS Empties,'

	set @sql2 = 'oV2.StatusForChangeInPickShift,
ISNULL(c.EmptiesLimit,0) AS EmptiesLimit,
ISNULL(c.ActualEmpties,0) AS ActualEmpties,
(SELECT 
(Select (SELECT '','' + CAST(SalesOrderNumber AS VARCHAR(max)) [text()] from [order]  with (nolock)   where IsActive=1 and orderId in ( select AssociatedOrder from [OrderProduct] op  
with (nolock) where op.IsActive = 1 AND OrderId = o.OrderId AND AssociatedOrder IS NOT NULL AND AssociatedOrder <> 0) FOR XML PATH(''''))
) ) as AssociatedOrder,
o.[PreviousState],
o.[TruckSizeId], 
0 As TruckCapacityWeight, 
o.TruckSize,
(SELECT (SELECT '','' + CAST(Contacts AS VARCHAR(max)) [text()] FROM [dbo].contactinformation with (nolock)
 WHERE IsActive = 1 AND (ObjectId = o.ShipTo or ObjectId = o.SoldTo) AND ContactType = ''Email'' AND (ObjectType = ''SoldTo'' OR ObjectType = ''ShipTo'') FOR XML PATH(''''))) AS Email,
 oV2.PlateNumberData, 
 oV2.DeliveryPersonName,
 oV2.DriverName,
 oV2.PlateNumber, 
 '''' as PreviousPlateNumber,
'''' as TruckInPlateNumber, 
'''' as TruckOutPlateNumber, 
oV2.TruckInDateTime, 
oV2.TruckOutDateTime,
 o.CarrierNumber,
 o.CarrierCode,
o.CarrierName AS CarrierNumberValue, 
o.CarrierName,
'''' as TruckRemark,
usr.UserName, 
 0 as ProfileId,
oV2.ExpectedShift, 
'''' AS ExpectedShiftValue, 
oV2.ExpectedTimeOfAction, 
oV2.CollectedDate, 
oV2.DeliveredDate, 
oV2.PlanCollectionDate, 
oV2.PlanDeliveryDate, 
oV2.IsCompleted,
oV2.DeliveryPersonnelId, 
0 AS [TripCost], 0 AS [TripRevenue],o.InvoiceNumber,
tio.TruckInDataTime,
tio.TruckOutDataTime,
tio.TruckInOrderId,
o.IsSelfCollect,
o.ShipToCode,
d.City,
o.Field10,
o.Field8,
o.Field9,
case when o.Field5=''1'' then  ''Yes'' else ''No'' end  as Field5,
oV2.SequenceNumber,
tio.TruckInDeatilsId,
wal.Username As ApprovedBy,
oV2.[Shift],
CASE WHEN oV2.PlanDeliveryDate IS NULL THEN ''1'' WHEN ISNULL(oV2.PlanDeliveryDate, '''') >= ISNULL(oV2.PlanDeliveryDate, GETDATE()) THEN ''1'' ELSE ''-1'' END AS IsLate

FROM [dbo].[Order] o WITH (NOLOCK) LEFT JOIN
[dbo].Location d WITH (NOLOCK) ON o.shipto = d.LocationId LEFT JOIN
[dbo].Company c WITH (NOLOCK) ON c.CompanyId = d.CompanyId LEFT JOIN
[OrderLogisticsViewV2] oV2 on ov2.OrderId=o.OrderId left join
dbo.[TruckInOrder] tio WITH (NOLOCK) on tio.OrderNumber = o.OrderNumber
LEFT JOIN [dbo].[WorkFlowActivityLog] wal  with (nolock) ON o.EnquiryId = wal.EnquiryId and wal.WorkFlowCurrentStatusCode=320
LEFT JOIN dbo.[Login] usr WITH (NOLOCK) on usr.LoginId = o.CreatedBy
WHERE o.IsActive = 1 and '+ @whereClause +'
	ORDER BY o.[OrderDate] 
	OFFSET ('+@PageIndexNvarchar+') ROWS
	FETCH NEXT '+@PageSizeNvarchar+' ROWS ONLY
),
RPM_CTE
As
(
	select rpm.EnquiryId, Count(*) AS ReturnPakageMaterialCount FROM [dbo].ReturnPakageMaterial rpm with (nolock)
	INNER JOIN OrderCTE ON rpm.EnquiryId = OrderCTE.EnquiryId
	WHERE rpm.IsActive = 1
	GROUP BY rpm.EnquiryId
)
 '
--FOR XML PATH(''OrderList''),ELEMENTS,ROOT(''Order'')) AS XML)
 
 set @sql3 = 'select cast ((SELECT ''true'' AS [@json:Array] , OrderCTE.*,
 (select cast ((SELECT ''true'' AS [@json:Array] ,OrderProductId,OrderId,ProductCode,ProductType,
ItemType, ItemName	,ProductQuantity,	ItemPricesPerUnit,	ItemPrices,
	DepositeAmountPerUnit	,ItemTotalDepositeAmount	,UOM,	ItemTax,	AssociatedOrder	,UsedQuantityInOrder
	,ProductAvailableQuantity,Remarks from OrderProductView  opv where opv.orderid=OrderCTE.OrderId
FOR XML path(''OrderProductList''),ELEMENTS) AS xml))
,(select cast ((SELECT ''true'' AS [@json:Array]  
			,n.RoleId
			,n.ObjectId
			,n.ObjectType
			,n.Note
			,n.IsActive
			,n.CreatedBy
			from Notes n 
			inner join NotesRoleWiseConfiguration nc ON nc.RoleId = n.RoleId and nc.ObjectType = 1221
			where n.ObjectType =1221 
			and n.ObjectId = OrderCTE.OrderId  and nc.ViewNotesByRoleId = '+@RoleIdNvarchar+'
			FOR XML path(''NoteList''),ELEMENTS) AS xml))
,(select cast ((SELECT ''true'' AS [@json:Array], [ReturnPakageMaterialId]
      ,[EnquiryId]
      ,[ProductCode]
      ,[ItemId]
      ,[ItemName]
      ,[PrimaryUnitOfMeasure]
      ,[ProductType]
      ,[ProductQuantity]
      ,[StockInQuantity]
      ,[ItemShortCode]
      ,[ItemType]
  FROM [dbo].[ReturnPakageMaterialView] rpm
   WHERE rpm.EnquiryId = OrderCTE.EnquiryId  
 FOR XML path(''ReturnPakageMaterialList''),ELEMENTS) AS xml))
 , CASE WHEN ReturnPakageMaterialCount > 0 THEN 1 ELSE 0 END AS IsRPMPresent from OrderCTE
LEFT JOIN RPM_CTE ON OrderCTE.EnquiryId = RPM_CTE.EnquiryId

FOR XML PATH(''OrderList''),ELEMENTS,ROOT(''Order'')) AS XML);'

  print @sql1
  print @sql2
  print @sql3
  
  --EXEC sp_executesql @sql
  EXECUTE (@sql1 + @sql2 + @sql3)

  set @sql4 = 'select count(*) as TotalCount FROM [dbo].[Order] o WITH (NOLOCK) LEFT JOIN
[dbo].Location d WITH (NOLOCK) ON o.shipto = d.LocationId LEFT JOIN
[dbo].Company c WITH (NOLOCK) ON c.CompanyId = d.CompanyId LEFT JOIN
[OrderLogisticsViewV2] oV2 on ov2.OrderId=o.OrderId left join
dbo.[TruckInOrder] tio WITH (NOLOCK) on tio.OrderNumber = o.OrderNumber
LEFT JOIN [dbo].[WorkFlowActivityLog] wal  with (nolock) ON o.EnquiryId = wal.EnquiryId and wal.WorkFlowCurrentStatusCode=320
LEFT JOIN dbo.[Login] usr WITH (NOLOCK) on usr.LoginId = o.CreatedBy
WHERE o.IsActive = 1 and '+ @whereClause
	
	print @sql4
	EXECUTE (@sql4)

 end