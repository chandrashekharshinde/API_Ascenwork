CREATE PROCEDURE [dbo].[SSP_RoleWiseFieldAccess_SelectByCriteria]
(
@PageIndex INT,
@PageSize INT,
@WhereExpression nvarchar(2000) = '1=1',
@SortExpression nvarchar(2000) = 'RoleWiseFieldAccessId'
)
AS

IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END

IF(RTRIM(@SortExpression) = '') BEGIN SET @SortExpression = 'RoleWiseFieldAccessId' END

BEGIN

Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)

	SET @sql = 'SELECT 
			   rfa.[RoleWiseFieldAccessId]
		      ,rfa.[RoleId]
			  ,rm.[RoleName]
		      ,rfa.[PageId]
			  ,p.[PageName]
		      ,rfa.[ResourceId]
			  ,res.[ResourceKey]
			  ,res.[ResourceValue]
		      ,rfa.[IsMandatory]
		      ,rfa.[IsVisible]
		      ,rfa.[ValidationExpression]
		      ,rfa.[Description]
		      ,rfa.[IsActive]
		      ,rfa.[CreatedBy]
		      ,rfa.[CreatedDate]
		      ,rfa.[UpdatedBy]
		      ,rfa.[UpdatedDate]
		      ,rfa.[IPAddress] 
		FROM dbo.RoleWiseFieldAccess rfa JOIN dbo.RoleMaster rm ON rfa.RoleId=rm.RoleMasterId
		JOIN dbo.Pages p ON rfa.PageId=p.PageId 
		JOIN dbo.Resources res ON rfa.ResourceId=res.ResourceId		  
		WHERE ' + @WhereExpression + ' ORDER BY '+@SortExpression+' ASC OFFSET ((' + CONVERT(NVARCHAR(10), @PageIndex) + ' * ' + CONVERT(NVARCHAR(10), @PageSize) + ')) ROWS FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

	PRINT @sql

	EXEC sp_executesql @sql

	SET @sqlTotalCount = 'SELECT Count(*) as TotalRowCount FROM  dbo.RoleWiseFieldAccess
		WHERE ' + @WhereExpression + ' '

	PRINT @sqlTotalCount

	EXEC sp_executesql @sqlTotalCount
END
