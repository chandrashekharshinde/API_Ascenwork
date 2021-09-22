-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleMaster table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_PaymentRequest] --'<Json><ServicesAction>UpdatePaymentRequest</ServicesAction><PaymentRequestList><rownumber>6</rownumber><TotalCount>30</TotalCount><PaymentRequestId>131</PaymentRequestId><OrderNumber>UCILS/006/01382/02</OrderNumber><SalesOrderNumber>UCILS/006/01382</SalesOrderNumber><PurchaseOrderNumber>UEI 4838345</PurchaseOrderNumber><SoldToName>Consignee 1</SoldToName><SoldToCode>C1</SoldToCode><SlabName>Final</SlabName><SlabReason/><Amount>6216.0000</Amount><Status>2202</Status><RequestDate>2019-02-26T16:16:30.17</RequestDate><CompanyId>1405</CompanyId><CarrrierCode/><CarrierName>Transporter 2</CarrierName><CarrierNumber>1405</CarrierNumber><OrderId>77698</OrderId><TripCost>8880.0000</TripCost><TripRevenue>9990.0000</TripRevenue><StatusDescription>Payment Requested</StatusDescription><Class>AwaitingApproval_Status</Class><CollectedDate>2019-02-26T20:57:00</CollectedDate><DeliveredDate>2019-02-27T00:00:00</DeliveredDate><DriverName>TP1</DriverName><TruckPlateNumber>AP 03 R 43993</TruckPlateNumber><CheckedEnquiry>true</CheckedEnquiry><TransporterAccountDetailId>DANNY</TransporterAccountDetailId><IsTransporterAccountDetailIdSpecified>true</IsTransporterAccountDetailIdSpecified><IsStatusSpecified>true</IsStatusSpecified><ActionType>Clear</ActionType></PaymentRequestList></Json>'

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
            


			select * into #tempPaymentRequestList
			  FROM OPENXML(@intpointer,'Json/PaymentRequestList',2)
			WITH
			(
              [CompanyId] bigint,
            [PaymentRequestId] bigint,
			[Status] bigint,
			[IsStatusSpecified] bit,
			  [Amount] decimal (18,4) ,
			  PaidAmount decimal (18,4) ,
			[AmountUnit] bigint ,
			[SlabReason] nvarchar(100),
			[ReasonCodeId] bigint,
			[IsResetSpecified] bit,
			TransporterAccountDetailId nvarchar(100),
           	  IsTransporterAccountDetailIdSpecified bit ,
			  ActionType nvarchar(10)
            )tmp 
			--Select * from #tempPaymentRequestList

			Declare @actionType nvarchar(50)
			DEclare @TransporterAccountDetailIden bigint=0
			Declare @conmpanyId bigint
			Declare @TransporterAccountDetail nvarchar(50)
			SET @actionType=(Select ActionType from #tempPaymentRequestList)
			SET @conmpanyId=(Select CompanyId from #tempPaymentRequestList)
			if @actionType = 'Add'
			BEGIN
			
		INSERT INTO [TransporterAccountDetail]
        (
         
		[ObjectId]
		,[ObjectType]
		,[AccountName]
		,[BankName]
		,[AccountNumber]
		,[AccountTypeId]
		,[AccountType]
		,[IsActive]
		,[CreatedBy]
		,[CreatedDate]
    

    
        )

        SELECT
         @conmpanyId,
         'Company',
         UPPER(tmp.[AccountName]),
         tmp.[BankName], 
		 tmp.[AccountNumber], 
		 tmp.[AccountType],  
		 (Select top 1 Name from LookUp where LookUpId=tmp.[AccountType]),
         1,
		 1,
         GETDATE()
   
         
            FROM OPENXML(@intpointer,'Json/PaymentRequestList/BankDetailListy',2)
        WITH
        (
            [AccountName] nvarchar(100),
            [BankName] nvarchar(100),
            [AccountNumber] nvarchar(150),
            [AccountType] bigint,
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime     
            
        )tmp
		
		SET @TransporterAccountDetail = @@IDENTITY
	END
	ELSE
	BEGIN
	Print '2'
	--SET @TransporterAccountDetail=(Select (case when   #tempPaymentRequestList.[IsTransporterAccountDetailIdSpecified] = 1 then  #tempPaymentRequestList.[TransporterAccountDetailId]   else pr.TransporterAccountDetailId  end )  from #tempPaymentRequestList)
	END
			--select *From #tempPaymentRequestList
			
Print @TransporterAccountDetailIden
Print 'es'



 -------insert PaymentRequestHistory   

			

			 INSERT INTO PaymentRequestHistory SELECT *  FROM PaymentRequest  pr  where  pr.PaymentRequestId    in (  select   #tempPaymentRequestList.PaymentRequestId from 
			 #tempPaymentRequestList   where  [IsResetSpecified]=1    )  and    pr.Status=2203


----update notfication request table by messageid and email address
			 update PaymentRequest   
   set      
   Status = (case when   #tempPaymentRequestList.[IsStatusSpecified] = 1 then     #tempPaymentRequestList.[Status]   else pr.Status  end ),
   Amount = (case when   #tempPaymentRequestList.[IsResetSpecified] = 1 then     #tempPaymentRequestList.[Amount]   else #tempPaymentRequestList.[Amount]  end ),
   PaidAmount = (case when   #tempPaymentRequestList.[IsResetSpecified] = 1 then     #tempPaymentRequestList.PaidAmount   else #tempPaymentRequestList.PaidAmount  end ),
   AmountUnit = (case when   #tempPaymentRequestList.[IsResetSpecified] = 1 then     #tempPaymentRequestList.[AmountUnit]   else pr.AmountUnit  end ),
   SlabReason = (case when   #tempPaymentRequestList.[IsResetSpecified] = 1 then     #tempPaymentRequestList.[SlabReason]   else pr.SlabReason  end ),
   TransporterAccountDetailId =Case when @TransporterAccountDetailIden=0 then (case when   #tempPaymentRequestList.[IsTransporterAccountDetailIdSpecified] = 1 then ( Select top 1 TransporterAccountDetailId from TransporterAccountDetail where accountname= #tempPaymentRequestList.[TransporterAccountDetailId])   else pr.TransporterAccountDetailId  end) else @TransporterAccountDetailIden end ,
			ReasonCodeId=#tempPaymentRequestList.[ReasonCodeId]
			 from 
			 #tempPaymentRequestList  join  PaymentRequest  pr on pr.PaymentRequestId=#tempPaymentRequestList.[PaymentRequestId]  
			 where pr.PaymentRequestId is not null

			



			 SELECT 'Success' as OutputMessage FOR XML RAW('Json'),ELEMENTS
          
		  
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure ISP_EventNotification'