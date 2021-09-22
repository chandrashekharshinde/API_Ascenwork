
CREATE PROCEDURE [dbo].[USP_RejectEnquiry] --'<Json><SoNumber>S0001</SoNumber></Json>'
(
@xmlDoc XML
)
AS

BEGIN
DECLARE @intPointer INT;
Declare @EnquiryId bigint
Declare @RejectedStatus bigint=0

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT 
	   @EnquiryId = tmp.[EnquiryId]
	  
	  

FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
				[EnquiryId] bigint
			)tmp


select @RejectedStatus=isnull(RejectedStatus,0) from Activity where StatusCode =(Select top 1 CurrentState from Enquiry where EnquiryId = @EnquiryId)

update Enquiry set CurrentState  = @RejectedStatus where EnquiryId = @EnquiryId

INSERT INTO [EventNotification] ( [EventMasterId], [EventCode], [ObjectId], [ObjectType], [IsActive], [CreatedDate], [CreatedBy] ) 
select (select EventMasterId  From EventMaster where EventCode='EnquiryRejected' and IsActive=1 ), 'EnquiryRejected', o.EnquiryId , 'Enquiry',1 , GETDATE() , o.CreatedBy  From   Enquiry  o  where o.EnquiryId=@EnquiryId

SELECT @EnquiryId as EnquiryId FOR XML RAW('Json'),ELEMENTS

END
