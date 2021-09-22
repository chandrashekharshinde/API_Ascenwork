CREATE PROCEDURE [dbo].[SSP_UpdateEnquiryStatus_ByEnquiryId] --'EQ',2
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @EnquiryId INT
Declare @StatusId INT

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	   @EnquiryId = tmp.[EnquiryId],
	   @StatusId = tmp.[StatusId]
	  
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[EnquiryId] int,
			[StatusId] int
			
           
			)tmp


			
			update Enquiry set PreviousState  = (Select CurrentState from Enquiry where EnquiryId =  @EnquiryId)

			update Enquiry set CurrentState  = @StatusId where EnquiryId = @EnquiryId

			SELECT @EnquiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS

END
