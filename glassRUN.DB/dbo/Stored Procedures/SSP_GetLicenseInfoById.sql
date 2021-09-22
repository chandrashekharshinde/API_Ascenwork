CREATE PROCEDURE [dbo].[SSP_GetLicenseInfoById] 
@licenseId BIGINT
AS
BEGIN
	Select Cast((SELECT LicenseId
						,CustomerCode
						,ProductCode
						,ActivationCode
						,CONVERT(varchar(11),FromDate,103) as FromDate
						,CONVERT(varchar(11),ToDate,103) as ToDate
						,UserTypeCode
						,NoOfUsers
						,LicenseType
						,IPAddress
						,Type
						,IsActive
						,(select cast ((SELECT l.LoginId from [Login] l   WHERE l.ActivationCode = [LicenseInfo].ActivationCode
							FOR XML RAW('IndividualLicenseUserList'),ELEMENTS) AS xml))
	FROM [dbo].[LicenseInfo]
	WHERE (LicenseId=@licenseId) --AND IsActive=1
	FOR XML RAW('LicenseInfoList'),ELEMENTS,ROOT('LicenseInfo')) AS XML)
END
