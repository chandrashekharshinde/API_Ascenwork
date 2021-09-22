CREATE PROCEDURE [dbo].[SSP_GetLookupByLookupCategoryId] --'<Json><LookupId>UnitOfMeasure</LookupId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @lookupCategory nvarchar(100)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @lookupCategory = tmp.[LookupId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[LookupId] nvarchar(100)
           
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,[LookUpId]
      ,[LookupCategory]
      ,[Name]
      ,[Code]
	  ,isnull([Description],'') as [Description]
	  ,isnull([ShortCode],'') as [ShortCode]
	  ,isnull([DisplayIcon],'') as [DisplayIcon]
	  ,IsActive
	  ,'Existing' as [DBStatus],CreatedBy
				   FROM LookUp  
	  WHERE LookupCategory= (select top 1 LookupCategoryId from LookupCategory where name=@lookupcategory )
	FOR XML path('LookupList'),ELEMENTS,ROOT('Json')) AS XML)
END


