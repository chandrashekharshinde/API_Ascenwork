CREATE PROCEDURE [dbo].[USP_ClearPreviousDataOfUser] --'<Json><userName>Subd026</userName></Json>'
@xmlDoc XML
AS

BEGIN
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(4000);
Declare @username nvarchar(max);
Declare @EULAgreement nvarchar(max);
Declare @loginId bigint
Declare @CompanyId bigint
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT 
 @username = tmp.[userName],
 @EULAgreement=tmp.[EULAgreement]
FROM OPENXML(@intpointer,'Json',2)
WITH
(
userName nvarchar(max),
EULAgreement nvarchar(max)

)tmp;

SELECT @loginId=LoginId,@CompanyId=ReferenceId FROM [Login] where UserName = @username;
DELETE FROM DefaultSupplier WHERE COMPANYID=@CompanyIdDELETE FROM ContactInformation WHERE ContactType='Photo' AND OBJECTID=@CompanyIdDELETE FROM NotificationPreferences WHERE CompanyId=@CompanyIdDELETE FROM CustomerPriority WHERE ParentCompanyId=@CompanyIdUPDATE LOGIN SET CompletedSetupStep=null,IsStepCompleted=NULL WHERE UserName=@username--DELETE FROM FavouriteItem WHERE COMPANYID=@CompanyId--DELETE FROM ItemSupplier WHERE CompanyId=@CompanyId AND ITEMID IN (SELECT ITEMID FROM ITEM WHERE ItemOwner=1)UPDATE LOGIN SET CompletedSetupStep=null,IsStepCompleted=NULL,IsAgree=0,EULAgreement=NULL,EULAAgreeDatetime=NULL WHERE UserName=@username--DELETE FROM LoginHistory WHERE Username=@username

SELECT  @loginId AS LoginId ,'Success' as Status FOR XML RAW('Json'),ELEMENTS
END
