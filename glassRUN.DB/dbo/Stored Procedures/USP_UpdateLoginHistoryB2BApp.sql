CREATE PROCEDURE [dbo].[USP_UpdateLoginHistoryB2BApp] --'<Json><userName>Subd1</userName></Json>'
@xmlDoc XML
AS

BEGIN
DECLARE @intPointer INT;
-- ISSUE QUERY
DECLARE @sql nvarchar(4000);
Declare @username nvarchar(max);
Declare @EULAgreement nvarchar(max);
Declare @loginId bigint
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

SELECT @loginId=LoginId FROM [Login] where UserName = @username;



Update [Login] set IsAgree=1,EULAgreement=@EULAgreement,EULAAgreeDatetime=getdate() where LoginId=@loginId

SELECT  @loginId AS LoginId ,'Success' as Status FOR XML RAW('Json'),ELEMENTS
END
