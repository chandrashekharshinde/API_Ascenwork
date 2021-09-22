Create PROCEDURE [dbo].[DSP_FinancePartner] --'<Json><ServicesAction>LoadAllDeliveryLocation</ServicesAction><CompanyId>4</CompanyId></Json>'

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @financePartnerId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @financePartnerId = tmp.[FinancePatnerId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[FinancePatnerId] bigint
           
			)tmp ;


			
Update FinancePatner SET IsActive=0 where FinancePatnerId=@financePartnerId

Update TransporterAccountDetail SET IsActive=0 where ObjectId=@financePartnerId and ObjectType='FinancePartner'

Update ContactInformation SET IsActive=0 where ObjectId=@financePartnerId and ObjectType='FinancePartner'

Update FinanceTransporterMapping SET IsActive=0 where FinancePartnerId=@financePartnerId

 SELECT @financePartnerId as FinancePartnerId FOR XML RAW('Json'),ELEMENTS
END
