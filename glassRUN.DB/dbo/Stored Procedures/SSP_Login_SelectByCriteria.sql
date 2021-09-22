-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SSP_Login_SelectByCriteria] 
	-- Add the parameters for the stored procedure here
	@WhereExpression nvarchar(2000) = '1=1'
AS

--CHECK FOR EMPTY STRING PARAMETERS
IF(RTRIM(@WhereExpression) = '') BEGIN SET @WhereExpression = '1=1' END

-- ISSUE QUERY
DECLARE @sql nvarchar(4000)

SET @sql = '
SELECT CAST((SELECT LoginId ,
       UserProfileId ,
       UserName ,
       HashedPassword ,
       PasswordSalt ,
       LoginAttempts ,
       AccessKey ,
       LastLogin ,
       ExpiryDate ,
       LastPasswordChange ,
       ChangePasswordonFirstLoginRequired ,
       IsActive ,
       CreatedDate ,
       CreatedBy ,
       CreatedFromIPAddress ,
       UpdatedDate ,
       UpdatedBy ,
       UpdatedFromIPAddress FROM dbo.Login WHERE IsActive = 1 and ' + @WhereExpression + ' FOR XML RAW(''LIST''),ELEMENTS,ROOT(''tablename'')) AS XML)'

	   PRINT @sql
-- Execute the SQL query
EXEC sp_executesql @sql
