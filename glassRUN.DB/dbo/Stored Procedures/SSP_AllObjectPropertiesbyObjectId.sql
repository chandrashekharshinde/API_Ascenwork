CREATE PROCEDURE [dbo].[SSP_AllObjectPropertiesbyObjectId] 
@objectId BIGINT
AS	
BEGIN
SELECT CAST((
SELECT   [ObjectPropertiesId] AS ObjectPropertyId
      ,[ObjectId]
	  ,(SELECT ObjectName FROM [Object] WHERE ObjectId=[ObjectProperties].[ObjectId]) AS ObjectName
      ,[PropertyName]
      ,[ResourceKey]	 
      ,[OnScreenDisplay]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
	  ,'false' AS IsChecked
	  ,'' AS DefaultValue
	  ,'false' AS Mandatory
	  ,'' AS ValidationExpression
  FROM [ObjectProperties] WHERE ObjectId=@objectId and IsActive = 1
  FOR XML RAW('ObjectPropertiesList'),ELEMENTS,ROOT('ObjectProperties')) AS XML)
END
