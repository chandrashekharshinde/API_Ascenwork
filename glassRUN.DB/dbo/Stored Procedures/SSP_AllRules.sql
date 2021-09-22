CREATE PROCEDURE [dbo].[SSP_AllRules] --1

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
	 WHERE IsActive=1
	
	
	
	
END
