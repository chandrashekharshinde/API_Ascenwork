CREATE PROCEDURE [dbo].[SSP_LoadNextStatusFromProceesConfiguration] --1,'EQ'
(
@EnquiryId bigint,
@ProcessCategory nvarchar(50)

)
AS


Declare @currentStatus bigint
Declare @NextStatus bigint



BEGIN

Select @currentStatus=CurrentState from Enquiry where EnquiryId = @EnquiryId




Select @NextStatus = NextStageId from ProcessConfiguration where ProcessCategory = @ProcessCategory and LastStageId = @currentStatus

select @NextStatus as NextState


END
