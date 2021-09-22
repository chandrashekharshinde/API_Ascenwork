-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Friday, December 25, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.RoleMaster table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_InsertAndUpdateSalesOrderCustomerPayment]--'<Json><ServicesAction>InsertAndUpdateSalesOrderCustomerPayment</ServicesAction><SalesOrderNumber>34534555</SalesOrderNumber><IsPaid>true</IsPaid><IsPaidSpecified>true</IsPaidSpecified><PaidReason>343434</PaidReason><CreatedBy>1</CreatedBy></Json>'

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
            


			select * into #tempSalesOrderCustomerPayment
			  FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
               
            [SalesOrderNumber] nvarchar(250), 
			[Amount] nvarchar(250), 
		     [IsBilled] bit,           
              [IsBilledSpecified] bit,
			  [BilledReason] nvarchar(250),           
            [CreatedBy] bigint  ,
			[IsPaid] bit ,
			[PaidReason]  nvarchar(250) ,
			 [IsPaidSpecified] bit  
            )tmp 


			select * from #tempSalesOrderCustomerPayment

			 DECLARE @SalesOrderCustomerPaymentId bigint
	  

			-----insert  role master 
			INSERT INTO [dbo].[SalesOrderCustomerPayment] ([SalesOrderNumber] ,[Amount] ,[IsBilled] ,[BilledReason] ,[IsActive] ,[CreatedBy] ,[CreatedDate] )
						select #tempSalesOrderCustomerPayment.[SalesOrderNumber] , #tempSalesOrderCustomerPayment.[Amount]  , #tempSalesOrderCustomerPayment.[IsBilled],
						#tempSalesOrderCustomerPayment.[BilledReason]    , 1 ,1 ,GETDATE()
						 From   #tempSalesOrderCustomerPayment left join SalesOrderCustomerPayment socp  on #tempSalesOrderCustomerPayment.SalesOrderNumber  = socp.SalesOrderNumber
			 where socp.SalesOrderCustomerPaymentId  is  null



			   SET @SalesOrderCustomerPaymentId = @@IDENTITY

			   ---update  role master---


			   update  [dbo].[SalesOrderCustomerPayment]   set 

			   @SalesOrderCustomerPaymentId = socp.SalesOrderCustomerPaymentId,
			  IsPaid=#tempSalesOrderCustomerPayment.[IsPaid],
			 PaidReason=#tempSalesOrderCustomerPayment.[PaidReason]
			       from    #tempSalesOrderCustomerPayment  left join SalesOrderCustomerPayment socp  on #tempSalesOrderCustomerPayment.SalesOrderNumber  = socp.SalesOrderNumber
			 where socp.SalesOrderCustomerPaymentId  is not null



			
			--exec  USP_InsertAndUpdateRoleWisePageMappingAndRoleWiseFieldAccess @xmlDoc


			 SELECT @SalesOrderCustomerPaymentId as SalesOrderCustomerPaymentId FOR XML RAW('Json'),ELEMENTS
          
		  
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_RoleMaster'
