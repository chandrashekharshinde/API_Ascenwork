CREATE PROCEDURE [dbo].[SSP_CheckPaymentRequestApplicableByOrderId]--'<Json><ServicesAction>LoadOrderProductById</ServicesAction><OrderId>77484</OrderId><ApplicableAfter>101</ApplicableAfter></Json>'
(
@xmlDoc XML
)
AS



BEGIN
Declare @sqlTotalCount nvarchar(4000)
Declare @sql nvarchar(4000)
Declare @OrderId INT
Declare @ApplicableAfter INT
DECLARE @intPointer INT;

EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc

SELECT @OrderId = tmp.[OrderId],
@ApplicableAfter =tmp.[ApplicableAfter]
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[OrderId] int,
			[ApplicableAfter] int
			)tmp ;


--SELECT @OrderId ,@ApplicableAfter

 Declare @SequnceForCurrentSate bigint 

 Declare   @SequnceForApplicable bigint 


 select   @SequnceForCurrentSate =SequenceNo  From  WorkFlowStep where StatusCode  in (select  CurrentState  From  [order]  where  OrderId=@OrderId)


  select  @SequnceForApplicable =SequenceNo  From  WorkFlowStep where StatusCode=@ApplicableAfter


  print   '@SequnceForCurrentSate'+convert(nvarchar(250),@SequnceForCurrentSate) 

    print   '@@SequnceForApplicable'+convert(nvarchar(250),@SequnceForApplicable)  

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

-- select  *From WorkFlowStep where   StatusCode in (     select  CurrentState  From  [order]  where  OrderId=@OrderId)
 



 select cast ((SELECT  @output as 'IsApplicable'   FOR XML path(''),ELEMENTS,ROOT('Json')) AS XML)





END
