CREATE PROCEDURE [dbo].[SSP_GetComplaintList] --'<Json><ServicesAction>LoadComplaintDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><Comment></Comment><CommentCriteria></CommentCriteria><EnquiryNumber></EnquiryNumber><EnquiryNumberCriteria></EnquiryNumberCriteria><OrderNumber></OrderNumber><OrderNumberCriteria></OrderNumberCriteria></Json>'
(@xmlDoc XML)

AS
BEGIN

Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)


DECLARE @OrderId bigint
DECLARE @OrderNumber nvarchar(150)
DECLARE @OrderNumberCriteria nvarchar(50)

DECLARE @PostDate nvarchar(150)
DECLARE @PostDateCriteria nvarchar(50)

DECLARE @Comment nvarchar(150)
DECLARE @CommentCriteria nvarchar(50)
DECLARE @EnquiryNumber nvarchar(150)
DECLARE @EnquiryNumberCriteria nvarchar(50)
Declare @CompanyId bigint
Declare @roleId bigint
set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	@Comment=tmp.[Comment],
	@CommentCriteria=tmp.[CommentCriteria],
	@EnquiryNumber=tmp.[EnquiryNumber],
	@EnquiryNumberCriteria=tmp.[EnquiryNumberCriteria],
	@OrderNumber=tmp.[OrderNumber],
	@OrderNumberCriteria=tmp.[OrderNumberCriteria],
	@PostDate=tmp.[PostDate],
	@PostDateCriteria=tmp.[PostDateCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
    @CompanyId=tmp.CompanyId,
    @roleId=tmp.RoleMasterId
	--,	@OrderId = tmp.[OrderId]
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),  
   OrderId bigint,
   Comment nvarchar(150),
   CommentCriteria nvarchar(50),
   PostDate nvarchar(150),
   PostDateCriteria nvarchar(50),
   EnquiryNumber nvarchar(150),
   EnquiryNumberCriteria nvarchar(50),
   OrderNumber nvarchar(150),
   OrderNumberCriteria nvarchar(50),
    CompanyId bigint,
    RoleMasterId bigint
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'OrderFeedbackId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)

IF @Comment !=''
BEGIN

  IF @CommentCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Comment LIKE ''%' + @Comment + '%'''
  END
  IF @CommentCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Comment NOT LIKE ''%' + @Comment + '%'''
  END
  IF @CommentCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Comment LIKE ''' + @Comment + '%'''
  END
  IF @CommentCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and Comment LIKE ''%' + @Comment + ''''
  END          
  IF @CommentCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and Comment =  ''' +@Comment+ ''''
  END
  IF @CommentCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and Comment <>  ''' +@Comment+ ''''
  END
END


IF @EnquiryNumber !=''
BEGIN

  IF @EnquiryNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''%' + @EnquiryNumber + '%'''
  END
  IF @EnquiryNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber NOT LIKE ''%' + @EnquiryNumber + '%'''
  END
  IF @EnquiryNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''' + @EnquiryNumber + '%'''
  END
  IF @EnquiryNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and EnquiryAutoNumber LIKE ''%' + @EnquiryNumber + ''''
  END          
  IF @EnquiryNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and EnquiryAutoNumber =  ''' +@EnquiryNumber+ ''''
  END
  IF @EnquiryNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and EnquiryAutoNumber <>  ''' +@EnquiryNumber+ ''''
  END
END



IF @OrderNumber !=''
BEGIN

  IF @OrderNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderNumber LIKE ''%' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderNumber NOT LIKE ''%' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderNumber LIKE ''' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and OrderNumber LIKE ''%' + @OrderNumber + ''''
  END          
  IF @OrderNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and OrderNumber =  ''' +@OrderNumber+ ''''
  END
  IF @OrderNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and OrderNumber <>  ''' +@OrderNumber+ ''''
  END
END


IF @PostDate !=''
BEGIN

  IF @PostDateCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ofb.CreatedDate LIKE ''%' + @PostDate + '%'''
  END
  IF @PostDateCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ofb.CreatedDate NOT LIKE ''%' + @PostDate + '%'''
  END
  IF @PostDateCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ofb.CreatedDate LIKE ''' + @PostDate + '%'''
  END
  IF @PostDateCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and ofb.CreatedDate LIKE ''%' + @PostDate + ''''
  END          
  IF @PostDateCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and CONVERT(varchar(11),ofb.CreatedDate,103) =  ''' + CONVERT(varchar(11),@PostDate,103) + ''''
  END
  IF @PostDateCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and ofb.CreatedDate <>  ''' + @PostDate + ''''
  END
END



if @roleId=4
BEGIN
SET @whereClause = @whereClause + ' and ofb.OrderId in (select OrderId from [Order] where SoldTo=' + CONVERT(NVARCHAR(10), @CompanyId)+' or ' + CONVERT(NVARCHAR(10), @CompanyId)+'=''0'')'
END

set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
[OrderFeedbackId]
      ,[OrderId]
      ,OrderNumber
      ,EnquiryAutoNumber
      ,SalesOrderNumber
      ,DeliveryLocation
      ,CompanyName
      ,RequestDate
      ,[OrderProductId]
      ,[feedbackId]
	  ,[Attachment]
	  ,[Comment]
	  ,[HVBLComment]
	  ,[Quantity]
	  ,[ActualReceiveDate]
	  ,[CreatedBy]
	  ,[CreatedDate]
	  ,[ModifiedBy]
	  ,[ModifiedDate]
  ,[IsActive]
  ,[SequenceNo]
  ,Area 
  ,PostDate
  ,TruckOutPlateNumber
  ,TruckOutDriver
  ,Deployement1
  ,Deployement2 from(
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(o.ModifiedDate,o.CreatedDate) desc) as rownumber , COUNT(OrderFeedbackId) OVER () as TotalCount,
[OrderFeedbackId]
      ,ofb.[OrderId]
	  ,OrderNumber
	  ,EnquiryAutoNumber as EnquiryAutoNumber
	  ,SalesOrderNumber
	    ,case when LEN(DeliveryLocationCode)>15 then LEFT(DeliveryLocationCode, 15)+ ''...'' else DeliveryLocationCode end as DeliveryLocation 
	   ,case when SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0))='''' then SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5) else isnull(SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0,CHARINDEX(''-'',(select top 1 CompanyName from Company where CompanyId =  o.SoldTo),0)),SUBSTRING((select top 1 CompanyName from Company where CompanyId =  o.SoldTo),1,5)) end as CompanyName
	    ,o.ExpectedTimeOfDelivery as RequestDate
      ,[OrderProductId]
      ,[feedbackId]
      ,[Attachment]
      ,[Comment]
      ,[HVBLComment]
      ,[Quantity]
      ,[ActualReceiveDate]
      ,o.[CreatedBy]
      ,o.[CreatedDate]
      ,o.[ModifiedBy]
      ,o.[ModifiedDate]
      ,o.[IsActive]
      ,o.[SequenceNo]
       ,d.Area
	   ,ofb.CreatedDate as PostDate
      ,(SELECT TOP 1 PlateNumber From (select Top 1 PlateNumber,OrderLogistichistoryId from [dbo].OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = ''TruckOut'' and IsActive=1  ORDER BY OrderLogistichistoryId DESC) x ORDER BY OrderLogistichistoryId) as TruckOutPlateNumber
      ,(Select Name from Profile where ProfileId in (Select ProfileId from Login where LoginId in (select top 1 DeliveryPersonnelId  from OrderLogistichistory where Orderid=o.OrderId and PlateNumberBy = ''TruckOut''  ORDER BY OrderLogistichistoryId DESC))) as TruckOutDriver
           ,lu.Name as Deployement1
      ,lu1.Name as Deployement2
  FROM [OrderFeedBack]  ofb 
			inner join 	[Order] o On  ofb.OrderId = o.OrderId 
			inner join Enquiry e on  e.EnquiryId = o.EnquiryId
			left join  DeliveryLocation d on o.shipto = d.DeliveryLocationId
			left join Company c on c.CompanyId = o.Soldto
			left join LookUp lu on lu.LookUpId=ofb.feedbackId 
			left join LookUp lu1 on lu1.LookUpId=ofb.Field1 
	  WHERE ofb.IsActive = 1 and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''OrderFeedbackList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	   PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
