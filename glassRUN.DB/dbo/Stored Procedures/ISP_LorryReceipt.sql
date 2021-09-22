-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.EmailContent table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_LorryReceipt] --'<Json><ServicesAction>SaveLorryReceipt</ServicesAction><Order><OrderId>77484</OrderId><OrderInsuranceInformationList><OrderInsuranceInformationGUID>31f59570-eea3-4f7d-8fd7-b587bd394528</OrderInsuranceInformationGUID><PolicyNo>B0012344</PolicyNo><Remarks>test</Remarks><InsuranceTakenBy>shipper</InsuranceTakenBy><PolicyAmount>25000</PolicyAmount><GoodsInsured>1</GoodsInsured><IsActive>true</IsActive><CreatedBy>8</CreatedBy></OrderInsuranceInformationList><OrderInvoiceInformationList><OrderInvoiceInformationGUID>06e34279-a5e2-41ae-9b2a-bb8c6ff9a7f4</OrderInvoiceInformationGUID><InvoiceNo>AAA-00002</InvoiceNo><InvoiceDate>07/02/2019</InvoiceDate><InvoiceValue>290000</InvoiceValue><DeclaredValue>280000</DeclaredValue><EWayBillNo>AAA00034</EWayBillNo><IsActive>true</IsActive><CreatedBy>8</CreatedBy></OrderInvoiceInformationList><OrderFreightInformationList><OrderFreightInformationGUID>1ffeac31-3c3b-4821-afa8-9f884532f3ac</OrderFreightInformationGUID><Particulars>test charge</Particulars><ChargedBasis>weight</ChargedBasis><ChargedWeight>17</ChargedWeight><PerUnitCharge>2000</PerUnitCharge><Amount>2000</Amount><IsActive>true</IsActive><CreatedBy>8</CreatedBy></OrderFreightInformationList><OrderFreightInformationList><OrderFreightInformationGUID>8b5cccc4-fc1e-4d87-87e2-0960e8091368</OrderFreightInformationGUID><Particulars>test</Particulars><ChargedBasis>test weight</ChargedBasis><ChargedWeight>34</ChargedWeight><PerUnitCharge>2100</PerUnitCharge><Amount>3490</Amount><IsActive>true</IsActive><CreatedBy>8</CreatedBy></OrderFreightInformationList></Order></Json>'
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(max) 
	DECLARE @ErrMsg NVARCHAR(max) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	DECLARE @EmailEventId bigint;
	SET @ErrSeverity = 15; 

		BEGIN TRY
			EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
			Declare @orderId bigint
			Declare @GSTPaidBy nvarchar(250)
			Declare @GSTNo nvarchar(250)
			Declare @GSTPercentage bigint
			SELECT @orderId=tmp.[OrderId],
			 @GSTPaidBy=tmp.[GSTPaidBy],
			  @GSTNo=tmp.[GSTNo],
        		@GSTPercentage=tmp.[GSTPercentage]
            FROM OPENXML(@intpointer,'Json/Order',2)
        WITH
        (
            [OrderId] bigint ,
			[GSTPaidBy]  nvarchar(250),
			[GSTNo]  nvarchar(250),
			[GSTPercentage] bigint
            
        )tmp



		----delete associate reference table of Lorry Receipt


		delete OrderInsuranceDetail  where OrderId=@orderId
		delete OrderInvoiceDetail  where OrderId=@orderId

		delete OrderFreightDetail  where OrderId=@orderId

		delete LorryReceiptGSTDetail  where OrderId=@orderId

		----insert respective date of lorry receipt 

        INSERT INTO	[OrderInsuranceDetail]
        (
        	[OrderId]
      ,[GoodsInsured]
      ,[PolicyNo]
      ,[PolicyAmount]
      ,[Remarks]
      ,[InsuranceTakenBy]
	  ,[IsActive]
      ,[CreatedBy] 
	  ,[CreatedDate]
        )

        SELECT
        	@orderId,
        	tmp.[GoodsInsured],
        	tmp.[PolicyNo],
        	tmp.[PolicyAmount],
        	tmp.[Remarks],
        	tmp.[InsuranceTakenBy],        	
        	tmp.[IsActive],
        	tmp.[CreatedBy],
			GETDATE()
            FROM OPENXML(@intpointer,'Json/Order/OrderInsuranceInformationList',2)
        WITH
        (
            [OrderId] bigint,
            [GoodsInsured] bit,
            [PolicyNo] nvarchar(250),
            [PolicyAmount] decimal(18,2),
            [Remarks] nvarchar(250),
            [InsuranceTakenBy] nvarchar(250),           
            [IsActive] bit,
            [CreatedBy] bigint,
			[CreatedDate] datetime
        )tmp
        
      


		INSERT INTO [dbo].[OrderInvoiceDetail]
           (
      [OrderId]
      ,[InvoiceNo]
      ,[InvoiceDate]
      ,[InvoiceValue]
      ,[DeclaredValue]
      ,[EWayBillNo]
      ,[CreatedBy]
      ,[CreatedDate]
      
      ,[IsActive])
     SELECT
        	@orderId,
        	tmp.[InvoiceNo],
        	tmp.[InvoiceDate],
        	tmp.[InvoiceValue],
			tmp.[DeclaredValue],
			tmp.[EWayBillNo],
			tmp.[CreatedBy],
			getdate(),
			tmp.[IsActive]
            FROM OPENXML(@intpointer,'Json/Order/OrderInvoiceInformationList',2)
			WITH
        (
            [OrderId] bigint,
            [InvoiceNo] nvarchar(500),
            [InvoiceDate] datetime,
            [InvoiceValue] decimal(18,2),
			DeclaredValue decimal(18,2),
			EWayBillNo nvarchar(250),
           CreatedBy bigint,
		   CreatedDate datetime,		   
		   [IsActive] BIT
        )tmp

		
		 INSERT INTO [dbo].[OrderFreightDetail]
           (
      [OrderId]
	  ,Particulars
      ,[ChargedBasis]
      ,[ChargedWeight]
      ,[PerUnitCharge]
      ,[Amount]
      ,[CreatedBy]
      ,[CreatedDate]      
      ,[IsActive])
     SELECT
        	@orderId,
			tmp.[Particulars],
        	tmp.[ChargedBasis],
        	tmp.[ChargedWeight],
        	tmp.[PerUnitCharge],
			tmp.[Amount],			
			tmp.[CreatedBy],
			getdate(),
			tmp.[IsActive]
            FROM OPENXML(@intpointer,'Json/Order/OrderFreightInformationList',2)
			WITH
        (
            [OrderId] bigint,
			Particulars  nvarchar(500),
            ChargedBasis nvarchar(500),
            ChargedWeight nvarchar(500),
            PerUnitCharge nvarchar(500),
			Amount decimal(18,2),			
           CreatedBy bigint,
		   CreatedDate datetime,		   
		   [IsActive] BIT
        )tmp
			
			

			INSERT INTO [dbo].[LorryReceiptGSTDetail]
           ( [OrderId]
           ,[GSTPaidBy]
           ,[GSTNo]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive]
		   ,[GSTPercentage])
     VALUES(@orderId  ,@GSTPaidBy ,@GSTNo,1 , GETDATE(),1,@GSTPercentage)






		SELECT @orderId as OrderId , 'Success' as Message FOR XML RAW('Json'),ELEMENTS
    
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END