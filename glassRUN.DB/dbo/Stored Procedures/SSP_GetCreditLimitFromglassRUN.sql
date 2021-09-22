
CREATE PROCEDURE [dbo].[SSP_GetCreditLimitFromglassRUN] --'<Json><CompanyId>1483</CompanyId></Json>'

@xmlDoc XML='<Json><CompanyId>0</CompanyId></Json>'


AS
BEGIN

DECLARE @intPointer INT;
declare @CompanyId bigint




EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @CompanyId = tmp.[CompanyId]
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [CompanyId] bigint
   )tmp;


select Isnull(AvailableCreditLimit,0) as AvailableCreditLimit ,isnull(CreditLimit,0) as CreditLimit
from Company WITH (NOLOCK) where CompanyId=@CompanyId
FOR XML RAW('Json'),ELEMENTS      

END
