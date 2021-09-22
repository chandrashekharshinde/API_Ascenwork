

CREATE PROCEDURE [dbo].[SSP_AllDeliveryLocationList] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>0</CompanyId><IsDeliveryLocationOnKeyPress>true</IsDeliveryLocationOnKeyPress><DeliveryLocationValue>Jumbo</DeliveryLocationValue></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint
Declare @locationtype bigint=27
declare @SettingValue nvarchar(max)


Declare @IsDeliveryLocationOnKeyPress nvarchar(100)
Declare @DeliveryLocationValue nvarchar(500)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc




SELECT @companyId = tmp.[CompanyId],
@IsDeliveryLocationOnKeyPress = tmp.[IsDeliveryLocationOnKeyPress],
@DeliveryLocationValue = tmp.[DeliveryLocationValue]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint,
   [IsDeliveryLocationOnKeyPress] nvarchar(100),
   [DeliveryLocationValue] nvarchar(500)
           
			)tmp ;

Select @SettingValue=SettingValue from SettingMaster where SettingParameter='DeliveryLocationSource'

if @SettingValue='4'
begin
set @companyId=0
set @locationtype=0
end;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT   top 30 'true' AS [@json:Array] , LocationId as [DeliveryLocationId]
      ,[LocationName] +ISNULL(' ('+[LocationCode]+')','') as [DeliveryLocationName]
	  --,[LocationName] +ISNULL(' ('+[LocationCode]+')','') as [Name]
	  ,ISNULL(DisplayName,'') as DisplayName
	  ,[LocationName] + ' '+  ISNULL([LocationCode],'') + ' '+  ISNULL([Pincode],'')   + ' '+  ISNULL(State,'') + ' '+ ISNULL(City,'') as [Name]
	  ,l.[LocationName]+  + (Case when l.Pincode = '' then '' else ISNULL(' ('+l.[Pincode]+')','') end) as DeliveryName
	  ,ISNULL(l.AddressLine1,'') + ISNULL(l.AddressLine2,'')  + ISNULL(l.AddressLine3,'') + ISNULL(l.Pincode,'') + ISNULL(l.State,'') + ISNULL(l.City,'') as DeliveryLocationAddress
      ,[LocationCode] as DeliveryLocationCode
	  ,0 as [AvailableDeliveryLocationCapacity]
	  ,0 as DeliveryUsedCapacity
      ,[CompanyID]
	  ,ISNULL([Area],'') as Area
	  ,Capacity
	  ,ISNULL(Field1,'') as Field1
     
  FROM [Location] l WHERE IsActive = 1  and (LocationType = @locationtype or @locationtype = 0) and (CompanyID=@companyId or @companyId=0)
   and 
(l.LocationId in (SELECT loc.LocationId FROM [Location] loc WHERE (loc.LocationName like '%'+@DeliveryLocationValue+'%' or loc.Pincode like '%'+@DeliveryLocationValue+'%') and @IsDeliveryLocationOnKeyPress='false') or @IsDeliveryLocationOnKeyPress='true')
	FOR XML path('DeliveryLocationList'),ELEMENTS,ROOT('DeliveryLocation')) AS XML)
END