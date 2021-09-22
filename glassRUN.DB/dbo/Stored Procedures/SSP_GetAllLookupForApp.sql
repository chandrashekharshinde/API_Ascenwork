CREATE PROCEDURE [dbo].[SSP_GetAllLookupForApp] --'<Json><ServicesAction>LoadLookupForApp</ServicesAction><LookUpCategorys>6,1</LookUpCategorys></Json>'

@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'

AS
BEGIN


DECLARE @intPointer INT;
declare @LookupCategory nvarchar(max)
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @LookupCategory = tmp.[LookUpCategorys]
	
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[LookUpCategorys] nvarchar(max)
			)tmp;





print @LookupCategory;

			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] 
,LookUpId
,LookupCategory
,luc.Name as LookupCategoryName
,ISNULL((Select top 1 ResourceValue from Resources where ResourceKey = l.ResourceKey and CultureId = '1101'),l.Name) as Name

,l.[Description] as DescriptionText ,l.ParentId, l.Code
,Isnull(l.Field1,'-') as Field1
,Isnull(l.Field2,'-') as Field2
,Isnull(l.Field3,'-') as Field3
,ISNULL(l.Field9,'') as Field9
,ISNULL(l.Field10,'') as Field10
 from LookUp l 
left join LookUpCategory luc on l.LookUpCategory = luc.LookUpCategoryId
where l.isactive = 1 and (l.LookupCategory in (Select * from dbo.fnSplitValuesForNvarchar(@LookupCategory)) or @LookupCategory='0')
	FOR XML path('LookUpList'),ELEMENTS,ROOT('Json')) AS XML)
END