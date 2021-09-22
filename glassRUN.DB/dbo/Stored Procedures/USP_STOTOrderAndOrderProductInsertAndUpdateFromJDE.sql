CREATE PROCEDURE [dbo].[USP_STOTOrderAndOrderProductInsertAndUpdateFromJDE] --'<Json> <OrderList> <SalesOrderNumber>18270819</SalesOrderNumber> <OrderNumber>18270819</OrderNumber> <PONumber>17002676</PONumber> <ExpectedTimeOfDelivery>118059</ExpectedTimeOfDelivery> <OrderDate>118059</OrderDate> <SoldTo>32</SoldTo> <ShipTo>32</ShipTo> <OrderType>ST</OrderType> <StockLocationId>        0710</StockLocationId> </OrderList></Json>'

@xmlDoc xml

AS
BEGIN 
SET ARITHABORT ON 
DECLARE @TranName NVARCHAR(255)
DECLARE @ErrMsg NVARCHAR(2048)
DECLARE @ErrSeverity INT;
DECLARE @intPointer INT;
SET @ErrSeverity = 15; 

BEGIN TRY

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT * INTO #tmpOrderList
FROM OPENXML(@intpointer,'Json/OrderList',2)
WITH
(

OrderNumber nvarchar(500), 
SalesOrderNumber nvarchar(200), 
ExpectedTimeOfDelivery nvarchar(250),
OrderDate nvarchar(250),
SoldTo bigint,
ShipTo bigint,
OrderType nvarchar(50),
PurchaseOrderNumber nvarchar(50),
StockLocationId nvarchar(250),
PONumber nvarchar(250),
CarrierNumber nvarchar(150)
) tmp




SELECT * INTO #tmpOrderProductList
FROM OPENXML(@intpointer,'Json/OrderProductList',2)
WITH
(
OrderNumber nvarchar(500),
ProductCode nvarchar(500), 
ProductQuantity nvarchar(200), 
UnitPrice nvarchar(500),
SequenceNo nvarchar(250)

) tmp



select * from #tmpOrderList
select * from #tmpOrderProductList

PRINT N'Insert Order'

INSERT INTO [dbo].[Order]
([OrderNumber]
,[SalesOrderNumber]
,[OrderType]
,ExpectedTimeOfDelivery
,OrderDate
,StockLocationId
,[SoldTo]
,[ShipTo]
,CarrierNumber
,CurrentState
,PurchaseOrderNumber 
,IsActive
,CreatedBy
,CreatedDate

)
SELECT
#tmpOrderList.OrderNumber
, #tmpOrderList.SalesOrderNumber
,#tmpOrderList.OrderType
,[dbo].[JULTODMY](#tmpOrderList.ExpectedTimeOfDelivery)
,[dbo].[JULTODMY](#tmpOrderList.OrderDate)
,#tmpOrderList.StockLocationId
,(select top 1 LocationId from Location where LocationCode=#tmpOrderList.ShipTo)
,(select top 1 LocationId from Location where LocationCode=#tmpOrderList.ShipTo)
,(Select top 1 CompanyId from Company Where CompanyMnemonic=#tmpOrderList.CarrierNumber)
,(Select top 1 LookUpId from LookUp where Code='OrderCreated')
,#tmpOrderList.PONumber
,1 
,1 
,GETDATE()

FROM #tmpOrderList left join [Order] o on o.OrderNumber=#tmpOrderList.OrderNumber  and o.OrderType='ST'
where o.OrderId is null 




print N'Update  Order   carrrier'


update [order]  set CarrierNumber   = c.CompanyId

FROM #tmpOrderList left join [Order] o on o.OrderNumber=#tmpOrderList.OrderNumber  and o.OrderType='ST'
left join Company  c  on c.CompanyMnemonic=#tmpOrderList.CarrierNumber

where o.OrderId is not null and c.CompanyId is not null






PRINT N'Insert OrderProduct'

INSERT INTO [dbo].[OrderProduct]
([ProductCode]
,OrderId
,[ProductQuantity]
,UnitPrice
,LineNumber 
,IsActive
,CreatedBy
,CreatedDate

)
SELECT
#tmpOrderProductList.[ProductCode]
,o.OrderId
,cast( #tmpOrderProductList.[ProductQuantity] as decimal)/10000
,cast(#tmpOrderProductList.UnitPrice as decimal)/10000
,#tmpOrderProductList.SequenceNo 
,1 
,1 
,GETDATE()

FROM #tmpOrderProductList left join [Order] o on o.OrderNumber=#tmpOrderProductList.OrderNumber   and o.OrderType='ST'
left join OrderProduct op on op.ProductCode=#tmpOrderProductList.[ProductCode] and op.OrderId =o.OrderId
where op.OrderId is null and op.OrderProductId is null




DECLARE @orderMovementId bigint

INSERT INTO [dbo].[orderMovement] ([OrderId],LocationType,PraposedTimeOfAction,PraposedShift,[IsActive],[CreatedBy],[CreatedDate])
SELECT o.OrderId,1, NULL ,NULL,1,1,getdate() from #tmpOrderList left join [Order] o on o.OrderNumber=#tmpOrderList.OrderNumber and   o.OrderType='ST' 
left join [OrderMovement] om on o.OrderId=om.OrderId 
where om.OrderId is null and om.OrderMovementId is null

--SELECT @orderMovementId = @@IDENTITY 


--SELECT OrderProductId,ProductQuantity,ROW_NUMBER() OVER (ORDER BY OrderProductId) AS rownum INTO #tmpOrderProduct FROM dbo.[OrderProduct] WHERE OrderId=@OrderId

DECLARE @orderProductId BIGINT
DECLARE @quantity DECIMAL(18,2)

DECLARE @totalRecords BIGINT
DECLARE @RecordCount BIGINT
SELECT @RecordCount = 1

--SELECT @totalRecords = COUNT(OrderProductId) FROM #tmpOrderProduct

--WHILE (@RecordCount <= @totalRecords)

--BEGIN
--SELECT @orderProductId=OrderProductId,@quantity=ProductQuantity FROM #tmpOrderProduct WHERE rownum=@RecordCount

INSERT INTO [dbo].OrderProductMovement (OrderId,OrderProductId,OrderMovementId,PlannedQuantity,ActualQuantity,[IsActive],[CreatedBy],[CreatedDate])
Select o.OrderId ,op.OrderProductId,om.OrderMovementId, #tmpOrderProductList.[ProductQuantity]/10000, #tmpOrderProductList.[ProductQuantity]/10000,1,1,GETDATE()
FROM #tmpOrderProductList left join [Order] o on o.OrderNumber=#tmpOrderProductList.OrderNumber  and o.OrderType='ST'
left join OrderProduct op on op.ProductCode=#tmpOrderProductList.[ProductCode] and op.OrderId=o.OrderId left join OrderMovement om on om.OrderId=o.OrderId 
left join OrderProductMovement opm on opm.OrderMovementId=om.OrderMovementId
where opm.OrderProductMovementId is null

--set @RecordCount=@RecordCount+1
--END













SELECT 1 as CompanyId FOR XML RAW('Json'),ELEMENTS
exec sp_xml_removedocument @intPointer
END TRY
BEGIN CATCH
SELECT @ErrMsg = ERROR_MESSAGE();
RAISERROR(@ErrMsg, @ErrSeverity, 1);
RETURN; 
END CATCH
END

PRINT 'Successfully created procedure dbo.USP_ItemStock'
