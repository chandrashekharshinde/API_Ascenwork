CREATE PROCEDURE [dbo].[SSP_AllTransportVehicleList] --'<Json><ServicesAction>LoadTransportVehicleDetails</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><TransportVehicleName></TransportVehicleName><TransportVehicleNameCriteria></TransportVehicleNameCriteria><TransporterVehicleRegistrationNumber></TransporterVehicleRegistrationNumber><TransporterVehicleRegistrationNumberCriteria></TransporterVehicleRegistrationNumberCriteria><TruckSize></TruckSize><TruckSizeCriteria></TruckSizeCriteria><UserId>106</UserId></Json>'
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

DECLARE @transportVehicle nvarchar(150)
DECLARE @TruckTypeCriteria nvarchar(50)
DECLARE @transportVehicleCriteria nvarchar(50)
DECLARE @userId bigint
DECLARE @transporterVehicleRegistrationNumber nvarchar(150)
DECLARE @transporterVehicleRegistrationNumberCriteria nvarchar(150)
DECLARE @truckSize nvarchar(150)
DECLARE @truckSizeCriteria nvarchar(150)

set  @whereClause =''


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT
	@transportVehicle=tmp.[TransportVehicle],
	@transportVehicleCriteria=tmp.[TransportVehicleCriteria],
	@transporterVehicleRegistrationNumber=tmp.[TransporterVehicleRegistrationNumber],
	@transporterVehicleRegistrationNumberCriteria=tmp.[TransporterVehicleRegistrationNumberCriteria],
	@truckSize=tmp.[TruckSize],
	@truckSizeCriteria=tmp.[TruckSizeCriteria],
    @PageSize = tmp.[PageSize],
    @PageIndex = tmp.[PageIndex],
    @OrderBy = tmp.[OrderBy],
	@userId=tmp.UserId
   

FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
   [PageIndex] int,
   [PageSize] int,
   [OrderBy] nvarchar(2000),  
   [TransportVehicle] nvarchar(150),
   [TransportVehicleCriteria] nvarchar(50),
   [TransporterVehicleRegistrationNumber] nvarchar(150),
   [TransporterVehicleRegistrationNumberCriteria] nvarchar(50),
   [TruckSize] nvarchar(150),
   [TruckSizeCriteria] nvarchar(50),
   UserId bigint
           
   )tmp

IF(RTRIM(@orderBy) = '') BEGIN SET @orderBy = 'TransporterVehicleId' END


IF(RTRIM(@whereClause) = '') BEGIN SET @whereClause = '1=1' END

SET @PageIndex = (CONVERT(bigint,@PageIndex) + 1)




IF @transportVehicle !=''
BEGIN

  IF @transportVehicleCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterVehicleName LIKE ''%' + @transportVehicle + '%'''
  END
  IF @transportVehicleCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterVehicleName NOT LIKE ''%' + @transportVehicle + '%'''
  END
  IF @transportVehicleCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterVehicleName LIKE ''' + @transportVehicle + '%'''
  END
  IF @transportVehicleCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterVehicleName LIKE ''%' + @transportVehicle + ''''
  END          
  IF @transportVehicleCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and TransporterVehicleName =  ''' +@transportVehicle+ ''''
  END
  IF @transportVehicleCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TransporterVehicleName <>  ''' +@transportVehicle+ ''''
  END
END
IF @transporterVehicleRegistrationNumber !=''
BEGIN

  IF @transporterVehicleRegistrationNumberCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterVehicleRegistrationNumber LIKE ''%' + @transporterVehicleRegistrationNumber + '%'''
  END
  IF @transporterVehicleRegistrationNumberCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterVehicleRegistrationNumber NOT LIKE ''%' + @transporterVehicleRegistrationNumber + '%'''
  END
  IF @transporterVehicleRegistrationNumberCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterVehicleRegistrationNumber LIKE ''' + @transporterVehicleRegistrationNumber + '%'''
  END
  IF @transporterVehicleRegistrationNumberCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TransporterVehicleRegistrationNumber LIKE ''%' + @transporterVehicleRegistrationNumber + ''''
  END          
  IF @transporterVehicleRegistrationNumberCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and TransporterVehicleRegistrationNumber =  ''' +@transporterVehicleRegistrationNumber+ ''''
  END
  IF @transporterVehicleRegistrationNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TransporterVehicleRegistrationNumber <>  ''' +@transporterVehicleRegistrationNumber+ ''''
  END
END
IF @truckSize !=''
BEGIN

  IF @truckSizeCriteria = 'contains'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize LIKE ''%' + @truckSize + '%'''
  END
  IF @truckSizeCriteria = 'doesnotcontain'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize NOT LIKE ''%' + @truckSize + '%'''
  END
  IF @truckSizeCriteria = 'startswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize LIKE ''' + @truckSize + '%'''
  END
  IF @truckSizeCriteria = 'endswith'
  BEGIN
  
  SET @whereClause = @whereClause + ' and TruckSize LIKE ''%' + @truckSize + ''''
  END          
  IF @truckSizeCriteria = 'eq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckSize =  ''' +@truckSize+ ''''
  END
  IF @transporterVehicleRegistrationNumberCriteria = 'neq'
 BEGIN

 SET @whereClause = @whereClause + ' and TruckSize <>  ''' +@truckSize+ ''''
  END
END

set @sql=
'WITH XMLNAMESPACES(''http://james.newtonking.com/projects/json'' AS json) 
SELECT CAST((Select ''true'' AS [@json:Array] ,
rownumber,
TotalCount,
[TransporterVehicleId]
      ,[TransporterVehicleName]
      ,[TransporterVehicleRegistrationNumber]
      ,[TransporterVehicleType]
      ,[TransporterVehicleCapacity]
      ,[TransporterId]
      ,[ProductType]
      ,[GrossWeight]
      ,[NumberOfCompartments]
      ,[TruckSizeId]
	  ,[TruckSize]
	  ,ISNULL(RegisteredVehicleCertificateBlob,''-'') as RegisteredVehicleCertificateBlob
	  ,ISNULL(FormatType,''-'') as FormatType
	  ,CreatedBy
	  ,CreatedDate
	  ,ModifiedBy
	  ,ModifiedDate
	  ,IsActive

 from (
SELECT  ROW_NUMBER() OVER (ORDER BY   ISNULL(ModifiedDate,CreatedDate) desc) as rownumber , COUNT(*) OVER () as TotalCount,
tv.[TransporterVehicleId]
      ,tv.[TransporterVehicleName]
      ,tv.[TransporterVehicleRegistrationNumber]
      ,tv.[TransporterVehicleType]
      ,tv.[TransporterVehicleCapacity]
      ,tv.[TransporterId]
      ,tv.[ProductType]
      ,tv.[GrossWeight]
      ,tv.[NumberOfCompartments]
      ,tv.[TruckSizeId]
	  ,ts.[TruckSize]
	  ,tv.RegisteredVehicleCertificateBlob
	  ,tv.FormatType
	  ,tv.[CreatedBy]
	  ,tv.[CreatedDate]
	  ,tv.[ModifiedBy]
	  ,tv.[ModifiedDate]
	  ,tv.[IsActive]
 FROM [TransporterVehicle] tv
 LEFT JOIN TruckSize ts on tv.TruckSizeId = ts.TruckSizeId
	  WHERE tv.IsActive = 1 and (tv.TransporterId=' + CONVERT(NVARCHAR(10), @userId)+ ' or TransporterId in (select LoginId from Login where parentid=' + CONVERT(NVARCHAR(10), @userId)+ '))  and  ' + @whereClause +') as tmp where'+ (SELECT [dbo].[fn_GetPaginationString] (@PageSize,@PageIndex)) + '
 FOR XML path(''TruckList''),ELEMENTS,ROOT(''Json'')) AS XML)'
	   PRINT @sql
 --SELECT @ProcessConfiguration as ProcessConfigurationId FOR XML RAW('Json'),ELEMENTS
 EXEC sp_executesql @sql

END
