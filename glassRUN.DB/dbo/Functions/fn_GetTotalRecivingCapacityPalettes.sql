CREATE FUNCTION [dbo].[fn_GetTotalRecivingCapacityPalettes]
(@ProposedDeliveryDate datetime,@ShipTo bigint,@CompanyId bigint,@capacity bigint)
RETURNS bigint  
BEGIN
declare @TotalPalettes bigint=0
declare @EnquiryTotalPalettes bigint=0
declare @OrderTotalPalettes bigint=0
select @EnquiryTotalPalettes=isnull(sum(NumberOfPalettes),0) from [dbo].Enquiry where CurrentState=1 and  CONVERT(date,ISNULL(RequestDate,OrderProposedETD))=CONVERT(date,CONVERT(datetime,@ProposedDeliveryDate,103)) and ShipTo=@ShipTo and SoldTo=@CompanyId 
select @OrderTotalPalettes=isnull(sum(NumberOfPalettes),0) from [dbo].[Order] where CONVERT(date,ExpectedTimeOfDelivery)=CONVERT(date,CONVERT(datetime,@ProposedDeliveryDate,103)) and ShipTo=@ShipTo and SoldTo=@CompanyId 	

set @TotalPalettes =(@capacity) - (@EnquiryTotalPalettes+@OrderTotalPalettes)
return @TotalPalettes

END
