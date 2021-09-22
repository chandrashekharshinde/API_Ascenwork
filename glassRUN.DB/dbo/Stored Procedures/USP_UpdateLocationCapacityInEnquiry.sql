Create PROCEDURE [dbo].[USP_UpdateLocationCapacityInEnquiry] --'<Json><ServicesAction>UpdateStatusInEnquiry</ServicesAction><EnquiryId>66</EnquiryId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @enuiryId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	   @enuiryId = tmp.[EnquiryId]
	  
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EnquiryId] bigint
			
			
           
			)tmp



		

			update [Enquiry] set IsRecievingLocationCapacityExceed  = 1 where EnquiryId = @enuiryId

			SELECT @enuiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS

END
