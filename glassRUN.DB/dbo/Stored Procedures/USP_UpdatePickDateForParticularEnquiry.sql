CREATE PROCEDURE [dbo].[USP_UpdatePickDateForParticularEnquiry] --'<Json><ServicesAction>UpdatePickDateForParticularEnquiry</ServicesAction><EnquiryDetailList><PickDateTime>2019-06-22 00:00:00</PickDateTime><EnquiryId>27009</EnquiryId></EnquiryDetailList></Json>'
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
   @pickDateTime = tmp.[PickDateTime]
   

FROM OPENXML(@intpointer,'Json/EnquiryDetailList',2)
   WITH
   (
   [EnquiryId] bigint,   
   [PickDateTime] datetime
   )tmp
  

	update [Enquiry] set PickDateTime =  @pickDateTime where EnquiryId IN (@enquiryId)

  SELECT @enquiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS
   

END