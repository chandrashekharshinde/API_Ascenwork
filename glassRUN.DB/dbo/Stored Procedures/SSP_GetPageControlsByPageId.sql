CREATE PROCEDURE [dbo].[SSP_GetPageControlsByPageId] --1
@pageId BIGINT
AS 
 BEGIN 
	
Select Cast((SELECT	o.ObjectId
      ,ObjectName
	  ,PageId
       ,  
	  (Cast((SELECT [ObjectPropertiesId] ,
	op.[ObjectId] ,
	PageId,
	[PropertyName] ,
	[ResourceKey] ,
	[OnScreenDisplay] 
		
  FROM [ObjectProperties] op  WHERE op.IsActive = 1 and op.ObjectId = o.ObjectId
	FOR XML RAW('ObjectPropertiesList'),ELEMENTS) AS XML))
 

    from [Object] o join PageObjectMapping pom on o.ObjectId = pom.ObjectId
   WHERE o.IsActive = 1 AND pom.PageId = @pageId

   FOR XML RAW('ObjectList'),ELEMENTS,ROOT('Object')) AS XML)
 
END
