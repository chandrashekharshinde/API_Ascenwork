CREATE PROCEDURE [dbo].[SSP_GetReceivingLocationBalanceCapacity_BySoldToId] --'<Json><ServicesAction>GetReceivingLocationBalanceCapacity</ServicesAction><CompanyId>1484</CompanyId><ShipTo>40799</ShipTo><ProposedDeliveryDate>12/04/2019</ProposedDeliveryDate><EnquiryId>26145</EnquiryId></Json>'

@xmlDoc XML='<Json></Json>'


AS
BEGIN

DECLARE @intPointer INT;
declare @CompanyId bigint
declare @ShipTo bigint
declare @EnquiryId bigint
declare @ProposedDeliveryDate nvarchar(30)



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @CompanyId = tmp.[CompanyId],@ShipTo = tmp.[ShipTo],@ProposedDeliveryDate=[ProposedDeliveryDate],@EnquiryId=[EnquiryId]
	
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[ProposedDeliveryDate] nvarchar(30),
				[ShipTo] bigint,
				[CompanyId] bigint,
				[EnquiryId] bigint
			)tmp;


declare @EnquiryTotalPalettes bigint=0
declare @OrderTotalPalettes bigint=0
select @EnquiryTotalPalettes=isnull(sum(NumberOfPalettes),0) from Enquiry where EnquiryId <> @EnquiryId and  CurrentState=1 and  CONVERT(date,ISNULL(RequestDate,OrderProposedETD))=CONVERT(date,CONVERT(datetime,@ProposedDeliveryDate,103)) and ShipTo=@ShipTo and SoldTo=@CompanyId 
select @OrderTotalPalettes=isnull(sum(NumberOfPalettes),0) from [Order] where EnquiryId <> @EnquiryId and CONVERT(date,ExpectedTimeOfDelivery)=CONVERT(date,CONVERT(datetime,@ProposedDeliveryDate,103)) and ShipTo=@ShipTo and SoldTo=@CompanyId 	

select  isnull(@EnquiryTotalPalettes+@OrderTotalPalettes,0)	FOR XML RAW('BalanceCapacity'),ELEMENTS	 					 




END
