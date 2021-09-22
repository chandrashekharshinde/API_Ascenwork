CREATE PROCEDURE [dbo].[SSP_ObjectVersionDetails_ByObjectVersionId] --7
@ObjectVersionId BIGINT
AS 
 BEGIN 
	
Select Cast((SELECT	 [ObjectVersionId]
      ,[ObjectId]
      ,[ObjectName]
      ,[VersionNumber]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
	  ,(select cast ((SELECT	[ObjectVersionDefaultsId]
      ,[ObjectVersionId]
      ,[ObjectId]
      ,[ObjectPropertyId]
      ,[DefaultValue]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
		from [ObjectVersionDefaults] obbd
   WHERE obbd.IsActive = 1 AND obbd.ObjectVersionId = [ObjectVersion].ObjectVersionId 
 FOR XML RAW('ObjectVersionDefaultsList'),ELEMENTS) AS xml))
 , (select cast ((SELECT [ObjectVersionPropertiesId]
      ,[ObjectVersionId]
      ,[ObjectId]
      ,[ObjectPropertyId]
      ,[Mandatory]
      ,[ValidationExpression]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
		from [ObjectVersionProperties] obvp
   WHERE obvp.IsActive = 1 AND obvp.ObjectVersionId = [ObjectVersion].ObjectVersionId 
 FOR XML RAW('ObjectVersionPropertiesList'),ELEMENTS) AS xml))

	  from [ObjectVersion]
   WHERE IsActive = 1 AND ObjectVersionId = @ObjectVersionId


 FOR XML RAW('ObjectVersionList'),ELEMENTS,ROOT('ObjectVersion')) AS XML)
 
END
