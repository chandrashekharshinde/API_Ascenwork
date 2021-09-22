
 
CREATE PROCEDURE [dbo].[USP_UpdateManageCustomerB2BApp] -- ''

@xmlDoc xml
AS
BEGIN 
	SET ARITHABORT ON 
	DECLARE @TranName NVARCHAR(255)
	DECLARE @ErrMsg NVARCHAR(2048)
	DECLARE @ErrSeverity INT;
	DECLARE @intPointer INT;
	DECLARE @modifiedBy bigINT;
	SET @ErrSeverity = 15; 

	BEGIN TRY
	
		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
        DECLARE @UserId bigint;

		--SELECT * INTO #tmpParentCustList
		--FROM OPENXML(@intpointer,'Json/CustomerList',2)
		--	WITH
  --      (
		--[LookUpId] BIGINT,
		--[CustomerGroupName] nvarchar(500),
		--[Img] nvarchar(Max),
		--[IsSynced] bit,
		--[ModifiedBy] BIGINT
		--)tmp 

		

	   SELECT * INTO #tmpCustList

		FROM OPENXML(@intpointer,'Json/CustomerList',2)
			WITH
        (
		[CompanyId] bigint,
		[PriorityRating] bigint,
		[CompanyMnemonic] nvarchar(500),
		[ParentCompanyId] bigint,
		[ParentCompanyCode] nvarchar(500),
		[LocationCode] nvarchar(500),
		[LocationId] bigint,
		[IsDefault] bit,  
		[ModifiedBy] BIGINT
		)tmp1 

		--select * from #tmpChildCustomer
		--select * from #tmpParentCustList

		

		 select top 1 @UserId= #tmpCustList.ModifiedBy from #tmpCustList where isnull(#tmpCustList.ModifiedBy,0)!=0

		 Delete from CustomerPriority where dbo.CustomerPriority.ParentCompanyId= (select top 1 #tmpCustList.ParentCompanyId from #tmpCustList)

		 --UPDATE dbo.CustomerPriority
			--SET dbo.CustomerPriority.IsActive=0,dbo.CustomerPriority.ModifiedBy=#tmpCustList.[ModifiedBy],dbo.CustomerPriority.ModifiedDate=GETDATE()
			--FROM #tmpCustList
			--WHERE dbo.CustomerPriority.CompanyId=#tmpCustList.CompanyId
			--and dbo.CustomerPriority.ParentCompanyId=#tmpCustList.ParentCompanyId
	

			--UPDATE dbo.CustomerPriority
			--SET dbo.CustomerPriority.IsActive=1,dbo.CustomerPriority.[PriorityRating]=#tmpChildCustomer.[PriorityRating],dbo.CustomerPriority.ModifiedBy=#tmpChildCustomer.[ModifiedBy],dbo.CustomerPriority.ModifiedDate=GETDATE()
			--FROM #tmpChildCustomer 
			--WHERE dbo.CustomerPriority.CompanyId=#tmpChildCustomer.CompanyId
			--and dbo.CustomerPriority.ParentCompanyId=#tmpChildCustomer.ParentCompany
			--and isnull(#tmpChildCustomer.PriorityRating,'0')!='0'

		INSERT INTO [dbo].[CustomerPriority]
           ([ParentCompanyId]
		   ,[ParentCompanyCode]
           ,[CompanyId]
           ,[CompanyCode]
           ,[LocationId]
           ,[LocationCode]
		   ,[PriorityRating]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive])

		select 
		 tmpsp.[ParentCompanyId]
		,tmpsp.[ParentCompanyCode]
		,tmpsp.[CompanyId]
		,tmpsp.[CompanyMnemonic]
		,tmpsp.[LocationId]
		,tmpsp.[LocationCode]
		,isnull(tmpsp.[PriorityRating],0)
		,@UserId
		,GETDATE()
		,1
		FROM #tmpCustList tmpsp
		WHERE 

		--NOT EXISTS (SELECT CompanyId from dbo.[CustomerPriority] Dsp where Dsp.[CompanyId]=tmpsp.[CompanyId] and Dsp.ParentCompanyId=tmpsp.[ParentCompany] and isnull(Dsp.IsActive,'0')='1')and
		 isnull(tmpsp.PriorityRating,'0')!='0'



		

			truncate table #tmpCustList;

            SELECT @UserId as UserId FOR XML RAW('Json'),ELEMENTS

            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.[USP_UpdateManageCustomerB2BApp]'



