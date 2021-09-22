CREATE PROCEDURE [dbo].[SSP_Rule_ByRuleId] --1
@RuleId BIGINT
AS
BEGIN

	SELECT [RuleId]

      ,[Remarks]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]

	FROM [dbo].[Rules]
	 WHERE (RuleId=@RuleId OR @RuleId=0) AND IsActive=1
	FOR XML RAW('@Rule'),ELEMENTS
	
	
	
END
