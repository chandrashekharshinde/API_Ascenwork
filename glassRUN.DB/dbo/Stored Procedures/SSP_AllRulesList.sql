CREATE PROCEDURE [dbo].[SSP_AllRulesList] 
AS	
BEGIN
SELECT CAST((
SELECT [RuleId]
     

      ,[Remarks]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]

  FROM [Rules] WHERE IsActive = 1
  FOR XML RAW('RulesList'),ELEMENTS,ROOT('Rules')) AS XML)
END
