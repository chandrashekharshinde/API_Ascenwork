CREATE PROCEDURE [dbo].[SSP_AllEmailConfiguration] 
AS
BEGIN



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

SELECT CAST((SELECT  'true' AS [@json:Array],[EmailConfigurationId]
      ,[SupplierId]
      ,[SmtpHost]
      ,[FromEmail]
      ,[UserName]
      ,[Password]
      ,[EmailBodyType]
      ,[PortNumber]
      ,[EnableSsl]
      ,[EmailSignature]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
				   FROM EmailConfiguration WHERE IsActive = 1 
	FOR XML path('EmailConfigurationList'),ELEMENTS,ROOT('EmailConfiguration')) AS XML)
END
