CREATE PROCEDURE [dbo].[SSP_LoadOrderFeedbackList]  --'<Json><ServicesAction>LoadFeedbackList</ServicesAction><LoginId>8</LoginId><RoleId>3</RoleId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)
declare @LoginId NVARCHAR(max)
declare @RoleId bigint

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @LoginId = tmp.[LoginId],
@RoleId = tmp.[RoleId]



FROM OPENXML(@intpointer,'Json',2)
WITH
(
[LoginId] bigint,
[RoleId] bigint

)tmp;

set @whereClause =''	
IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

If @RoleId=4
BEGIN
SET @whereClause = @whereClause + ' and OrderFeedbackId in (select OrderFeedbackId from OrderFeedbackReply where (IsRead = 0 or IsRead is null)) '
SET @whereClause = @whereClause + ' and OrderId in (select OrderId from [Order] where SoldTo in (select CompanyId from Company where CompanyId in( select ReferenceId from Profile where ProfileId in (select ProfileId from Login where LoginId = '+@LoginId+' )) )) '
END
Else 
Begin
SET @whereClause = @whereClause + 'and (IsRead = 0 Or IsRead is null)'
End
Print @RoleId




set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 

SELECT CAST((
select * from (SELECT ''true'' AS [@json:Array], OrderFeedbackId, [OrderId],
(Select SalesOrderNumber from [Order] where OrderId = ofb.OrderId and isactive = 1) as SalesOrderNumber
,CONVERT(varchar(100),[OrderProductId]) as OrderProductId
,(Select ItemName from item where Itemcode in (Select ProductCode from OrderProduct where OrderProductId = ofb.[OrderProductId])) as ProductName
,[feedbackId]
,(SELECT [dbo].[fn_LookupValueById] (ofb.[feedbackId])) as FeedbackName
,[Attachment]
,(Select Name from Profile where ProfileId in (select ProfileId from Login where LoginId = ofb.CreatedBy)) as Name
,[Comment]
,[HVBLComment]
,[Quantity]
,CONVERT(varchar(11),ofb.CreatedDate,103) as CreatedDate
,''Feedback'' as Type
FROM OrderFeedback ofb join LookUp lu on ofb.feedbackId=lu.LookUpId WHERE ofb.IsActive = 1 and ' + @whereClause +'

union all
SELECT ''true'' AS [@json:Array], 0 as OrderFeedbackId, [EmailNotificationId] as [OrderId]
,CONVERT(varchar(100),[EmailNotificationId]) as SalesOrderNumber
,[ObjectId] as [OrderProductId]
,[ObjectType] as ProductName
,0 as [feedbackId]
--, (SELECT Description From EmailEvent Where EventCode=en.EventType) as FeedbackName
,Message as FeedbackName
,'''' as Attachment
,(Select Name from Profile where ProfileId in (select ProfileId from Login where LoginId = en.CreatedBy)) as Name
,'''' as Comment
,'''' as [HVBLComment]
,0 as [Quantity]
,CONVERT(varchar(11),en.CreatedDate,103) as CreatedDate
,''Email'' as Type
FROM [EmailNotification] en WHERE en.IsActive = 1 and MarkAsRead is null) as tmp

FOR XML path(''OrderFeedbackList''),ELEMENTS,ROOT(''Json'')) AS XML)'

PRINT @sql

EXEC sp_executesql @sql

END
