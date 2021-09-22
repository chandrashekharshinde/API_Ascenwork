create PROCEDURE [dbo].[SSP_AllReasonCodeList] --'<Json><ServicesAction>LoadReasonCodeList</ServicesAction><LookupCategory>ReasonCode</LookupCategory></Json>'

AS

BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
Declare @lookupCategory nvarchar(100)
DECLARE @intPointer INT;




	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] ,LookUpId as [ReasonCodeId]
      ,Code as [ReasonCode]
      ,[Name] as [ReasonName]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
		,ISNULL((Select Name from LookUpCategory where LookUpCategoryId=LookUp.LookupCategory),'Test') as CategoryName
  FROM LookUp WHERE IsActive = 1 
	FOR XML path('ReasonCodeList'),ELEMENTS,ROOT('ReasonCode')) AS XML)
	
	
	
	
END