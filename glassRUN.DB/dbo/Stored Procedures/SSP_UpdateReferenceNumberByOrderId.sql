Create PROCEDURE [dbo].[SSP_UpdateReferenceNumberByOrderId]

@xmlDoc XML


AS
BEGIN

DECLARE @intPointer INT;



EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


declare @orderId  bigint ;
declare @CurrentState  bigint ;
declare @ReferenceNumber  nvarchar(250) ;

select @orderId =tmp.OrderId,
@CurrentState =tmp.CurrentState,
@ReferenceNumber =tmp.[ReferenceNumber]
			FROM OPENXML(@intpointer,'Enquiry',2)
			 WITH
             (
		
					        
			OrderId bigint,		
				CurrentState  bigint,
				[ReferenceNumber]  nvarchar(250)
				
			 ) tmp



			 --------------------update orer table

			 update [order]  set  
			
			  CurrentState=@CurrentState   ,
			  ReferenceNumber=@ReferenceNumber
			   where OrderId=@orderId




			
	  SELECT @orderId as OrderId        FOR XML RAW('Json'),ELEMENTS


	
	
END
