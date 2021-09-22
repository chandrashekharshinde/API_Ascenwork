CREATE PROCEDURE [dbo].[USP_UpdateCurrentStateOfOrderNumberFromThirdParty]-- '<Json><OrderId>1674</OrderId><SalesOrderNumber>123</SalesOrderNumber><OrderNumber>123</OrderNumber><SoldToCode>1111355</SoldToCode><ShipToCode>1111355</ShipToCode><BranchPlantCode>6440</BranchPlantCode><ExpectedTimeOfDelivery>2017-12-04T00:00:00</ExpectedTimeOfDelivery><ReferenceNumber>543001469</ReferenceNumber><ServicesAction>GetCurrentStatusForOrderNumberFromThirdParty</ServicesAction><NextState>560</NextState><CurrentState>540</CurrentState></Json>'
@xmlDoc xml 
AS 
 BEGIN 
 SET ARITHABORT ON 
 DECLARE @TranName NVARCHAR(255) 
 DECLARE @ErrMsg NVARCHAR(2048) 
 DECLARE @ErrSeverity INT; 
 DECLARE @intPointer INT; 
 SET @ErrSeverity = 15; 

  BEGIN TRY
   EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


   select * into #tmpOrder
    FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
  [OrderId] bigint,
  [OrderNumber] nvarchar(150),
  [CurrentState]  bigint,
  [NextState] bigint ,
    [HoldStatus] nvarchar(150),
	 [InvoiceNumber] nvarchar(150)

   
        )tmp
   
  --select * from #tmpOrder
  DECLARE @orderId BIGINT
  DECLARE @OrderNumber nvarchar(200)
  DECLARE @CurrentState BIGINT
 DECLARE @NextState BIGINT
  DECLARE @HoldStatus nvarchar(200)
    DECLARE @InvoiceNumber nvarchar(200)
  

  SELECT @orderId=#tmpOrder.OrderId , @OrderNumber=#tmpOrder.OrderNumber  ,@CurrentState=#tmpOrder.CurrentState  ,@NextState=#tmpOrder.NextState , @HoldStatus =#tmpOrder.HoldStatus  , @InvoiceNumber=#tmpOrder.InvoiceNumber FROM #tmpOrder


  DECLARE @MappingCurrentState BIGINT
  DECLARE @MappingNextState BIGINT

  -----------------------get data from sale order mapping------


   select @MappingCurrentState= LocalOrderState from OrderStateMapping where ThirdPartyOrderSate=@CurrentState
   select @MappingNextState= LocalOrderState from OrderStateMapping where ThirdPartyOrderSate=@NextState

----------------Checking for current state SequenceNo----------------------
declare @JDStateSequenceNo int=0
declare @SystemStateSequenceNo int=0
declare @orderCurrentState bigint=0


Select @JDStateSequenceNo=ISNULL(SequenceNo,0) from LookUp where LookupCategory=7 and LookUpId=@MappingCurrentState

Select @orderCurrentState=o.CurrentState from [Order] o where o.OrderId=@orderId

Select @SystemStateSequenceNo=ISNULL(SequenceNo,0) from LookUp where LookupCategory=7 and LookUpId=@orderCurrentState

if @SystemStateSequenceNo > @JDStateSequenceNo
begin
set @MappingCurrentState=@orderCurrentState
end
else

----------------End Checking for current state SequenceNo----------------------

   if(@MappingCurrentState > 0)
   begin



   if(@MappingCurrentState = 3)
   begin


   UPDATE dbo.[Order] SET OrderNumber=@OrderNumber,SalesOrderNumber=@OrderNumber 
  ,PreviousState =CurrentState
  ,CurrentState=@MappingCurrentState
  ,NextState =@MappingNextState
  
   WHERE OrderId=@orderId  and CurrentState !=@MappingCurrentState and CurrentState not in(36)

   end
   else
   begin

   UPDATE dbo.[Order] SET OrderNumber=@OrderNumber,SalesOrderNumber=@OrderNumber 
  ,PreviousState =CurrentState
  ,CurrentState=@MappingCurrentState
  ,NextState =@MappingNextState
  
   WHERE OrderId=@orderId  and CurrentState !=@MappingCurrentState

   end


   
   
   
   if(@MappingCurrentState =34)
   
   begin
   
   update EnquiryProduct 
   set IsActive=0
     
   where AssociatedOrder !=0 and EnquiryId in (select EnquiryId From [Order] where  currentState =34 and OrderId=@orderId )
   
   
   update OrderProduct 
   set IsActive=0
     
   where AssociatedOrder !=0 and OrderId in (select OrderId From [Order] where  currentState =34 and OrderId=@orderId )
   
   
   end
   
  
   

   end

  
  UPDATE dbo.[Order] SET 
  HoldStatus=@HoldStatus
  ,InvoiceNumber = (case when (@InvoiceNumber ='0')  then  ''  else @InvoiceNumber end)

   WHERE OrderId=@orderId  


         SELECT @orderId as OrderId FOR XML RAW('Json'),ELEMENTS
    
   
    exec sp_xml_removedocument @intPointer  
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
