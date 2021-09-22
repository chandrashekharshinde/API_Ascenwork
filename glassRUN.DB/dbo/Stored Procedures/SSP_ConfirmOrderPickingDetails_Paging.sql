CREATE PROCEDURE [dbo].[SSP_ConfirmOrderPickingDetails_Paging] --'<Json><ServicesAction>LoadOrderDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>10</PageSize><OrderBy></OrderBy><OrderNumber></OrderNumber><OrderNumberCriteria></OrderNumberCriteria></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
DECLARE @intPointer INT;
DECLARE @whereClause NVARCHAR(max)


Declare @PageSize INT
Declare @PageIndex INT
Declare @OrderBy NVARCHAR(20)


DECLARE @OrderNumber nvarchar(150)
DECLARE @CarrierETD datetime
DECLARE @OrderNumberCriteria nvarchar(50)
DECLARE @CarrierETDCriteria nvarchar(50)

set  @whereClause =''




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @OrderNumber = tmp.[OrderNumber],
	   @OrderNumberCriteria = tmp.[OrderNumberCriteria],
	   @CarrierETD = tmp.[CarrierETD],
	   @CarrierETDCriteria = tmp.[CarrierETDCriteria],
	   @PageSize = tmp.[PageSize],
	   @PageIndex = tmp.[PageIndex],
	   @OrderBy = tmp.[OrderBy]
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[PageIndex] int,
			[PageSize] int,
			[OrderBy] nvarchar(2000),
			[OrderNumber] nvarchar(150),
			[OrderNumberCriteria] nvarchar(50),
           	[CarrierETD] datetime,
			[CarrierETDCriteria] nvarchar(50)
			)tmp




		


IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'tmp.OrderId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END


IF @OrderNumber !=''
BEGIN

  IF @OrderNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and tmp.OrderNumber LIKE ''%' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and tmp.OrderNumber NOT LIKE ''%' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and tmp.OrderNumber LIKE ''' + @OrderNumber + '%'''
  END
  IF @OrderNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and tmp.OrderNumber LIKE ''%' + @OrderNumber + ''''
  END          
  IF @OrderNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and tmp.OrderNumber =  ''' +@OrderNumber+ ''''
  END
  IF @OrderNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and tmp.OrderNumber <>  ''' +@OrderNumber+ ''''
  END
END




	SET @sql = 'select cast ((SELECT COUNT(OrderId) OVER () as TotalCount,  * FROM (SELECT t.[OrderId],
		t.[OrderNumber],
		t.[CarrierETD]
		from [Order] t 
		WHERE t.IsActive = 1 ) tmp
   WHERE ' + @whereClause + ' ORDER BY '+@orderBy+' OFFSET ((' + CONVERT(NVARCHAR(10), @PageIndex) + ' * ' + CONVERT(NVARCHAR(10), @PageSize) + ')) ROWS FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY  FOR XML RAW(''OrderList''),ELEMENTS,ROOT(''Json'')) AS XML)'



   

	PRINT @sql
	--SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
	EXEC sp_executesql @sql

END
