
CREATE PROCEDURE [dbo].[SSP_GetEnquiryForSubDApp] --'<Json><ServicesAction>GetEnquiryForSubDApp</ServicesAction><CompanyId>10001</CompanyId><searchValue></searchValue><OrderStatus>Active</OrderStatus><FromDate>07/08/2019</FromDate><EndDate>07/08/2019</EndDate><orderBy></orderBy></Json>'

@xmlDoc XML


AS

BEGIN


declare @companyId bigint
declare @searchValue nvarchar(500)
declare @orderStatus nvarchar(50)
declare @fromDate nvarchar(50)
declare @toDate nvarchar(50)
declare @companyIds nvarchar(500)

DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(max)
Declare @username nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 

@searchValue =tmp.searchValue,
@companyId = tmp.CompanyId,
@orderStatus = tmp.OrderStatus,
@fromDate = tmp.FromDate,
@toDate = tmp.EndDate,
@companyIds = tmp.CompanyIds

	   FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			searchValue nvarchar(500),
			CompanyId bigint,
			OrderStatus nvarchar(50),
			FromDate nvarchar(50),
			EndDate nvarchar(50),
			CompanyIds nvarchar(500)
			)tmp;

If(@orderStatus = 'Active')
Begin
	
	If(@companyIds = '')
	Begin

		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,EnquiryId,
  rownumber,TotalCount,
  EnquiryAutoNumber
  ,SoldTo
	  ,SoldToCode
	  ,SoldToName
	  ,ShipToCode
	  ,ShipToName
	  ,RequestDate
	  ,EnquiryDate
	  ,CurrentStatus
	  ,CurrentStatusClass
	  ,(select cast ((SELECT 'true' AS [@json:Array] , [EnquiryProductId]
,[EnquiryId]
,[ProductCode]
,	i.ItemName as ItemName
,i.ItemId as ItemId
,i.ImageUrl
,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) AS PrimaryUnitOfMeasure
,ISNULL((ep.UnitPrice * ep.ProductQuantity),0) as ItemPrices
,ISNULL((ep.UnitPrice),0) as ItemPricesPerUnit
,ep.[ProductQuantity]
from [EnquiryProduct] ep left join Item i on ep.ProductCode = i.ItemCode
left join UnitOfMeasure umo on I.ItemId=umo.ItemId and i.PrimaryUnitOfMeasure=umo.UOM and umo.RelatedUOM=16 
WHERE ep.IsActive = 1 AND ep.EnquiryId = tmp.EnquiryId 
FOR XML path('EnquiryProductList'),ELEMENTS) AS xml))
      from 
      (SELECT  ROW_NUMBER() OVER (ORDER BY EnquiryId desc) as rownumber , COUNT(*) OVER () as TotalCount, EnquiryId
	  ,EnquiryAutoNumber
	  ,SoldTo
	  ,SoldToCode
	  ,SoldToName
	  ,ShipToCode
	  ,ShipToName
	  ,RequestDate
	  ,EnquiryDate
	  ,(SELECT [dbo].[fn_RoleWiseStatus] (3,CurrentState,1101)) As CurrentStatus
	  ,(SELECT [dbo].[fn_RoleWiseClass] (3,CurrentState)) As CurrentStatusClass
	  from Enquiry WHERE IsActive = 1
	  and CompanyId = @companyId and CurrentState = 1) as tmp
	  WHERE (tmp.EnquiryAutoNumber  like '%'+@searchValue+'%'
	  or tmp.SoldToName  like '%'+@searchValue+'%'
	  ) and (CONVERT(DATETIME,tmp.RequestDate, 103) BETWEEN CONVERT(DATETIME,@fromDate, 103) AND CONVERT(DATETIME,@toDate, 103))
	  order by  tmp.RequestDate desc

	  FOR XML PATH('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)

	End;
	Else
	Begin
		
		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,EnquiryId,
		  rownumber,TotalCount,
		  EnquiryAutoNumber
		  ,SoldTo
			  ,SoldToCode
			  ,SoldToName
			  ,ShipToCode
			  ,ShipToName
			  ,RequestDate
			  ,EnquiryDate
			  ,CurrentStatus
			  ,CurrentStatusClass
			  ,(select cast ((SELECT 'true' AS [@json:Array] , [EnquiryProductId]
		,[EnquiryId]
		,[ProductCode]
		,	i.ItemName as ItemName
		,i.ItemId as ItemId
		,i.ImageUrl
		,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) AS PrimaryUnitOfMeasure
		,ISNULL((ep.UnitPrice * ep.ProductQuantity),0) as ItemPrices
		,ISNULL((ep.UnitPrice),0) as ItemPricesPerUnit
		,ep.[ProductQuantity]
		from [EnquiryProduct] ep left join Item i on ep.ProductCode = i.ItemCode
		left join UnitOfMeasure umo on I.ItemId=umo.ItemId and i.PrimaryUnitOfMeasure=umo.UOM and umo.RelatedUOM=16 
		WHERE ep.IsActive = 1 AND ep.EnquiryId = tmp.EnquiryId 
		FOR XML path('EnquiryProductList'),ELEMENTS) AS xml))
			  from 
			  (SELECT  ROW_NUMBER() OVER (ORDER BY EnquiryId desc) as rownumber , COUNT(*) OVER () as TotalCount, EnquiryId
			  ,EnquiryAutoNumber
			  ,SoldTo
			  ,SoldToCode
			  ,SoldToName
			  ,ShipToCode
			  ,ShipToName
			  ,RequestDate
			  ,EnquiryDate
			  ,(SELECT [dbo].[fn_RoleWiseStatus] (3,CurrentState,1101)) As CurrentStatus
			  ,(SELECT [dbo].[fn_RoleWiseClass] (3,CurrentState)) As CurrentStatusClass
			  from Enquiry WHERE IsActive = 1
			  and CompanyId = @companyId and CurrentState = 1) as tmp
			  WHERE (tmp.EnquiryAutoNumber  like '%'+@searchValue+'%'
			  or tmp.SoldToName  like '%'+@searchValue+'%'
			  ) and (CONVERT(DATETIME,tmp.RequestDate, 103) BETWEEN CONVERT(DATETIME,@fromDate, 103) AND CONVERT(DATETIME,@toDate, 103))
			  and tmp.SoldTo in (SELECT ID FROM [dbo].[fnSplitValues] (@companyIds))
			  order by  tmp.RequestDate desc

			  FOR XML PATH('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)

	End;

End;
Else If(@orderStatus = 'Confirmed')
Begin
	
	If(@companyIds = '')
	Begin

		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,OrderId,
  rownumber,TotalCount,
  EnquiryAutoNumber
  ,SoldTo
	  ,SoldToCode
	  ,SoldToName
	  ,ShipToCode
	  ,ShipToName
	  ,RequestDate
	  ,EnquiryDate
	  ,CurrentStatus
	  ,CurrentStatusClass
	  ,(select cast ((SELECT  'true' AS [@json:Array]  ,  op.OrderProductId As EnquiryProductId,
	  op.OrderId As EnquiryId,ProductCode,ProductQuantity,i.ItemName as ItemName,
 
   i.ItemId as ItemId,i.ImageUrl,

        (SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as PrimaryUnitOfMeasure
    
   ,ISNULL((op.UnitPrice * op.ProductQuantity),0) as ItemPrices
   ,ISNULL((op.UnitPrice),0) as ItemPricesPerUnit

  from OrderProduct op left join Item i on op.ProductCode = i.ItemCode
  WHERE op.IsActive = 1 AND op.OrderId = tmp.OrderId 
 FOR XML path('EnquiryProductList'),ELEMENTS) AS xml))

      from 
      (SELECT  ROW_NUMBER() OVER (ORDER BY EnquiryId desc) as rownumber , COUNT(*) OVER () as TotalCount, OrderId
	  ,OrderNumber As EnquiryAutoNumber
	  ,SoldTo
	  ,SoldToCode
	  ,SoldToName
	  ,ShipToCode
	  ,ShipToName
	  ,ExpectedTimeOfDelivery As RequestDate
	  ,OrderDate As EnquiryDate
	  ,(SELECT [dbo].[fn_RoleWiseStatus] (3,CurrentState,1101)) As CurrentStatus
	  ,(SELECT [dbo].[fn_RoleWiseClass] (3,CurrentState)) As CurrentStatusClass
	  from [Order] WHERE IsActive = 1
	  and CompanyId = @companyId) as tmp
	  WHERE (tmp.EnquiryAutoNumber  like '%'+@searchValue+'%'
	  or tmp.SoldToName  like '%'+@searchValue+'%'
	  ) and (CONVERT(DATETIME,tmp.RequestDate, 103) BETWEEN CONVERT(DATETIME,@fromDate, 103) AND CONVERT(DATETIME,@toDate, 103))
	  order by  tmp.RequestDate desc

	  FOR XML PATH('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)

	End;
	Else
	Begin
		
		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,OrderId,
	  rownumber,TotalCount,
	  EnquiryAutoNumber
	  ,SoldTo
		  ,SoldToCode
		  ,SoldToName
		  ,ShipToCode
		  ,ShipToName
		  ,RequestDate
		  ,EnquiryDate
		  ,CurrentStatus
		  ,CurrentStatusClass
		  ,(select cast ((SELECT  'true' AS [@json:Array]  ,  op.OrderProductId As EnquiryProductId,
		  op.OrderId As EnquiryId,ProductCode,ProductQuantity,i.ItemName as ItemName,
 
	   i.ItemId as ItemId,i.ImageUrl,

			(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) as PrimaryUnitOfMeasure
    
	   ,ISNULL((op.UnitPrice * op.ProductQuantity),0) as ItemPrices
	   ,ISNULL((op.UnitPrice),0) as ItemPricesPerUnit

	  from OrderProduct op left join Item i on op.ProductCode = i.ItemCode
	  WHERE op.IsActive = 1 AND op.OrderId = tmp.OrderId 
	 FOR XML path('EnquiryProductList'),ELEMENTS) AS xml))

		  from 
		  (SELECT  ROW_NUMBER() OVER (ORDER BY EnquiryId desc) as rownumber , COUNT(*) OVER () as TotalCount, OrderId
		  ,OrderNumber As EnquiryAutoNumber
		  ,SoldTo
		  ,SoldToCode
		  ,SoldToName
		  ,ShipToCode
		  ,ShipToName
		  ,ExpectedTimeOfDelivery As RequestDate
		  ,OrderDate As EnquiryDate
		  ,(SELECT [dbo].[fn_RoleWiseStatus] (3,CurrentState,1101)) As CurrentStatus
		  ,(SELECT [dbo].[fn_RoleWiseClass] (3,CurrentState)) As CurrentStatusClass
		  from [Order] WHERE IsActive = 1
		  and CompanyId = @companyId) as tmp
		  WHERE (tmp.EnquiryAutoNumber  like '%'+@searchValue+'%'
		  or tmp.SoldToName  like '%'+@searchValue+'%'
		  ) and (CONVERT(DATETIME,tmp.RequestDate, 103) BETWEEN CONVERT(DATETIME,@fromDate, 103) AND CONVERT(DATETIME,@toDate, 103))
		  and tmp.SoldTo in (SELECT ID FROM [dbo].[fnSplitValues] (@companyIds))
		  order by  tmp.RequestDate desc

		  FOR XML PATH('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)

	End;

End;
Else
Begin
	
	If(@companyIds = '')
	Begin

		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,EnquiryId,
  rownumber,TotalCount,
  EnquiryAutoNumber
  ,SoldTo
	  ,SoldToCode
	  ,SoldToName
	  ,ShipToCode
	  ,ShipToName
	  ,RequestDate
	  ,EnquiryDate
	  ,CurrentStatus
	  ,CurrentStatusClass
	  ,(select cast ((SELECT 'true' AS [@json:Array] , [EnquiryProductId]
,[EnquiryId]
,[ProductCode]
,	i.ItemName as ItemName
,i.ItemId as ItemId
,i.ImageUrl
,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) AS PrimaryUnitOfMeasure
,ISNULL((ep.UnitPrice * ep.ProductQuantity),0) as ItemPrices
,ISNULL((ep.UnitPrice),0) as ItemPricesPerUnit
,ep.[ProductQuantity]
from [EnquiryProduct] ep left join Item i on ep.ProductCode = i.ItemCode
left join UnitOfMeasure umo on I.ItemId=umo.ItemId and i.PrimaryUnitOfMeasure=umo.UOM and umo.RelatedUOM=16 
WHERE ep.IsActive = 1 AND ep.EnquiryId = tmp.EnquiryId 
FOR XML path('EnquiryProductList'),ELEMENTS) AS xml))
      from 
      (SELECT  ROW_NUMBER() OVER (ORDER BY EnquiryId desc) as rownumber , COUNT(*) OVER () as TotalCount, EnquiryId
	  ,EnquiryAutoNumber
	  ,SoldTo
	  ,SoldToCode
	  ,SoldToName
	  ,ShipToCode
	  ,ShipToName
	  ,RequestDate
	  ,EnquiryDate
	  ,(SELECT [dbo].[fn_RoleWiseStatus] (3,CurrentState,1101)) As CurrentStatus
	  ,(SELECT [dbo].[fn_RoleWiseClass] (3,CurrentState)) As CurrentStatusClass
	  from Enquiry WHERE IsActive = 1
	  and CompanyId = @companyId and CurrentState = 999) as tmp
	  WHERE (tmp.EnquiryAutoNumber  like '%'+@searchValue+'%'
	  or tmp.SoldToName  like '%'+@searchValue+'%'
	  ) and (CONVERT(DATETIME,tmp.RequestDate, 103) BETWEEN CONVERT(DATETIME,@fromDate, 103) AND CONVERT(DATETIME,@toDate, 103))
	  order by  tmp.RequestDate desc

	  FOR XML PATH('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)

	End;
	Begin
		
		WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT  'true' AS [@json:Array]  ,EnquiryId,
	  rownumber,TotalCount,
	  EnquiryAutoNumber
	  ,SoldTo
		  ,SoldToCode
		  ,SoldToName
		  ,ShipToCode
		  ,ShipToName
		  ,RequestDate
		  ,EnquiryDate
		  ,CurrentStatus
		  ,CurrentStatusClass
		  ,(select cast ((SELECT 'true' AS [@json:Array] , [EnquiryProductId]
	,[EnquiryId]
	,[ProductCode]
	,	i.ItemName as ItemName
	,i.ItemId as ItemId
	,i.ImageUrl
	,(SELECT [dbo].[fn_LookupValueById] (i.PrimaryUnitOfMeasure)) AS PrimaryUnitOfMeasure
	,ISNULL((ep.UnitPrice * ep.ProductQuantity),0) as ItemPrices
	,ISNULL((ep.UnitPrice),0) as ItemPricesPerUnit
	,ep.[ProductQuantity]
	from [EnquiryProduct] ep left join Item i on ep.ProductCode = i.ItemCode
	left join UnitOfMeasure umo on I.ItemId=umo.ItemId and i.PrimaryUnitOfMeasure=umo.UOM and umo.RelatedUOM=16 
	WHERE ep.IsActive = 1 AND ep.EnquiryId = tmp.EnquiryId 
	FOR XML path('EnquiryProductList'),ELEMENTS) AS xml))
		  from 
		  (SELECT  ROW_NUMBER() OVER (ORDER BY EnquiryId desc) as rownumber , COUNT(*) OVER () as TotalCount, EnquiryId
		  ,EnquiryAutoNumber
		  ,SoldTo
		  ,SoldToCode
		  ,SoldToName
		  ,ShipToCode
		  ,ShipToName
		  ,RequestDate
		  ,EnquiryDate
		  ,(SELECT [dbo].[fn_RoleWiseStatus] (3,CurrentState,1101)) As CurrentStatus
		  ,(SELECT [dbo].[fn_RoleWiseClass] (3,CurrentState)) As CurrentStatusClass
		  from Enquiry WHERE IsActive = 1
		  and CompanyId = @companyId and CurrentState = 999) as tmp
		  WHERE (tmp.EnquiryAutoNumber  like '%'+@searchValue+'%'
		  or tmp.SoldToName  like '%'+@searchValue+'%'
		  ) and (CONVERT(DATETIME,tmp.RequestDate, 103) BETWEEN CONVERT(DATETIME,@fromDate, 103) AND CONVERT(DATETIME,@toDate, 103))
		  and tmp.SoldTo in (SELECT ID FROM [dbo].[fnSplitValues] (@companyIds))
		  order by  tmp.RequestDate desc

		  FOR XML PATH('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)

	End;

End;


END
