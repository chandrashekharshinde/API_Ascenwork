
-- =============================================
-- Author:		Vinod Yadav
-- Create date: 30 01 2020
-- Description:	<Description,,>
-- exec [dbo].[USPApproveEnquiryV2] 1,'0'
-- exec [dbo].[USPApproveEnquiryV2] 0,'0'
-- exec [dbo].[USPApproveEnquiryV2] ,''
-- =============================================

Create PROCEDURE [dbo].[USP_ApproveEnquiryV2] 
(
@enuiryId bigint=0,
@requestDate nvarchar(50),
@IsRecievingLocationCapacityExceed nvarchar(10)

)
AS

BEGIN
		
	IF @enuiryId!=0
		begin
		update [Enquiry] set CurrentState  = 2 where EnquiryId = @enuiryId 

		if(@IsRecievingLocationCapacityExceed='1')
		BEGIN
		update Enquiry SET IsRecievingLocationCapacityExceed=1 where EnquiryId =@enuiryId and (RequestDate=@requestDate OR OrderProposedETD=@requestDate) and IsRecievingLocationCapacityExceed=0
		END
		SELECT @enuiryId as EnquiryId,'200' as Status
		end
	else
	begin
	SELECT @enuiryId as EnquiryId ,'404' as Status
	end
END
