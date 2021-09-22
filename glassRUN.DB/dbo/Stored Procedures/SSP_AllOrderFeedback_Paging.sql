CREATE PROCEDURE [dbo].[SSP_AllOrderFeedback_Paging] --'<Json><ServicesAction>LoadFeedbackList_Paging</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><LoginId>12</LoginId><RoleId>4</RoleId><OrderNumber></OrderNumber><OrderNumberCondition></OrderNumberCondition></Json>'
(@xmlDoc XML)
AS
BEGIN

Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


DECLARE @OrderNumber nvarchar(150)
DECLARE @OrderNumberCondition nvarchar(50)

Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)

DECLARE @LoginId nvarchar(150)
declare @RoleId bigint


set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@LoginId = tmp.[LoginId],
	@RoleId = tmp.[RoleId],
	@OrderNumber = tmp.[OrderNumber],
    @OrderNumberCondition = tmp.[OrderNumberCondition]

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),
   [LoginId] bigint,
   [RoleId] bigint,
   [OrderNumber] nvarchar(150),
   [OrderNumberCondition] nvarchar(50)
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'OrderFeedbackId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END



IF @OrderNumber !=''
BEGIN

  IF @OrderNumberCondition = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL((Select SalesOrderNumber from [Order] where OrderId = ofb.OrderId and isactive = 1),''-'') LIKE ''%' + @OrderNumber + '%'''
  END
  IF @OrderNumberCondition = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL((Select SalesOrderNumber from [Order] where OrderId = ofb.OrderId and isactive = 1),''-'') NOT LIKE ''%' + @OrderNumber + '%'''
  END
  IF @OrderNumberCondition = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL((Select SalesOrderNumber from [Order] where OrderId = ofb.OrderId and isactive = 1),''-'') LIKE ''' + @OrderNumber + '%'''
  END
  IF @OrderNumberCondition = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ISNULL((Select SalesOrderNumber from [Order] where OrderId = ofb.OrderId and isactive = 1),''-'') LIKE ''%' + @OrderNumber + ''''
  END          
  IF @OrderNumberCondition = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and ISNULL((Select SalesOrderNumber from [Order] where OrderId = ofb.OrderId and isactive = 1),''-'') =  ''' +@OrderNumber+ ''''
  END
  IF @OrderNumberCondition = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ISNULL((Select SalesOrderNumber from [Order] where OrderId = ofb.OrderId and isactive = 1),''-'') <>  ''' +@OrderNumber+ ''''
  END
END




If @RoleId=4
			BEGIN
			    --SET @whereClause = @whereClause + 'and OrderFeedbackId in (select OrderFeedbackId from OrderFeedbackReply where (IsRead = 0 or IsRead is null)) '
				SET @whereClause = @whereClause + 'and OrderId in (select OrderId from [Order] where SoldTo in (select CompanyId from Company where CompanyId in (select ReferenceId from Login where LoginId = '+@LoginId+' ) )) '
			END
		Else 
			Begin
				--SET @whereClause = @whereClause + 'and (IsRead = 0 Or IsRead is null)'
				SET @whereClause = @whereClause + ' and 1=1'
			End
Print @RoleId


SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)


set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
[OrderFeedbackId],
OrderId   ,
SalesOrderNumber,
OrderNumber,
CustomerName,
ShipToCode,
OrderProductId,
ProductName,
feedbackId,
FeedbackName,
Attachment,
Name,
Comment,
      [HVBLComment],
      [Quantity],
      [CreatedDate]


 from (
SELECT  ROW_NUMBER() OVER (ORDER BY  ofb.CreatedDate desc) as rownumber , COUNT(OrderFeedbackId) OVER () as TotalCount,
[OrderFeedbackId],
				[OrderId],
				ISNULL((Select SalesOrderNumber from [Order] where OrderId = ofb.OrderId and isactive = 1),''-'') as SalesOrderNumber,
				ISNULL((Select OrderNumber from [Order] where OrderId = ofb.OrderId and isactive = 1),''-'') as OrderNumber
				,ISNULL((Select SoldToName from [Order] where OrderId = ofb.OrderId and isactive = 1),''-'') as CustomerName
				,ISNULL((Select ShipToCode from [Order] where OrderId = ofb.OrderId and isactive = 1),''-'') as ShipToCode
			   ,[OrderProductId]
			   ,(Select ItemName from item where Itemcode in (Select ProductCode from OrderProduct where OrderProductId = ofb.[OrderProductId])) as ProductName
			   ,[feedbackId]
			   ,(SELECT [dbo].[fn_LookupValueById] (ofb.[feedbackId])) as FeedbackName
			   ,[Attachment]
			   ,(Select Name from Profile where ProfileId in (select ProfileId from Login where LoginId = ofb.CreatedBy)) as Name
			   ,[Comment]
			   ,[HVBLComment]
			   ,[Quantity]
			   ,CONVERT(varchar(11),ofb.CreatedDate,103) as CreatedDate
 FROM OrderFeedback ofb join LookUp lu on ofb.feedbackId=lu.LookUpId
	  WHERE ofb.IsActive = 1 and Isnull(ofb.ParentOrderFeedbackReplyId,0)=0 and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''OrderFeedbackList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	   PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
