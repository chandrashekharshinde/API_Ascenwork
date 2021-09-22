CREATE PROCEDURE [dbo].[SSP_LoadFeedback_ByOrderId] --'<Json><ServicesAction>LoadFeedbackByOrderId</ServicesAction><OrderId>13252</OrderId><OrderFeedbackId>0</OrderFeedbackId><RoleId>4</RoleId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
declare @orderId bigint=0
declare @OrderFeedbackId bigint=0
declare @RoleId bigint
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @orderId = tmp.[OrderId],
	   @RoleId = tmp.[RoleId],
	   @OrderFeedbackId = tmp.[OrderFeedbackId]
	
	 

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[OrderId] bigint,
			[RoleId] bigint,
			[OrderFeedbackId] bigint
			)tmp;

			If @RoleId=4
			BEGIN
			    update OrderFeedbackReply set IsRead = 1 where OrderFeedbackId in (select OrderFeedbackId from OrderFeedback where OrderId  = @orderId) 
			END
		Else 
			Begin
				update OrderFeedback set IsRead = 1 where OrderId = @orderId
			End
Print @RoleId;

			 
			

;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
SELECT CAST((SELECT 'true' AS [@json:Array], OrderFeedbackId, ofb.[OrderId]
			   ,[OrderProductId]
			   ,NEWID() as [FeedbackGuId]
			   ,(Select ItemName from item where Itemcode in (Select ProductCode from OrderProduct where OrderProductId = ofb.[OrderProductId])) as ProductName
			   ,Isnull((Select ProductCode from OrderProduct where OrderProductId = ofb.[OrderProductId]),0) as ProductCode
			   ,(Select ReturnQuantity from OrderProduct where OrderProductId = ofb.[OrderProductId]) as ReturnQuantity
			    ,(SELECT [dbo].[fn_LookupValueById] ((Select PrimaryUnitOfMeasure from item where Itemcode in (Select ProductCode from OrderProduct where OrderProductId = ofb.[OrderProductId])))) as UOM,
			   ofb.[feedbackId]
			   ,ofb.Field1 As [SubFeedbackId]
			   ,(SELECT [dbo].[fn_LookupValueById] (ofb.[feedbackId])) as FeedbackName
			   ,(SELECT [dbo].[fn_LookupValueById] (ofb.Field1)) as Feedback
			   ,CONVERT(varchar(11),ActualReceiveDate,103) as ActualReceiveDate
			   ,[Attachment]
			   ,(select Name from Login where LoginId = ofb.CreatedBy) as Name
			   ,[Comment]
			   ,[HVBLComment]
			   ,ofb.[Quantity]
			   ,SalesOrderNumber
			   ,OrderNumber
			   ,CONVERT(varchar(11),OrderDate,103) as OrderDate
			   ,(Select LocationName from Location where LocationId = o.ShipTo) as DeliveryLocationName
			   ,ofb.CreatedDate as CreatedDate
			    , (select cast ((SELECT  'true' AS [@json:Array] , DocumentsId,DocumentName,DocumentExtension,DocumentBase64,ObjectId,ObjectType
		from Documents 
   WHERE IsActive = 1 AND ObjectId = ofb.OrderFeedbackId 
 FOR XML path('DocumentsList'),ELEMENTS) AS xml))
 , (select cast ((SELECT  'true' AS [@json:Array] ,ofr.OrderFeedbackId,ofr.ParentOrderFeedbackReplyId,Comment,ofr.CreatedBy,l.Name,CONVERT(varchar(11),ofr.CreatedDate,103) as CreatedDate
		from OrderFeedback ofr left join Login l on ofr.CreatedBy = l.LoginId 
	
   WHERE ofr.IsActive = 1 AND ofr.ParentOrderFeedbackReplyId = ofb.OrderFeedbackId and Isnull(ofr.ParentOrderFeedbackReplyId,0) !=0
 FOR XML path('OrderFeedbackReplyList'),ELEMENTS) AS xml))

  FROM OrderFeedback ofb join LookUp lu on ofb.feedbackId=lu.LookUpId  
  join [Order] o on o.OrderId = ofb.OrderId
  WHERE ofb.IsActive =1  and (ofb.OrderFeedbackId = ISNULL(@OrderFeedbackId,0) or ISNULL(@OrderFeedbackId,0) = 0) and ofb.OrderId = @orderId 
  and Isnull(ofb.ParentOrderFeedbackReplyId,0)=0
	FOR XML path('OrderFeedbackList'),ELEMENTS,ROOT('Json')) AS XML)
END
