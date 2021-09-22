Create PROCEDURE [dbo].[SSP_LoadCreditCheck_ByEnquiryId] --'<Json><ServicesAction>LoadEnquiryByEnquiryId</ServicesAction><EnquiryId>503</EnquiryId><RoleId>3</RoleId></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @enquiryId BIGINT
declare @roleId BIGINT
declare @CultureId BIGINT


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @enquiryId = tmp.[EnquiryId],
       @roleId = tmp.[RoleId],
       @CultureId = tmp.[CultureId]

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[EnquiryId] bigint,
				[RoleId] bigint,
				[CultureId] bigint
			)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  

	Select Cast((
Select *,(AvailableCreditLimit-TotalPendingEnquiryAmount) as CalculatedCredit from (
SELECT [EnquiryId]
      ,[EnquiryAutoNumber],isnull(c.CreditLimit,0) as CreditLimit,isnull(c.AvailableCreditLimit,0) as AvailableCreditLimit ,
	  (SELECT ISNULL([dbo].[fn_PendingEnquiryTotalAmount] (e.SoldTo,e.CreatedDate),0)) as TotalPendingEnquiryAmount
	FROM [dbo].[Enquiry] e left join TruckSize ts on e.TruckSizeId = ts.TruckSizeId
	  left join Company c on c.CompanyMnemonic = e.SoldTo
	 WHERE (EnquiryId=@enquiryId OR @enquiryId=0) AND e.IsActive=1) as t
	FOR XML path('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)
	
END
