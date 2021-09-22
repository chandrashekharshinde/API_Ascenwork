CREATE PROCEDURE [dbo].[SSP_AppLookupData]  

AS
BEGIN
	SELECT CAST((
	SELECT  [LookupID]
      ,[LookupCategory]
      ,[Name]
      ,[Code]
      ,[Description]
      ,[IsActive]
      ,[SortOrder]
      ,[ResourceKey]
      ,[Criteria]
	FROM [AppLookup]
	WHERE IsActive = 1
	FOR XML RAW('LookupList'),ELEMENTS,ROOT('Lookup')) AS XML)
	
END
