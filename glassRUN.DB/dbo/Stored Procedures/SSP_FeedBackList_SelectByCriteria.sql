CREATE PROCEDURE [dbo].[SSP_FeedBackList_SelectByCriteria] --'OrderId IN (SELECT OrderId FROM  dbo.[Order] WHERE CustomerId IN (SELECT ReferenceID FROM dbo.UserDetails WHERE  UserID = 10150  AND CurrentState not in (SELECT  [dbo].[fn_LookupIdByValue](''Unscheduled'')))','',gg
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = ' SurveyFormId',
@Output nvarchar(2000) output

AS



--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END



-- ISSUE QUERY
DECLARE @sql nvarchar(4000)


Set @sql='(SELECT CAST((SELECT ''true'' AS [@json:Array] ,OrderFeedbackId, ofb.[OrderId]
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
			   ,[Comment]
			   ,[HVBLComment]
			   ,ofb.[Quantity]
			   ,SalesOrderNumber
			   ,OrderNumber
			   ,CONVERT(varchar(11),OrderDate,103) as OrderDate
			   ,(Select LocationName from Location where LocationId = o.ShipTo) as DeliveryLocationName
			   ,ofb.CreatedDate as CreatedDate
 , (select cast ((SELECT  ''true'' AS [@json:Array] ,ofr.OrderFeedbackId,ofr.ParentOrderFeedbackReplyId,Comment,ofr.CreatedBy,l.Name,CONVERT(varchar(11),ofr.CreatedDate,103) as CreatedDate
		from OrderFeedback ofr left join Login l on ofr.CreatedBy = l.LoginId 
	
   WHERE ofr.IsActive = 1 AND ofr.ParentOrderFeedbackReplyId = ofb.OrderFeedbackId and Isnull(ofr.ParentOrderFeedbackReplyId,0) !=0
 FOR XML path(''OrderFeedbackReplyList''),ELEMENTS) AS xml))

  FROM OrderFeedback ofb join LookUp lu on ofb.feedbackId=lu.LookUpId  
  join [Order] o on o.OrderId = ofb.OrderId
  WHERE ofb.IsActive =1  and  ' + @WhereExpression + '
  and Isnull(ofb.ParentOrderFeedbackReplyId,0)=0
	  FOR XML PATH(''OrderFeedbackList''),ELEMENTS )AS XML))'

 SET @Output=@sql

 PRINT @Output


