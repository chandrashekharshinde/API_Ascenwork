CREATE PROCEDURE [dbo].[SSP_GetTransporterAccountDetailByCompanyId]--'<Json><ServicesAction>LoadOrderProductById</ServicesAction><CompanyId>1220</CompanyId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
Declare @CompanyId INT
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyId = tmp.[CompanyId]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[CompanyId] int
			)tmp ;


	



 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) select cast ((SELECT 'true' AS [@json:Array] ,
 TransporterAccountDetailId ,
  ObjectId ,
  AccountName,
   BankName ,
    AccountNumber ,
	AccountType,
	BankName+ '('+AccountNumber+')'  as 'AccountDisplay'
	 From  TransporterAccountDetail  where ObjectId=@CompanyId and isactive=1
 FOR XML path('TransporterAccountDetailList'),ELEMENTS,ROOT('Json')) AS XML)







END