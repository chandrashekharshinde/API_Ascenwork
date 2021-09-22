CREATE PROCEDURE [dbo].[SSP_LoadOrderStockLocationId] --'<Json><ServicesAction>GetAllCollectionLocationList</ServicesAction><CompanyId>0</CompanyId><IsCollectionLocationOnKeyPress>false</IsCollectionLocationOnKeyPress><CollectionLocationValue>true</CollectionLocationValue></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint;
Declare @SettingValue nvarchar(max)=''
Declare @locationtype bigint=21
Declare @IsCollectionLocationOnKeyPress nvarchar(100)
Declare @CollectionLocationValue nvarchar(500)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId],
	   @IsCollectionLocationOnKeyPress= tmp.[IsCollectionLocationOnKeyPress],
	   @CollectionLocationValue = tmp.[CollectionLocationValue]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint,
           [IsCollectionLocationOnKeyPress] nvarchar(100),
		   [CollectionLocationValue] nvarchar(500)
			)tmp ;

Select @SettingValue=SettingValue from SettingMaster where SettingParameter='CollectionLocationSource'


if @SettingValue='4'
begin
set @companyId=0
set @locationtype=0
end;


if(@SettingValue != '')
begin
IF ((EXISTS (Select *   FROM [Location] l join [Route] r on r.OriginId=l.LocationId  WHERE l.IsActive = 1 and l.LocationType = 21 and r.CompanyID=@companyId  and l.CompanyID=@companyId) and @SettingValue='3')  or @SettingValue='1')
begin
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT   top 30 'true' AS [@json:Array] , l.LocationId , l.LocationId as Id
      ,l.[LocationName] +ISNULL(' ('+l.[LocationCode]+')','') as [DeliveryLocationName]
	 -- ,l.[LocationName] +ISNULL(' ('+l.[LocationCode]+')','') as [Name]
	  ,[LocationName] + ' '+  ISNULL([LocationCode],'') + ' '+  ISNULL([Pincode],'')   + ' '+  ISNULL((Select StateName from [State] where StateId=l.[State]),'') + ' '+ ISNULL((Select CityName from [City] where CityId=l.[City]),'') as [Name]
	  ,ISNULL(DisplayName,'') as DisplayName
	  ,l.[LocationName]+  + (Case when l.Pincode = '' then '' else ISNULL(' ('+l.[Pincode]+')','') end) as DeliveryName
      ,l.[LocationCode] as Code
	  ,0 as [AvailableDeliveryLocationCapacity]
	  ,0 as DeliveryUsedCapacity
      ,l.[CompanyID]
	  
	  , (select  top 1 gstno from   State  s  where s.StateId= l.State)  as 'GSTNo'
  FROM [Location] l join [Route] r on r.OriginId=l.LocationId  WHERE l.IsActive = 1 and l.LocationType = 21 and r.CompanyID=@companyId  and l.CompanyID=@companyId
	FOR XML path('BindingDataList'),ELEMENTS,ROOT('Json')) AS XML)
end
else if(@SettingValue = '4' or @SettingValue='3'  or @SettingValue='2')
begin
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  top 30  'true' AS [@json:Array] , LocationId, LocationId as Id
      ,[LocationName] +ISNULL(' ('+[LocationCode]+')','') as [DeliveryLocationName]
	  --,[LocationName] +ISNULL(' ('+[LocationCode]+')','') as [Name]
	  	  ,[LocationName] + ' '+  ISNULL([LocationCode],'') + ' '+  ISNULL([Pincode],'')   + ' '+  ISNULL((Select StateName from [State] where StateId=l.[State]),'') + ' '+ ISNULL((Select CityName from [City] where CityId=l.[City]),'') as [Name]
	  ,ISNULL(DisplayName,'') as DisplayName
	  ,l.[LocationName]+  + (Case when l.Pincode = '' then '' else ISNULL(' ('+l.[Pincode]+')','') end) as DeliveryName
      ,[LocationCode] as Code
	  ,0 as [AvailableDeliveryLocationCapacity]
	  ,0 as DeliveryUsedCapacity
      ,[CompanyID]
	  
	  , (select  top 1 gstno from   State  s  where s.StateId= l.State)  as 'GSTNo'
  FROM [Location] l WHERE IsActive = 1 and (LocationType = @locationtype or @locationtype = 0) and (CompanyID=@companyId or @companyId=0)
	FOR XML path('BindingDataList'),ELEMENTS,ROOT('Json')) AS XML)
end
END

END
