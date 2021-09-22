CREATE PROCEDURE [dbo].[SSP_FeedBackList_CustomerApp] ---'<Json><ServicesAction>LoadDistributorDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><UserId>0</UserId></Json>'
(@xmlDoc XML)
AS



BEGIN
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

Declare @PageSize nvarchar(max)
Declare @PageIndex nvarchar(max)
Declare @CompanyId nvarchar(max)
Declare @FromDate  nvarchar(max)
Declare @ToDate  nvarchar(max)
Declare @OrderBy NVARCHAR(20)
declare @WhereExpression nvarchar(2000) = '1=1'
--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END




SELECT
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
	@CompanyId=tmp.[CompanyId],
	@FromDate=tmp.FromDate,
	@ToDate=tmp.EndDate
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [pageIndex] nvarchar(max),
   [pageSize] nvarchar(max),
   CompanyId nvarchar(max),
   FromDate nvarchar(max),
   EndDate nvarchar(max)
           
   )tmp




Set @sql='WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,* , (select cast ((SELECT  ''true'' AS [@json:Array] ,ofr.OrderFeedbackId,ofr.ParentOrderFeedbackReplyId,Comment,ofr.CreatedBy,l.Name,CONVERT(varchar(11),ofr.CreatedDate,103) as CreatedDate
		from OrderFeedback ofr left join Login l on ofr.CreatedBy = l.LoginId 
	
   WHERE ofr.IsActive = 1 AND ofr.ParentOrderFeedbackReplyId = tmp.OrderFeedbackId and Isnull(ofr.ParentOrderFeedbackReplyId,0) !=0
 FOR XML path(''OrderFeedbackReplyList''),ELEMENTS) AS xml))
 from (select 
 ROW_NUMBER() OVER (ORDER BY   ofb.CreatedDate desc) as rownumber , COUNT(*) OVER () as TotalCount,
OrderFeedbackId, ofb.[OrderId]
			   ,[OrderProductId]
			   ,NEWID() as [FeedbackGuId]
			   ,(Select ItemName from item where Itemcode in (Select ProductCode from OrderProduct where OrderProductId = ofb.[OrderProductId])) as ProductName
			   ,Isnull((Select ProductCode from OrderProduct where OrderProductId = ofb.[OrderProductId]),0) as ProductCode
			    ,0 as UOM,
			   ofb.[feedbackId]
			   ,ofb.Field1 As [SubFeedbackId]
			   ,(SELECT [dbo].[fn_LookupValueById] (ofb.[feedbackId])) as FeedbackName
			   ,(SELECT [dbo].[fn_LookupValueById] (ofb.Field1)) as Feedback
			   ,CONVERT(varchar(11),ActualReceiveDate,103) as ActualReceiveDate
			   ,(select Name from Login where LoginId = ofb.CreatedBy) as Name
			   ,Isnull([Comment],''-'') as Comment
			   ,[HVBLComment]
			   ,ofb.[Quantity]
			   ,SalesOrderNumber
			   ,OrderNumber
			   ,CONVERT(varchar(11),OrderDate,103) as OrderDate
			   ,(Select LocationName from Location where LocationId = o.ShipTo) as DeliveryLocationName
			   ,ofb.CreatedDate as CreatedDate
			   ,isnull((Select top 1 CompanyName from Company c where c.CompanyId=Isnull(o.CompanyId,0)),''-'') as SupplierName

  FROM OrderFeedback ofb join LookUp lu on ofb.feedbackId=lu.LookUpId  
  join [Order] o on o.OrderId = ofb.OrderId
  WHERE ofb.IsActive =1  and (o.SoldTo='+@CompanyId+' or '+@CompanyId+'=0) 
  and Isnull(ofb.ParentOrderFeedbackReplyId,0)=0 ) as tmp where ' + @WhereExpression + ' and (CONVERT(DATE,CreatedDate, 103) BETWEEN CONVERT(DATE,'''+@FromDate+''', 103) AND CONVERT(DATE,'''+@ToDate+''', 103))  and '+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
	  FOR XML path(''OrderFeedbackList''),ELEMENTS,ROOT(''Json'')) AS XML)'

  PRINT @sql
   EXEC sp_executesql @sql
END
