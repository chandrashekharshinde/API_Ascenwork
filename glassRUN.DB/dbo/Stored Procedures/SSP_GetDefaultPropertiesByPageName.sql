CREATE PROCEDURE [dbo].[SSP_GetDefaultPropertiesByPageName]-- 'Order'
@pageName nvarchar(150)
AS
BEGIN
SELECT CAST((SELECT
		       obv.objectId
			  ,ObjectName
			  ,VersionNumber
			  ,(SELECT CAST(( SELECT ObjectPropertyId			  
			  ,(SELECT PropertyName FROM ObjectProperties WHERE ObjectPropertiesId=ObjectVersionDefaults.ObjectPropertyId) AS PropertName
			  ,DefaultValue
			   FROM ObjectVersionDefaults
			   WHERE ObjectVersionId=obv.ObjectVersionId AND IsActive=1
			   FOR XML RAW('ObjectVersionDefaultsList'),ELEMENTS) AS xml))
			  --  ,(SELECT CAST(( SELECT [ObjectPropertiesId]	
			  --  ,[ResourceKey]
			  --,[PropertyName]
			  -- FROM [ObjectProperties]
			  -- WHERE ObjectId=obv.ObjectId AND IsActive=1
			  -- FOR XML RAW('ObjectPropertiesList'),ELEMENTS) AS xml))
              FROM ObjectVersion obv JOIN dbo.pageobjectmapping pog ON pog.ObjectId=obv.ObjectId JOIN dbo.Pages pg ON pg.PageId=pog.PageId
			  WHERE pg.PageName='Order'
             FOR XML RAW('ObjectVersionList'),ELEMENTS,ROOT('ObjectVersion')) AS XML)
			  --FOR XML RAW(''),ELEMENTS,ROOT('ObjectVersion')
  





 END
