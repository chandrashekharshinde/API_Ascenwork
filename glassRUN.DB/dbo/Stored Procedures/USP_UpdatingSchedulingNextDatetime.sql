Create PROCEDURE [dbo].[USP_UpdatingSchedulingNextDatetime] --''
@SchedulingId bigint,
@NextSchedulingTime datetime

AS

BEGIN


update Scheduling set NextSchedulingTime =@NextSchedulingTime where SchedulingId=@SchedulingId

  SELECT @SchedulingId as SchedulingId FOR XML RAW('Json'),ELEMENTS

END
