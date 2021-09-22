CREATE PROCEDURE [dbo].[SSP_AllReasonCode] --'<Json><ServicesAction>LoadReasonCodeList</ServicesAction><LookupCategory>ReasonCode</LookupCategory></Json>'
(
@xmlDoc XML
)
AS

BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
Declare @lookupCategory nvarchar(100)
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @lookupCategory = tmp.[LookupCategory]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[LookupCategory] nvarchar(100)
			)tmp ;


	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,LookUpId as [ReasonCodeId]
      ,Code as [ReasonCode]
      ,[Name] as [ReasonName]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
   
  FROM LookUp WHERE IsActive = 1 and LookupCategory in (Select LookUpCategoryId from LookUpCategory where Name=@lookupCategory)
	FOR XML path('ReasonCodeList'),ELEMENTS,ROOT('ReasonCode')) AS XML)
	
	
	
	
END


