-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleMaster table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_InsertBillingBySalesOrderNumber]--'<Json><ServicesAction>InsertBillingBySalesOrderNumber</ServicesAction><SalesOrderNumber>SO-3003</SalesOrderNumber><InvoiceAmount>234234</InvoiceAmount><BillingDate>234</BillingDate><Remarks>23423423</Remarks><InvoiceNumber>234234</InvoiceNumber></Json>'

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
            


			select * into #tempSalesOrderBilling
			  FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
               
            [SalesOrderNumber] nvarchar(250), 
			[InvoiceAmount] nvarchar(250), 
			[BillingDate] nvarchar(250),
		     [InvoiceNumber] bit,           
               [Remarks] nvarchar(250)          
           
			
            )tmp 


			--select * from #tempSalesOrderBilling

			 DECLARE @SalesOrderBillingId bigint
	  

			-----insert  role master 
			INSERT INTO [dbo].[SalesOrderBilling] ([SalesOrderNumber] ,[InvoiceAmount] ,[InvoiceNumber] ,[Remarks],[BillingDate]  )
						select #tempSalesOrderBilling.[SalesOrderNumber] , #tempSalesOrderBilling.[InvoiceAmount]  , #tempSalesOrderBilling.[InvoiceNumber],
						#tempSalesOrderBilling.[Remarks]   ,#tempSalesOrderBilling.[BillingDate] 
						 From   #tempSalesOrderBilling left join SalesOrderBilling sob  on #tempSalesOrderBilling.SalesOrderNumber  = sob.SalesOrderNumber
			 where sob.SalesOrderBillingId  is  null



			   SET @SalesOrderBillingId = @@IDENTITY

			 


			 SELECT @SalesOrderBillingId as SalesOrderBillingId FOR XML RAW('Json'),ELEMENTS
          
		  
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_RoleMaster'
