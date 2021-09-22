create PROCEDURE [dbo].[USP_UpdatePromisedDateInEnquiry] --'<Json><ServicesAction>UpdateSchedulingDate</ServicesAction><EnquiryDetailList><SchedulingDate>15/12/2017</SchedulingDate><EnquiryId>236</EnquiryId></EnquiryDetailList></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @enuiryId bigint
Declare @PromisedDate nvarchar(50)


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
    @enuiryId = tmp.[EnquiryId],
    @PromisedDate = tmp.[PromisedDate]
   
   

FROM OPENXML(@intpointer,'Json/EnquiryDetailList',2)
   WITH
   (
   [EnquiryId] bigint,
   [PromisedDate] nvarchar(50)  
           
   )tmp
  

  


  print @enuiryId

   update [Enquiry] set PromisedDate  = convert(datetime,@PromisedDate, 103) where EnquiryId = @enuiryId

   
   
   
   SELECT @enuiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS

END
