
CREATE PROCEDURE [dbo].[SSP_GetTruckByLocationIdAndCompanyId] --'<Json><ServicesAction>GetTruckDetailByLocationIdAndCompanyId</ServicesAction><LocationId>767</LocationId><CompanyId>191</CompanyId></Json>'
(
@xmlDoc XML
)
AS

DECLARE @intPointer INT;
Declare @LocationId INT
Declare @CompanyId INT
Declare @SettingValue nvarchar(max)=''
BEGIN



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc




SELECT 

	   @LocationId = tmp.[LocationId],
	   @CompanyId = tmp.[CompanyId]
	  
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[LocationId] int,
			[CompanyId] int
			
           
			)tmp ;

Select @SettingValue=SettingValue from SettingMaster where SettingParameter='TruckDataSource'

if(@SettingValue != '')
begin
IF ((EXISTS (Select *   From [Route] r where  DestinationId=@LocationId) and @SettingValue='3')  or @SettingValue='1')
begin
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
Select CAST(( select   'true' AS [@json:Array]  ,  (VehicleType + ' - '+TruckSize  ) as Name,   *From (  Select  
r.[DestinationId],r.[TruckSizeId],isnull((Select TruckCapacityWeight from TruckSize where TruckSizeId=r.[TruckSizeId]),0) as TruckCapacityWeight ,isnull((Select TruckSize from TruckSize where TruckSizeId= r.[TruckSizeId]),0) as TruckSize,isnull((select top 1 Name from lookup where lookupid in ((Select VehicleType from TruckSize where TruckSizeId= r.[TruckSizeId]))),'') as VehicleType,isnull((Select TruckCapacityPalettes from TruckSize where TruckSizeId= r.[TruckSizeId]),0) as TruckCapacityPalettes
	 , (select  count(distinct(rc.OriginId))  from Route  rc where  rc.DestinationId =r.DestinationId and rc.TruckSizeId =r.TruckSizeId ) as OriginIdCount
	,  ( case when  (select  count(distinct(rc.OriginId))  from Route  rc where  rc.DestinationId =r.DestinationId and rc.TruckSizeId =r.TruckSizeId )=1 then 
	(select  distinct(rc.OriginId)  from Route  rc where  rc.DestinationId =r.DestinationId and rc.TruckSizeId =r.TruckSizeId ) else 0 end ) as OriginId
	, Isnull(r.PalletInclusionGroup,'0') as PalletInclusionGroup
	  From [Route] r where  DestinationId=@LocationId and Isnull(r.TruckSizeId,0)!=0
	  group by 
	 TruckSizeId ,DestinationId,PalletInclusionGroup )tmp
    FOR XML path('TruckSizeList'),ELEMENTS,ROOT('Json')) AS XML)
end
else IF (@SettingValue='3'  or @SettingValue='2')
begin


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
Select CAST(    ( select distinct 'true' AS [@json:Array] ,  TruckSizeId , TruckCapacityWeight , TruckSize , VehicleType , TruckCapacityPalettes ,
 (VehicleType + ' - '+ convert(nvarchar(250),TruckSize)   ) as Name
  From(select  t.TruckSizeId  , isnull(TruckCapacityWeight,0) as TruckCapacityWeight ,
isnull(TruckSize,0) as TruckSize,
isnull((select top 1 Name from lookup where lookupid =VehicleType),'') as VehicleType,
isnull(TruckCapacityPalettes,0) as TruckCapacityPalettes
, DestinationId
, Isnull(r.PalletInclusionGroup,'0') as PalletInclusionGroup
  From  TruckSize   t left join Route  r on r.TruckSizeId = t.TruckSizeId)tmp
    FOR XML path('TruckSizeList'),ELEMENTS,ROOT('Json')) AS XML)
end
else if(@SettingValue = '4')
begin


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
Select CAST(    ( select distinct 'true' AS [@json:Array] ,  TruckSizeId , TruckCapacityWeight , TruckSize , VehicleType , TruckCapacityPalettes ,
 (VehicleType + ' - '+ convert(nvarchar(250),TruckSize)   ) as Name
  From(select  t.TruckSizeId  , isnull(TruckCapacityWeight,0) as TruckCapacityWeight ,
isnull(TruckSize,0) as TruckSize,
isnull((select top 1 Name from lookup where lookupid =VehicleType),'') as VehicleType,
isnull(TruckCapacityPalettes,0) as TruckCapacityPalettes
, 0 as DestinationId
,'0' as PalletInclusionGroup
  From  TruckSize   t)tmp
    FOR XML path('TruckSizeList'),ELEMENTS,ROOT('Json')) AS XML)
end
END

END