
CREATE PROCEDURE [dbo].[SSP_GetAllLocationList] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>592</CompanyId></Json>'


AS
BEGIN


DECLARE @intPointer INT;
Declare @companyId bigint
Declare @locationtype bigint=27
declare @SettingValue nvarchar(max)


Declare @IsDeliveryLocationOnKeyPress nvarchar(100)
Declare @DeliveryLocationValue nvarchar(500)







--SELECT @companyId = tmp.[CompanyId],
--@IsDeliveryLocationOnKeyPress = tmp.[IsDeliveryLocationOnKeyPress],
--@DeliveryLocationValue = tmp.[DeliveryLocationValue]
	   
--FROM OPENXML(@intpointer,'Json',2)
--			WITH
--			(
--			[CompanyId] bigint,
--   [IsDeliveryLocationOnKeyPress] nvarchar(100),
--   [DeliveryLocationValue] nvarchar(500)
           
--			)tmp ;

Select @SettingValue=SettingValue from SettingMaster where SettingParameter='DeliveryLocationSource'

if @SettingValue='4'
begin
set @companyId=0
set @locationtype=0
end;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] , LocationId as [DeliveryLocationId]
      ,[LocationName] +ISNULL(' ('+[LocationCode]+')','') as [DeliveryLocationName]
	  --,[LocationName] +ISNULL(' ('+[LocationCode]+')','') as [Name]	  
	  ,[LocationName] + ' '+  ISNULL([LocationCode],'') + ' '+  ISNULL([Pincode],'')   + ' '+  ISNULL((Select StateName from [State] where StateId=l.[State]),'') + ' '+ ISNULL((Select CityName from [City] where CityId=l.[City]),'') as [Name]
	  ,[LocationName] as DeliveryName
      ,[LocationCode] as DeliveryLocationCode
	  ,[LocationType]
      ,[CompanyID] 	  
      ,[Pincode]
      
  FROM [Location] l WHERE IsActive = 1 
   
	FOR XML path('DeliveryLocationList'),ELEMENTS,ROOT('DeliveryLocation')) AS XML)
END