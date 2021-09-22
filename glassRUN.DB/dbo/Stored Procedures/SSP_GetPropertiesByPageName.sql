CREATE PROCEDURE [dbo].[SSP_GetPropertiesByPageName] 
@pageName nvarchar(150)
AS
BEGIN
SELECT CAST((
SELECT ob.PropertyName,o.ObjectId,o.ObjectName,p.PageId,p.PageName,ob.objectPropertiesId FROM dbo.Pages p INNER JOIN PageObjectMapping pom ON p.PageId=pom.PageId INNER JOIN object o ON o.ObjectId=pom.ObjectId
INNER JOIN objectproperties ob ON ob.ObjectId=o.ObjectId WHERE p.PageName=@pageName
 FOR XML RAW('ObjectList'),ELEMENTS,ROOT('Object')) AS XML)
  END
