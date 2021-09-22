CREATE PROCEDURE [dbo].[SSP_MarineLOBDeliveryLocationList_SelectByCriteriaPagingOnlyDelieverd]--47 ,0,15,''
@WhereExpression bigint,
@PageIndex INT,
@PageSize INT,
@searchValue nvarchar(500)


AS


set @PageIndex =@PageIndex+1

-- ISSUE QUERY
DECLARE @sql NVARCHAR(max)
(SELECT CAST((
 
 Select * from 
 (SELECT 
  0 as rownumber,
 o.[OrderId]
      ,  0 as [SupplierLOBId]
      , o.SoldTo as  CustomerId
      ,  (select dbo.fn_AppLookupIdByValue('pack'))   as  [OrderType]
	  , (select dbo.fn_AppLookupIdByValue('Land'))   as  ModeOfDelivery
      ,o.[OrderNumber]
      ,o.[PurchaseOrderNumber]
      ,o.[SalesOrderNumber]
      
      ,o.OrderDate as  RequestedDateOfDelivery
	  ,o.ExpectedTimeOfDelivery as ExpectedDateOfDelivery
      ,o.ExpectedTimeOfDelivery as [ActualDateOfDelivery]
	 
      ,o.[PreviousState]
      ,CASE 
       WHEN (CurrentState =3 or  CurrentState=4  or  CurrentState=5   ) THEN 43
			WHEN (CurrentState =41 or  CurrentState=42    )THEN 41
       		ELSE [CurrentState]
		END as [CurrentState]
      ,o.[NextState]
     
      ,o.[IsActive]
      ,o.[CreatedBy]
      ,o.[CreatedDate]
    
	   ,c.CompanyName AS CustomerName
	, o.OrderDate as OrderDate
 ,(select  top 1 LocationName from [Location] where CompanyID=o.SoldTo) As DeliveryLocation,
 
--  mdl.Remarks,
   --(SELECT TOP 1 VesselEmail FROM  dbo.VesselInformation WHERE CustomerId=o.CustomerId AND VesselName COLLATE DATABASE_DEFAULT=mdl.VesselName COLLATE DATABASE_DEFAULT) AS VesselEmail,
(SELECT top 1 LocationName FROM  [Location] WHERE LocationId IN (SELECT Location FROM  dbo.OrderMovement WHERE OrderId=o.OrderId and locationtype=(SELECT  [dbo].[fn_AppLookupIdByValue]('CollectionStop'))) ) as StockLocation
 ,CASE 
       WHEN (CurrentState =3 or  CurrentState=4  or  CurrentState=5   ) THEN 'Unscheduled'
		WHEN (CurrentState =37 or  CurrentState=39    )THEN 'In Progress'
		WHEN (CurrentState =41 or  CurrentState=42    )THEN 'Scheduled'
       		ELSE ''
		END AS CollectionSorting



 FROM [ORDER] o left JOIN Company c ON c.CompanyId = o.SoldTo

 WHERE  o.IsActive = 1   AND c.IsActive = 1  and o.SalesOrderNumber is not null  
 
  and o.[SalesOrderNumber] in ( 
  SELECT distinct o.[SalesOrderNumber]
 FROM [ORDER] o left JOIN Company c ON c.CompanyId = o.SoldTo
 WHERE  o.IsActive = 1   AND c.IsActive = 1 and o.SoldTo IN (SELECT ReferenceID FROM dbo.Profile  WHERE  ProfileId in (select ProfileId From Login where LoginId= @WhereExpression)   )
  AND currentstate not in ((SELECT  [dbo].[fn_AppLookupIdByValue]('Completed')),34) ) 
  

  union

  Select * from 
 (
 SELECT 
 ROW_NUMBER() OVER (ORDER BY   o.OrderDate desc) as rownumber,
 o.[OrderId]     ,
 0 as [SupplierLOBId]      ,
 o.SoldTo as CustomerId   ,
    (select dbo.fn_LookupIdByValue('pack'))   as  [OrderType],
	  (select dbo.fn_LookupIdByValue('Land'))   as  ModeOfDelivery,
 o.[OrderNumber]      ,
 o.[PurchaseOrderNumber]      ,
 o.[SalesOrderNumber]
 ,   o.OrderDate as   [RequestedDateOfDelivery]	  ,
 o.ExpectedTimeOfDelivery as   ExpectedDateOfDelivery      ,
o.ExpectedTimeOfDelivery as [ActualDateOfDelivery]	   ,
 o.[PreviousState]
      ,40 as [CurrentState]      ,
	  o.[NextState]      ,
	  o.[IsActive]      ,
	  o.[CreatedBy]
      ,o.[CreatedDate]      ,
	   c.CompanyName AS CustomerName
	, o.OrderDate as OrderDate
 ,(select  top 1 LocationName from [Location] where CompanyID=o.SoldTo) As DeliveryLocation,

 
 (SELECT top 1 LocationName FROM  [Location] WHERE LocationId IN (SELECT Location FROM  dbo.OrderMovement WHERE OrderId=o.OrderId and locationtype=1) ) as StockLocation,
'Completed' as CollectionSorting
 FROM [ORDER] o left JOIN Company c ON c.CompanyId = o.SoldTo

 WHERE  o.IsActive = 1   AND c.IsActive = 1    and o.SalesOrderNumber is not null
 
  and o.[SalesOrderNumber] in ( 
  SELECT distinct o.[SalesOrderNumber]
 FROM [ORDER] o left JOIN Company c ON c.CompanyId = o.SoldTo
 WHERE  o.IsActive = 1   AND c.IsActive = 1 
 and o.SoldTo IN (SELECT ReferenceID FROM dbo.Profile  WHERE  ProfileId  in (select ProfileId From Login where LoginId= @WhereExpression)  )
 AND currentstate in (SELECT  [dbo].[fn_AppLookupIdByValue]('Completed'))  


  ))child 
  where child.[rownumber] BETWEEN (@PageSize * (@PageIndex-1) + 1)  AND (@PageIndex * @PageSize)
  
 
 ) OrderList where (OrderList.salesordernumber  like '%'+@searchValue+'%' or OrderList.CollectionSorting like '%'+@searchValue+'%' )
  order by orderlist.PreviousState asc, OrderList.OrderDate desc
  FOR XML RAW('MarineLOBDeliveryLocationList'),ELEMENTS,ROOT('MarineAllDetail')) AS XML))