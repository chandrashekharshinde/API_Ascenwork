Create PROCEDURE [dbo].[SSP_EmailConfigurationByCriteria] 
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'EmailConfigurationId'
AS


--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'EmailConfigurationId' END

-- ISSUE QUERY
DECLARE @sql nvarchar(4000)

BEGIN
SET @sql = '
 SELECT CAST((SELECT  EmailConfigurationId ,
        SupplierId ,
        SMTPHost ,
        FromEmail ,
        UserName ,
        [Password] ,
        EmailBodyType ,
        PortNumber ,
        EnableSSL ,
        EmailSignature ,
        IsActive ,
        CreatedBy ,
        CreatedDate ,
        UpdatedBy ,
        UpdatedDate FROM dbo.EmailConfiguration WHERE IsActive=1 and ' + @WhereExpression + '
ORDER BY ' + @SortExpression+'
  FOR XML RAW(''EmailConfigurationList''),ELEMENTS,ROOT(''EmailConfiguration'')) AS XML)'
 EXEC sp_executesql @sql
END
