Create PROCEDURE [dbo].[USP_UpdateRequestedDateForParticularEnquiry] 
(
@xmlDoc XML
)
AS

BEGIN
Declare @sql nvarchar(max);
DECLARE @intPointer INT;
Declare @enquiryId bigint
Declare @requestedDate datetime
Declare @pickDateTime datetime


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @enquiryId = tmp.[EnquiryId],
    @requestedDate = tmp.[RequestedDate],
   @pickDateTime = tmp.[PickDateTime]
   

FROM OPENXML(@intpointer,'Json/EnquiryDetailList',2)
   WITH
   (
   [EnquiryId] bigint,
   [RequestedDate] datetime,
   [PickDateTime] datetime
   )tmp
  

	update [Enquiry] set PromisedDate  = @requestedDate,PickDateTime = @pickDateTime where EnquiryId IN (@enquiryId)

  SELECT @enquiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS
   

END