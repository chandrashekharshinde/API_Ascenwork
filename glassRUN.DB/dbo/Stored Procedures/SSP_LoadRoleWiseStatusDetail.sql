
Create PROCEDURE [dbo].[SSP_LoadRoleWiseStatusDetail] --'<Json><ServicesAction>LoadWorkFlowActivityLog</ServicesAction><OrderId>77674</OrderId><RoleId>3</RoleId><UserId>8</UserId></Json>'
@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @OrderId bigint
Declare @RoleId bigint
Declare @UserId bigint

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;



  


WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT 'true' AS [@json:Array] ,[ActivityId]
      ,[StatusCode]
      ,[Header]
      ,[ActivityName]
      ,[Sequence]
      ,[ServiceAction]
      ,[IsResponseRequired]
      ,[ResponsePropertyName]
      ,[RejectedStatus]
      ,[IsApp]
      ,[ParentId]
      ,[IconName]
      ,[IsSystemDefined]
	  , (select cast ((SELECT  'true' AS [@json:Array],LookUpId,[Name],'' as ResourcesKey from LookUp where LookupCategory in (Select LookUpCategoryId from LookUpCategory where Name='Language') FOR XML path('CultureList'),ELEMENTS) AS xml))
  from Activity
FOR XML path('ActivityList'),ELEMENTS,ROOT('Json')) AS XML)	

END