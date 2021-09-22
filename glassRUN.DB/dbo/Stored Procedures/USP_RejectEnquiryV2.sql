
-- =============================================
-- Author:		Vinod Yadav
-- Create date: 29 jan 2020
-- Description:	<Description, Change Status Reject in Enquiry table,>
-- exec [dbo].[USP_RejectEnquiryV2] 1291,0
-- =============================================

CREATE PROCEDURE [dbo].[USP_RejectEnquiryV2]

@EnquiryId bigint=0,
@RejectedStatus bigint=0

AS

BEGIN
IF @EnquiryId!=0
BEGIN
IF @RejectedStatus=0
	Begin

	select @RejectedStatus=isnull(RejectedStatus,0) from Activity where StatusCode =(Select top 1 CurrentState from Enquiry where EnquiryId = @EnquiryId)

	end

update Enquiry set CurrentState  = @RejectedStatus where EnquiryId = @EnquiryId

SELECT @EnquiryId as EnquiryId,'200' Status

end
	ELSE

	BEGIN
		SELECT @EnquiryId as EnquiryId,'405' Status
	END

end