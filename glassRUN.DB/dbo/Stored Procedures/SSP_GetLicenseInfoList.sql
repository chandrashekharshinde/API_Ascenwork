
CREATE PROCEDURE [dbo].[SSP_GetLicenseInfoList] 
AS
BEGIN
Declare @totalUserCount int

Select @totalUserCount=Count(LoginId) from Login where IsActive=1
Update LicenseInfo set NoOfUsers=@totalUserCount

;WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
	SELECT CAST((
		SELECT  'true' AS [@json:Array] ,[LicenseId], [CustomerCode], [ProductCode], [ActivationCode], [FromDate], [ToDate], [UserTypeCode], [NoOfUsers], [LicenseType], [IPAddress],'Admin' as [UserName]
			
		FROM [LicenseInfo]
	FOR XML PATH('LicenseInfoList'),ELEMENTS,ROOT('LicenseInfo')) AS XML)
END
