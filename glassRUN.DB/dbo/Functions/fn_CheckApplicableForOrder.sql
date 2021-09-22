create FUNCTION [dbo].[fn_CheckApplicableForOrder]
(@OrderId bigint,
@ApplicableAfter bigint)
RETURNS bit

BEGIN
Declare @SequnceForCurrentSate bigint 

 Declare   @SequnceForApplicable bigint 


 select   @SequnceForCurrentSate =SequenceNo  From  WorkFlowStep where StatusCode  in (select  CurrentState  From  [order]  where  OrderId=@OrderId)


  select  @SequnceForApplicable =SequenceNo  From  WorkFlowStep where StatusCode=@ApplicableAfter


 

  if(@SequnceForCurrentSate is null)
  begin
  set @SequnceForCurrentSate =10000000
  end



  declare @output bit

  set  @output  =0

  if(@SequnceForCurrentSate   >=  @SequnceForApplicable )
  begin

  set @output =1

  end



 return @output
END
