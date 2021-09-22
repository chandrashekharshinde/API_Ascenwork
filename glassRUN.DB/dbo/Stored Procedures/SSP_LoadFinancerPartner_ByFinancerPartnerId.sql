CREATE PROCEDURE [dbo].[SSP_LoadFinancerPartner_ByFinancerPartnerId] --'<Json><ServicesAction>LoadOrderByOrderId</ServicesAction><OrderId>76580</OrderId><RoleId>3</RoleId></Json>'

@xmlDoc XML



AS
BEGIN

DECLARE @intPointer INT;
declare @FinancePartnerId nvarchar(100)
declare @roleId BIGINT
declare @CultureId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @FinancePartnerId = tmp.[FinancePartnerId]
       
 
FROM OPENXML(@intpointer,'Json',2)
   WITH
   (
    [FinancePartnerId] bigint

   )tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

 Select Cast((Select 'true' AS [@json:Array]  ,[FinancePatnerId]
      ,[FinancerName]
      ,[AddressLine1]
      ,[AddressLine2]
      ,[AddressLine3]
      ,[City]
      ,[State]
      ,[CountryId]
      ,[Country]
      ,[Postcode]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
	, (select cast ((SELECT  'true' AS [@json:Array]  ,  [TransporterAccountDetailId]
      ,[ObjectId]
      ,[ObjectType]
      ,[BankName] as AccountName
      ,[AccountNumber]
      ,[AccountTypeId]
      ,[AccountType]
      ,[IsActive]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[UpdatedBy]
      ,[UpdatedDate]
	  ,NEWID()  as 'AccountdetailGUID' from
	  [TransporterAccountDetail]  where IsActive=1 and [ObjectId]=[FinancePatner].[FinancePatnerId] and ObjectType='FinancePatner'
 FOR XML path('TransporterAccountDetailList'),ELEMENTS) AS xml)),

 (select cast ((SELECT  'true' AS [@json:Array]  ,[ContactInformationId]
      ,[ObjectId]
      ,[ObjectType]
      ,[ContactType] 
      ,[ContactPerson] as ContactPersonName
      ,[Contacts] as ContactPersonNumber
      ,[Purpose]
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
	  ,NEWID()  as 'ContactinfoGUID'
   from [ContactInformation]
   WHERE IsActive = 1  and [ObjectId]=[FinancePatner].[FinancePatnerId] and ObjectType='FinancePatner'
 FOR XML path('ContactPersonList'),ELEMENTS) AS xml)),


 (select cast ((SELECT  'true' AS [@json:Array]  ,[FinanceTransporterMappingId]
      ,[TransporterId]
	  ,(select top 1 c.CompanyName from Company c join [Profile] p on c.CompanyId=p.ReferenceId join Login l on l.ProfileId=p.ProfileId 	where c.CompanyType=28 AND c.IsActive=1 and c.CompanyId=[FinanceTransporterMapping].[TransporterId]) as Transporter
      ,[FinancePartnerId]
      ,[Amount]

	  ,	CONVERT(VARCHAR(10), [FromDate], 103) AS [FromDate]
	    ,	CONVERT(VARCHAR(10), [ToDate], 103) AS [ToDate]
	
      ,[CreatedBy]
      ,[CreatedDate]
      ,[ModifiedBy]
      ,[ModifiedDate]
      ,[IsActive]
	  ,NEWID()  as 'TransporterFinanceGUID'
   from [FinanceTransporterMapping]
   WHERE IsActive = 1  and [FinancePartnerId]=[FinancePatner].[FinancePatnerId] 
 FOR XML path('FinanceTransporterMappingList'),ELEMENTS) AS xml))
 FROM [dbo].[FinancePatner] WHERE (FinancePatnerId = @FinancePartnerId OR @FinancePartnerId = '') AND IsActive=1
 FOR XML path('FinancePatnerList'),ELEMENTS,ROOT('Json')) AS XML)
 
 
 
END