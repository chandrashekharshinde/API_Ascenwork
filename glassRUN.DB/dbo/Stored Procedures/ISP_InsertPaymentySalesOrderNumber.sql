-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleMaster table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_InsertPaymentySalesOrderNumber]--'<Json><ServicesAction>InsertBillingBySalesOrderNumber</ServicesAction><SalesOrderNumber>SO-3003</SalesOrderNumber><InvoiceAmount>234234</InvoiceAmount><BillingDate>234</BillingDate><Remarks>23423423</Remarks><InvoiceNumber>234234</InvoiceNumber></Json>'

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
            


			select * into #tempSalesOrderPayment
			  FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
               
            [SalesOrderNumber] nvarchar(250), 
			[PaymentDate] nvarchar(250), 
		     [ModeOfPaymentType] bigint,           
               [Remarks] nvarchar(250),
			    [PaymentAmount] nvarchar(250) ,            
           ReferenceNumber nvarchar(250),
		   BankName nvarchar(250)
			
            )tmp 


			--select * from #tempSalesOrderBilling

			 DECLARE @SalesOrderPaymentId bigint
	  

			-----insert  role master 
			INSERT INTO [dbo].[SalesOrderPayment] ([SalesOrderNumber] ,[PaymentDate] ,[ModeOfPaymentType] ,[PaymentAmount],[Remarks] , [ReferenceNumber],[BankName] )
						select #tempSalesOrderPayment.[SalesOrderNumber] , #tempSalesOrderPayment.[PaymentDate]  , #tempSalesOrderPayment.[ModeOfPaymentType],
						#tempSalesOrderPayment.[PaymentAmount]  , #tempSalesOrderPayment.[Remarks] ,#tempSalesOrderPayment.[ReferenceNumber] ,#tempSalesOrderPayment.[BankName]     
						 From   #tempSalesOrderPayment 
			



			   SET @SalesOrderPaymentId = @@IDENTITY

			 


			 SELECT @SalesOrderPaymentId as SalesOrderPaymentId FOR XML RAW('Json'),ELEMENTS
          
		  
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_RoleMaster'
