CREATE PROCEDURE [dbo].[SSP_GetAllNewDataByCustomerId] --'<Json><ServicesAction>GetAllNewDataByCustomerId</ServicesAction><pageIndex>0</pageIndex><pageSize>15</pageSize><customerId>536</customerId><orderStatus>Active</orderStatus><searchValue></searchValue><ShowEnquiryOrOdrer>All</ShowEnquiryOrOdrer><StartDate>10/07/2019</StartDate><EndDate>22/07/2019</EndDate><orderBy></orderBy><whereExpression></whereExpression></Json>'

@xmlDoc XML


AS

BEGIN

declare @WhereExpression bigint
declare @customerId bigint
declare @rolemasterId bigint
declare @CultureId bigint =1101
declare @orderStatus nvarchar(20)
declare @PageIndex INT
declare @PageSize INT
declare @searchValue nvarchar(500)
declare @ShowEnquiryOROrder nvarchar(100)='0'
DECLARE @StartDate NVARCHAR(150)
DECLARE @EndDate NVARCHAR(150)
Declare @EnquiryDate nvarchar(50)
Declare @EnquiryDateOrdered nvarchar(50)
Declare @RequestedDate nvarchar(50)
Declare @RequestedDateOrdered nvarchar(50)
Declare @Status nvarchar(100)
Declare @StatusOrdered nvarchar(50)
Declare @AreaCount int
set @AreaCount=0;


DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

select *  into #StatusTypeList
			FROM OPENXML(@intpointer,'Json/StatusTypeList',2)
			WITH
			(
				[StatusType] nvarchar(2000)
			)tmp1;

select @AreaCount=count(*) from #StatusTypeList;


SELECT 

@WhereExpression =tmp.WhereExpression,
@customerId=tmp.customerId,
@orderStatus = tmp.orderStatus,
@PageIndex =(tmp.pageIndex),
@PageSize =tmp.pageSize,
@searchValue =tmp.searchValue,
@StartDate = tmp.StartDate,
@EndDate = tmp.EndDate,
@ShowEnquiryOROrder = tmp.ShowEnquiryOROrder,
@EnquiryDate = tmp.EnquiryDate,
@EnquiryDateOrdered = tmp.EnquiryDateOrdered,
@RequestedDate = tmp.RequestedDateOrdered,
@RequestedDateOrdered = tmp.ShowEnquiryOROrder,
@Status = tmp.[Status],
@StatusOrdered = tmp.StatusOrdered

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			WhereExpression bigint,
			customerId bigint,
			orderStatus nvarchar(20),
			pageIndex INT,
			pageSize INT,
			searchValue nvarchar(500),
			StartDate nvarchar(100),
			EndDate nvarchar(100),
			ShowEnquiryOROrder nvarchar(100),
			EnquiryDate nvarchar(50),
			EnquiryDateOrdered nvarchar(50),
			RequestedDate nvarchar(50),
			RequestedDateOrdered nvarchar(50),
			[Status] nvarchar(50),
			StatusOrdered nvarchar(50)
			)tmp;




Select @rolemasterId=4

set @PageIndex =@PageIndex+1;


print @orderStatus
print @ShowEnquiryOROrder


if @AreaCount>0
   Begin



if @orderStatus = 'Active'
begin
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
SELECT CAST((SELECT   'true' AS [@json:Array], * from 
 (SELECT 
  1 as rownumber,
 o.[OrderId] as IntOrderId
      ,  0 as [SupplierLOBId]
      , o.SoldTo as  CustomerId
	  ,o.ShipTo
	  ,o.ShipToCode
	  ,(select LocationName from Location where LocationCode = o.ShipToCode) as ShipToName
 , o.OrderType  as  [VcOrderType]
	  ,(select EnquiryAutoNumber from enquiry where EnquiryId = o.EnquiryId) as EnquiryAutoNumber
      ,o.[OrderNumber] as VcOrderNumber
      ,o.[PurchaseOrderNumber] as VcPurchaseOrderNumber
      ,o.[SalesOrderNumber] as VcSalesOrderNumber
      
      ,o.OrderDate as  DtRequestedDateOfDelivery
	  ,o.ExpectedTimeOfDelivery as DtExpectedDateOfDelivery
      ,(Select top 1 om.ActualTimeOfAction from Ordermovement om where om.LocationType=2 and om.Orderid=o.orderid)  as DtActualDateOfDelivery
	 ,(select top 1 CompanyName from Company where CompanyId = o.CompanyId) as SupplierName
      ,o.[PreviousState]
		
	,(SELECT [dbo].[fn_RoleWiseStatus] (@rolemasterId,o.CurrentState,@CultureId)) AS 'VcCurrentState',
  (SELECT [dbo].[fn_RoleWiseClass] (@rolemasterId,o.CurrentState)) AS 'Class'

      ,o.[NextState]
     
      ,o.[IsActive]
      ,o.[CreatedBy]
      ,o.[CreatedDate]
    
	   ,c.CompanyName AS VcCustomerName
	   ,(select EnquiryDate from enquiry where EnquiryId = o.EnquiryId) as EnquiryDate
	, o.OrderDate as OrderDate
 ,(select  top 1 LocationName from [Location] where CompanyID=o.SoldTo) As VcDeliveryLocation,
 
(SELECT top 1 LocationName FROM  [Location] WHERE LocationId IN (SELECT Location FROM  dbo.OrderMovement WHERE OrderId=o.OrderId and locationtype=1) ) as StockLocation


 FROM [ORDER] o left JOIN Company c ON c.CompanyId = o.SoldTo
  WHERE  o.IsActive = 1   AND c.IsActive = 1 and o.OrderType not in ('S3','S4','S5','SG','ST')   
 and o.SoldTo IN (select ReferenceID From Login where LoginId= @customerId) 
 and o.CurrentState <> 103


  

  union

  Select * from 
 (
 SELECT 
2 as rownumber,
 o.[EnquiryId] as IntOrderId    ,
 0 as [SupplierLOBId]      ,
 o.SoldTo as CustomerId   ,
 o.ShipTo,
 o.ShipToCode,
 (select LocationName from Location where LocationCode = o.ShipToCode) as ShipToName,
o.EnquiryType  as  [VcOrderType],
	  o.[EnquiryAutoNumber]  as EnquiryAutoNumber    ,
 o.[EnquiryAutoNumber]  as VcOrderNumber    ,
 o.[PONumber]  as VcPurchaseOrderNumber    ,
 o.EnquiryAutoNumber as VcSalesOrderNumber
 ,   o.EnquiryDate as   DtRequestedDateOfDelivery	  ,
 ISNULL(o.PromisedDate,o.RequestDate) as   DtExpectedDateOfDelivery      ,
ISNULL(o.PromisedDate,o.RequestDate) as DtActualDateOfDelivery	   ,
 o.[PreviousState]

	,(SELECT [dbo].[fn_RoleWiseStatus] (@rolemasterId,o.CurrentState,@CultureId)) AS 'VcCurrentState',
  (SELECT [dbo].[fn_RoleWiseClass] (@rolemasterId,o.CurrentState)) AS 'Class'
  ,(select top 1 CompanyName from Company where CompanyId = o.CompanyId) as SupplierName
  ,o.PreviousState [NextState]      ,
	  o.[IsActive]      ,
	  o.[CreatedBy]
      ,o.[CreatedDate] ,
	   c.CompanyName AS VcCustomerName
	, o.EnquiryDate as OrderDate
	, o.EnquiryDate as EnquiryDate
 ,(select  top 1 LocationName from [Location] where CompanyID=o.SoldTo) As VcDeliveryLocation,

 
 (SELECT top 1 LocationName FROM  [Location] WHERE LocationCode IN (o.CollectionLocationCode)) as StockLocation

 FROM Enquiry o left JOIN Company c ON c.CompanyId = o.SoldTo

 WHERE  o.IsActive = 1   AND c.IsActive = 1 
  and o.SoldTo IN (select ReferenceID From Login where LoginId= @customerId)
 and o.EnquiryId not in (Select isnull(EnquiryId,0) from [order])
 )child 
 
 ) OrderList where 
 (rownumber=@ShowEnquiryOROrder or @ShowEnquiryOROrder=0) and
 (OrderList.VcOrderNumber  like '%'+@searchValue+'%' or OrderList.VcCurrentState like '%'+@searchValue+'%' 
 or OrderList.EnquiryAutoNumber like '%'+@searchValue+'%'  or OrderList.ShipToCode like '%'+@searchValue+'%'
 or OrderList.ShipToName  like '%'+@searchValue+'%' )
 and OrderList.VcCurrentState in ( select StatusType from  #StatusTypeList) 

  order by  OrderList.OrderDate desc

OFFSET @PageSize * (@PageIndex - 1) ROWS
  FETCH NEXT @PageSize ROWS ONLY

FOR XML path('AsnInfosList'),ELEMENTS,ROOT('AsnInfos')) AS XML)
end
else if @orderStatus = 'Completed'
begin
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
SELECT CAST((SELECT   'true' AS [@json:Array], * from 
 (SELECT 
  1 as rownumber,
 o.[OrderId] as IntOrderId
      ,  0 as [SupplierLOBId]
      , o.SoldTo as  CustomerId
	  ,o.ShipTo
	  ,o.ShipToCode
	  ,(select LocationName from Location where LocationCode = o.ShipToCode) as ShipToName
 , o.OrderType  as  [VcOrderType]
	  ,(select EnquiryAutoNumber from enquiry where EnquiryId = o.EnquiryId) as EnquiryAutoNumber
      ,o.[OrderNumber] as VcOrderNumber
      ,o.[PurchaseOrderNumber] as VcPurchaseOrderNumber
      ,o.[SalesOrderNumber] as VcSalesOrderNumber
      
      ,o.OrderDate as  DtRequestedDateOfDelivery
	  ,o.ExpectedTimeOfDelivery as DtExpectedDateOfDelivery
      ,(Select top 1 om.ActualTimeOfAction from Ordermovement om where om.LocationType=2 and om.Orderid=o.orderid) as  DtActualDateOfDelivery
	 ,(select top 1 CompanyName from Company where CompanyId = o.CompanyId) as SupplierName
      ,o.[PreviousState]
			,(SELECT [dbo].[fn_RoleWiseStatus] (@rolemasterId,o.CurrentState,@CultureId)) AS 'VcCurrentState',
  (SELECT [dbo].[fn_RoleWiseClass] (@rolemasterId,o.CurrentState)) AS 'Class'
      ,o.[NextState]
     
      ,o.[IsActive]
      ,o.[CreatedBy]
      ,o.[CreatedDate]
    
	   ,c.CompanyName AS VcCustomerName
	, o.OrderDate as OrderDate
	 ,(select EnquiryDate from enquiry where EnquiryId = o.EnquiryId) as EnquiryDate
 ,(select  top 1 LocationName from [Location] where CompanyID=o.SoldTo) As VcDeliveryLocation,
 
(SELECT top 1 LocationName FROM  [Location] WHERE LocationId IN (SELECT Location FROM  dbo.OrderMovement WHERE OrderId=o.OrderId and locationtype=1) ) as StockLocation


 FROM [ORDER] o left JOIN Company c ON c.CompanyId = o.SoldTo
  WHERE  o.IsActive = 1   AND c.IsActive = 1 and o.OrderType not in ('S3','S4','S5','SG','ST')  
 and o.SoldTo IN (select ReferenceID From Login where LoginId= @customerId) 

 and o.CurrentState = 103

 
 ) OrderList where (OrderList.VcOrderNumber  like '%'+@searchValue+'%' or OrderList.VcCurrentState like '%'+@searchValue+'%' 
  or OrderList.EnquiryAutoNumber like '%'+@searchValue+'%' 
  or OrderList.ShipToCode like '%'+@searchValue+'%'
  or OrderList.ShipToName  like '%'+@searchValue+'%')
 
  order by  OrderList.OrderDate desc

OFFSET @PageSize * (@PageIndex - 1) ROWS
  FETCH NEXT @PageSize ROWS ONLY

FOR XML path('AsnInfosList'),ELEMENTS,ROOT('AsnInfos')) AS XML)
end
END
else
BEGIN
	if @orderStatus = 'Active'
begin
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
SELECT CAST((SELECT   'true' AS [@json:Array], * from 
 (SELECT 
  1 as rownumber,
 o.[OrderId] as IntOrderId
      ,  0 as [SupplierLOBId]
      , o.SoldTo as  CustomerId
	  ,o.ShipTo
	  ,o.ShipToCode
	  ,(select LocationName from Location where LocationCode = o.ShipToCode) as ShipToName
 , o.OrderType  as  [VcOrderType]
	  ,(select EnquiryAutoNumber from enquiry where EnquiryId = o.EnquiryId) as EnquiryAutoNumber
      ,o.[OrderNumber] as VcOrderNumber
      ,o.[PurchaseOrderNumber] as VcPurchaseOrderNumber
      ,o.[SalesOrderNumber] as VcSalesOrderNumber
      
      ,o.OrderDate as  DtRequestedDateOfDelivery
	  ,o.ExpectedTimeOfDelivery as DtExpectedDateOfDelivery
      ,(Select top 1 om.ActualTimeOfAction from Ordermovement om where om.LocationType=2 and om.Orderid=o.orderid)  as DtActualDateOfDelivery
	 
      ,o.[PreviousState]
		
	,(SELECT [dbo].[fn_RoleWiseStatus] (@rolemasterId,o.CurrentState,@CultureId)) AS 'VcCurrentState',
  (SELECT [dbo].[fn_RoleWiseClass] (@rolemasterId,o.CurrentState)) AS 'Class'
  ,(select top 1 CompanyName from Company where CompanyId = o.CompanyId) as SupplierName
      ,o.[NextState]
     
      ,o.[IsActive]
      ,o.[CreatedBy]
      ,o.[CreatedDate]
    
	   ,c.CompanyName AS VcCustomerName
	   ,(select EnquiryDate from enquiry where EnquiryId = o.EnquiryId) as EnquiryDate
	, o.OrderDate as OrderDate
 ,(select  top 1 LocationName from [Location] where CompanyID=o.SoldTo) As VcDeliveryLocation,
 
(SELECT top 1 LocationName FROM  [Location] WHERE LocationId IN (SELECT Location FROM  dbo.OrderMovement WHERE OrderId=o.OrderId and locationtype=1) ) as StockLocation


 FROM [ORDER] o left JOIN Company c ON c.CompanyId = o.SoldTo
  WHERE  o.IsActive = 1   AND c.IsActive = 1 and o.OrderType not in ('S3','S4','S5','SG','ST')   
 and o.SoldTo IN (select ReferenceID From Login where LoginId= @customerId) 
 and o.CurrentState <> 103


  

  union

  Select * from 
 (
 SELECT 
2 as rownumber,
 o.[EnquiryId] as IntOrderId    ,
 0 as [SupplierLOBId]      ,
 o.SoldTo as CustomerId   ,
 o.ShipTo,
 o.ShipToCode,
 (select LocationName from Location where LocationCode = o.ShipToCode) as ShipToName,
o.EnquiryType  as  [VcOrderType],
	  o.[EnquiryAutoNumber]  as EnquiryAutoNumber    ,
 o.[EnquiryAutoNumber]  as VcOrderNumber    ,
 o.[PONumber]  as VcPurchaseOrderNumber    ,
 o.EnquiryAutoNumber as VcSalesOrderNumber
 ,   o.EnquiryDate as   DtRequestedDateOfDelivery	  ,
 ISNULL(o.PromisedDate,o.RequestDate) as   DtExpectedDateOfDelivery      ,
ISNULL(o.PromisedDate,o.RequestDate) as DtActualDateOfDelivery	   ,
 o.[PreviousState]

	,(SELECT [dbo].[fn_RoleWiseStatus] (@rolemasterId,o.CurrentState,@CultureId)) AS 'VcCurrentState',
  (SELECT [dbo].[fn_RoleWiseClass] (@rolemasterId,o.CurrentState)) AS 'Class'
  ,(select top 1 CompanyName from Company where CompanyId = o.CompanyId) as SupplierName
  ,o.PreviousState [NextState]      ,
	  o.[IsActive]      ,
	  o.[CreatedBy]
      ,o.[CreatedDate] ,
	   c.CompanyName AS VcCustomerName
	, o.EnquiryDate as OrderDate
	, o.EnquiryDate as EnquiryDate
 ,(select  top 1 LocationName from [Location] where CompanyID=o.SoldTo) As VcDeliveryLocation,

 
 (SELECT top 1 LocationName FROM  [Location] WHERE LocationCode IN (o.CollectionLocationCode)) as StockLocation

 FROM Enquiry o left JOIN Company c ON c.CompanyId = o.SoldTo

 WHERE  o.IsActive = 1   AND c.IsActive = 1 
  and o.SoldTo IN (select ReferenceID From Login where LoginId= @customerId)
 and o.EnquiryId not in (Select isnull(EnquiryId,0) from [order])
 )child 
 
 ) OrderList where 
 (rownumber=@ShowEnquiryOROrder or @ShowEnquiryOROrder=0) and
 (OrderList.VcOrderNumber  like '%'+@searchValue+'%' or OrderList.VcCurrentState like '%'+@searchValue+'%' 
 or OrderList.EnquiryAutoNumber like '%'+@searchValue+'%'  or OrderList.ShipToCode like '%'+@searchValue+'%'
 or OrderList.ShipToName  like '%'+@searchValue+'%' )

  order by  OrderList.OrderDate desc

OFFSET @PageSize * (@PageIndex - 1) ROWS
  FETCH NEXT @PageSize ROWS ONLY

FOR XML path('AsnInfosList'),ELEMENTS,ROOT('AsnInfos')) AS XML)
end
else if @orderStatus = 'Completed'
begin
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
SELECT CAST((SELECT   'true' AS [@json:Array], * from 
 (SELECT 
  1 as rownumber,
 o.[OrderId] as IntOrderId
      ,  0 as [SupplierLOBId]
      , o.SoldTo as  CustomerId
	  ,o.ShipTo
	  ,o.ShipToCode
	  ,(select LocationName from Location where LocationCode = o.ShipToCode) as ShipToName
 , o.OrderType  as  [VcOrderType]
	  ,(select EnquiryAutoNumber from enquiry where EnquiryId = o.EnquiryId) as EnquiryAutoNumber
      ,o.[OrderNumber] as VcOrderNumber
      ,o.[PurchaseOrderNumber] as VcPurchaseOrderNumber
      ,o.[SalesOrderNumber] as VcSalesOrderNumber
      
      ,o.OrderDate as  DtRequestedDateOfDelivery
	  ,o.ExpectedTimeOfDelivery as DtExpectedDateOfDelivery
      ,(Select top 1 om.ActualTimeOfAction from Ordermovement om where om.LocationType=2 and om.Orderid=o.orderid) as  DtActualDateOfDelivery
	 
      ,o.[PreviousState]
			,(SELECT [dbo].[fn_RoleWiseStatus] (@rolemasterId,o.CurrentState,@CultureId)) AS 'VcCurrentState',
  (SELECT [dbo].[fn_RoleWiseClass] (@rolemasterId,o.CurrentState)) AS 'Class'
  ,(select top 1 CompanyName from Company where CompanyId = o.CompanyId) as SupplierName
      ,o.[NextState]
     
      ,o.[IsActive]
      ,o.[CreatedBy]
      ,o.[CreatedDate]
    
	   ,c.CompanyName AS VcCustomerName
	, o.OrderDate as OrderDate
	 ,(select EnquiryDate from enquiry where EnquiryId = o.EnquiryId) as EnquiryDate
 ,(select  top 1 LocationName from [Location] where CompanyID=o.SoldTo) As VcDeliveryLocation,
 
(SELECT top 1 LocationName FROM  [Location] WHERE LocationId IN (SELECT Location FROM  dbo.OrderMovement WHERE OrderId=o.OrderId and locationtype=1) ) as StockLocation


 FROM [ORDER] o left JOIN Company c ON c.CompanyId = o.SoldTo
  WHERE  o.IsActive = 1   AND c.IsActive = 1 and o.OrderType not in ('S3','S4','S5','SG','ST')  
 and o.SoldTo IN (select ReferenceID From Login where LoginId= @customerId) 

 and o.CurrentState = 103

 
 ) OrderList where (OrderList.VcOrderNumber  like '%'+@searchValue+'%' or OrderList.VcCurrentState like '%'+@searchValue+'%' 
  or OrderList.EnquiryAutoNumber like '%'+@searchValue+'%' 
  or OrderList.ShipToCode like '%'+@searchValue+'%'
  or OrderList.ShipToName  like '%'+@searchValue+'%')
 
  order by  OrderList.OrderDate desc

OFFSET @PageSize * (@PageIndex - 1) ROWS
  FETCH NEXT @PageSize ROWS ONLY

FOR XML path('AsnInfosList'),ELEMENTS,ROOT('AsnInfos')) AS XML)
end
END

END
