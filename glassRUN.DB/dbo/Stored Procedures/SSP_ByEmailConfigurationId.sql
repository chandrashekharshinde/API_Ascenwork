CREATE PROCEDURE [dbo].[SSP_ByEmailConfigurationId] --1
@emailConfigurationId BIGINT
AS
BEGIN

	SELECT [EmailConfigurationId]
      ,[SupplierId]
      ,[SMTPHost]
      ,[FromEmail]
      ,[UserName]
      ,[Password]
      ,[EmailBodyType]
      ,[PortNumber]
      ,[EnableSSL]
      ,[EmailSignature]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
	FROM [dbo].[EmailConfiguration]
	 WHERE (EmailConfigurationId=@emailConfigurationId OR @emailConfigurationId=0) AND IsActive=1
	FOR XML RAW('EmailConfiguration'),ELEMENTS
	
	
	
END
