CREATE PROCEDURE [dbo].[SSP_ByEmailEventId] --1
@emailEventId BIGINT
AS
BEGIN

	SELECT [EmailEventId]
      ,[SupplierId]
      ,[EventName]
      ,[EventCode]
      ,[Description]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
	FROM [dbo].[EmailEvent]
	 WHERE (EmailEventId=@emailEventId OR @emailEventId=0) AND IsActive=1
	FOR XML RAW('EmailEvent'),ELEMENTS
	
	
	
END
