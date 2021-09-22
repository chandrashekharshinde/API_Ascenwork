CREATE PROCEDURE [dbo].[USP_UpdateStatusInEnquiry] --'<Json><ServicesAction>UpdateStatusInEnquiry</ServicesAction><EnquiryId>213</EnquiryId><SchedulingDate>11/11/2017</SchedulingDate><IsRecievingLocationCapacityExceed>0</IsRecievingLocationCapacityExceed></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @enuiryId bigint
Declare @requestDate nvarchar(50)
Declare @IsRecievingLocationCapacityExceed nvarchar(10)

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	   @enuiryId = tmp.[EnquiryId],
	   @requestDate = tmp.[SchedulingDate],
	  @IsRecievingLocationCapacityExceed=tmp.[IsRecievingLocationCapacityExceed]
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EnquiryId] bigint,
			[SchedulingDate] nvarchar(50),
			[IsRecievingLocationCapacityExceed] nvarchar(10)
			
           
			)tmp



		

			update [Enquiry] set CurrentState  = 2 where EnquiryId = @enuiryId

			PRINt @IsRecievingLocationCapacityExceed

			if(@IsRecievingLocationCapacityExceed='1')
			BEGIN
			update Enquiry SET IsRecievingLocationCapacityExceed=1 where EnquiryId = (Select top 1 EnquiryId from Enquiry where (RequestDate=@requestDate OR OrderProposedETD=@requestDate) and IsRecievingLocationCapacityExceed=0 order by EnquiryDate desc)
			END
			SELECT @enuiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS

END
