-- =============================================
-- Author:		Vinod
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_UserProfileAndLogin_SelectByCriteria] 
	-- Add the parameters for the stored procedure here
	@WhereExpression nvarchar(2000) = '1=1'
AS

--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END

-- ISSUE QUERY
DECLARE @sql nvarchar(4000)

SET @sql = '
SELECT CAST((u.[ProfileId],
      [RoleMasterId],

      [Name],
      --[MiddleName],
      --[LastName],
      [EmailId],
      --[AlternetEmail],
      [ContactNumber],
	  [UserName],
      u.[IsActive],
 
		   FROM Profile u Inner join Login l on u.ProfileId=l.ProfileId 
		  
		WHERE u.IsActive=1 And l.IsActive=1'  + @WhereExpression + ' FOR XML RAW(''ProfileList''),ELEMENTS,ROOT(''Profile'')) AS XML)'

	   PRINT @sql
-- Execute the SQL query
EXEC sp_executesql @sql
