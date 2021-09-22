Create PROCEDURE [dbo].[SSP_EmailContentByCriteria] 
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'EmailContentId'
AS


--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END
IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'EmailContentId' END

-- ISSUE QUERY
DECLARE @sql nvarchar(4000)

BEGIN
SET @sql = '
 SELECT CAST((SELECT [EmailContentId]
      ,[SupplierId]
      ,[CompanyId]
      ,[EmailEventId]
      ,[Subject]
      ,[EmailHeader]
      ,[EmailBody]
      ,[EmailFooter]
      ,[CCEmailAddress]
      ,[UserProfileId]
   
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
  FROM [dbo].[EmailContent] WHERE IsActive=1 and ' + @WhereExpression + '
ORDER BY ' + @SortExpression+'
  FOR XML RAW(''EmailContentList''),ELEMENTS,ROOT(''EmailContent'')) AS XML)'
 EXEC sp_executesql @sql
END
