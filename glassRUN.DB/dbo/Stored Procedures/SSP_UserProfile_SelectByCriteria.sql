-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_UserProfile_SelectByCriteria] 
	-- Add the parameters for the stored procedure here
	@WhereExpression nvarchar(2000) = '1=1'
AS

--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END

-- ISSUE QUERY
DECLARE @sql nvarchar(4000)

SET @sql = '
SELECT CAST((SELECT UserProfileId ,
       RoleMasterId ,
       FirstName ,
       MiddlelName ,
       LastName ,
       Email ,
       UserProfilePicture ,
       IsActive ,
       CreatedDate ,
       CreatedBy ,
       CreatedFromIPAddress ,
       UpdatedDate ,
       UpdatedBy ,
       UpdatedFromIPAddress FROM dbo.UserProfile WHERE IsActive = 1 and ' + @WhereExpression + ' FOR XML RAW(''LIST''),ELEMENTS,ROOT(''tablename'')) AS XML)'

	   PRINT @sql
-- Execute the SQL query
EXEC sp_executesql @sql
