CREATE PROCEDURE [dbo].[SSP_GetTransporterAccountDetailByAccountName]--'<Json><ServicesAction>LoadOrderProductById</ServicesAction><CompanyId>1220</CompanyId></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
Declare @accountName nvarchar(300)
Declare @companyId bigint
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @accountName = tmp.[AccountName],
		@companyId=tmp.CompanyId

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			AccountName nvarchar(300),
			CompanyId bigint
			)tmp ;


	



 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) select cast ((SELECT 'true' AS [@json:Array] ,
 TransporterAccountDetailId ,
  ObjectId ,
  AccountName,
   BankName ,
    AccountNumber ,
	AccountType,
	BankName+ '('+AccountNumber+')'  as 'AccountDisplay'
	 From  TransporterAccountDetail  where AccountName=@accountName and ObjectId=@companyId and isactive=1
 FOR XML path('TransporterAccountDetailList'),ELEMENTS,ROOT('Json')) AS XML)







END


