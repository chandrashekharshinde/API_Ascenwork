


Create PROCEDURE [dbo].[SSP_GetPromisedDatePickUpDateInEnquiry] --'<Json><ServicesAction>LoadStockAndCarrierEnquiry</ServicesAction><EnquiryId>27005</EnquiryId><RoleId>3</RoleId><CultureId>1101</CultureId><UserId>507</UserId></Json>'

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

Select Cast((SELECT [EnquiryId]
,[EnquiryAutoNumber]
,CONVERT(varchar(11),PromisedDate,103) as PromisedDateField
,CONVERT(varchar(11),PickDateTime,103) as PickDateTime


FROM [dbo].[Enquiry] e 

WHERE (e.EnquiryId=@enquiryId OR @enquiryId=0) AND e.IsActive=1
FOR XML path('EnquiryList'),ELEMENTS,ROOT('Json')) AS XML)



END