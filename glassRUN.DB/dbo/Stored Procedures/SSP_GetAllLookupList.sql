CREATE PROCEDURE [dbo].[SSP_GetAllLookupList] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'

AS
BEGIN


DECLARE @intPointer INT;
declare @companyId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @companyId = tmp.[CompanyId]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] bigint
			)tmp;







			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] 
--, l.Name
,LookUpId
,LookupCategory
,luc.Name as LookupCategoryName
,ISNULL((Select top 1 ResourceValue from Resources where ResourceKey = l.ResourceKey and CultureId = '1101'),l.Name) as Name

,l.[Description] as DescriptionText ,l.ParentId, l.Code
,Isnull(l.Field1,'-') as Field1
,Isnull(l.Field2,'-') as Field2
,Isnull(l.Field3,'-') as Field3
,ISNULL(l.Field9,'') as Field9
 from LookUp l 
left join LookUpCategory luc on l.LookUpCategory = luc.LookUpCategoryId
where l.isactive = 1
	FOR XML path('LookUpList'),ELEMENTS,ROOT('Json')) AS XML)
END