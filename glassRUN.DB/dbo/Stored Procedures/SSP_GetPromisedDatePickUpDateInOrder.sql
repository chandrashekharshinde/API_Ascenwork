


CREATE PROCEDURE [dbo].[SSP_GetPromisedDatePickUpDateInOrder] --'<Json><ServicesAction>LoadStockAndCarrierEnquiry</ServicesAction><EnquiryId>27005</EnquiryId><RoleId>3</RoleId><CultureId>1101</CultureId><UserId>507</UserId></Json>'

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;
declare @orderId BIGINT
declare @roleId BIGINT
declare @CultureId BIGINT


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @orderId = tmp.[OrderId],
@roleId = tmp.[RoleId],
@CultureId = tmp.[CultureId]

FROM OPENXML(@intpointer,'Json',2)
WITH
(
[OrderId] bigint,
[RoleId] bigint,
[CultureId] bigint
)tmp;



WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 

Select Cast((SELECT [OrderId]
,[OrderNumber]
,ExpectedTimeOfDelivery
,PickDateTime

FROM [dbo].[Order] o 

WHERE (o.OrderId=@orderId OR @orderId=0) AND o.IsActive=1
FOR XML path('OrderList'),ELEMENTS,ROOT('Json')) AS XML)



END