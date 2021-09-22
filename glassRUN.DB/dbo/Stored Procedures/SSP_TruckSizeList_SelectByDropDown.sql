create PROCEDURE [dbo].[SSP_TruckSizeList_SelectByDropDown] --'<Json><ServicesAction>GetTruckDetailByLocationIdAndCompanyId</ServicesAction><LocationId>767</LocationId><CompanyId>191</CompanyId></Json>'
(
@xmlDoc XML
)
AS

DECLARE @intPointer INT;
Declare @LocationId INT
Declare @CompanyId INT
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








WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
Select CAST(    ( select distinct 'true' AS [@json:Array] ,  TruckSizeId , TruckCapacityWeight , TruckSize , VehicleType , TruckCapacityPalettes ,
 (VehicleType + ' - '+ convert(nvarchar(250),TruckSize)   ) as Name
  From(select  t.TruckSizeId  , isnull(TruckCapacityWeight,0) as TruckCapacityWeight ,
isnull(TruckSize,0) as TruckSize,
isnull((select top 1 Name from lookup where lookupid =VehicleType),'') as VehicleType,
isnull(TruckCapacityPalettes,0) as TruckCapacityPalettes
, DestinationId

  From  TruckSize   t left join Route  r on r.TruckSizeId = t.TruckSizeId)tmp
    FOR XML path('TruckSizeList'),ELEMENTS,ROOT('Json')) AS XML)

END