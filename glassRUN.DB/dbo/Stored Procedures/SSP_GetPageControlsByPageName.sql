CREATE PROCEDURE [dbo].[SSP_GetPageControlsByPageName] --7,28
@pageName Nvarchar(500),
@roleId bigint
AS 
 BEGIN 
	
Select Cast((SELECT	o.ObjectId
      ,ObjectName
	  ,PageId
       ,  
	(Cast((SELECT op.[ObjectPropertiesId] ,
	op.[ObjectId] ,
	PageId,
	[PropertyName] ,
	AccessId,
	[ResourceKey] ,
	[OnScreenDisplay] 
		
    FROM [ObjectProperties] op left join RoleWiseFieldAccess rwfa on op.ObjectPropertiesId = rwfa.ObjectPropertiesId  WHERE op.IsActive = 1 and rwfa.IsActive= 1 and op.ObjectId = o.ObjectId
	FOR XML RAW('ObjectPropertiesList'),ELEMENTS) AS XML))
 

    from [Object] o join PageObjectMapping pom on o.ObjectId = pom.ObjectId
    WHERE o.IsActive = 1 AND pom.PageId in (select PageId from Pages where PageName = @pageName)

    FOR XML RAW('ObjectList'),ELEMENTS,ROOT('Object')) AS XML)
 
END
