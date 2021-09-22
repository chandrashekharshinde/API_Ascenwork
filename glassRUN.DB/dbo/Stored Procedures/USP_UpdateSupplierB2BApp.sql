

-----------------------------------------------------------------

-- Date Created: 18-1-2019
-- Created By:   Vinod Yadav
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_UpdateSupplierB2BApp]-- '<Json><ServicesAction>UpadateSupplierDetailsB2BApp</ServicesAction><SupplierList><HierarchyId>2</HierarchyId><CompanyId>2</CompanyId><IsDefault>0</IsDefault><IsSelectedDefaultSupplier>false</IsSelectedDefaultSupplier><CompanyMnemonic>18160099</CompanyMnemonic><CompanyName>S02H-CT HOI NHAP PT DONG HUNG TAI HA NOI</CompanyName><ParentCompany>1</ParentCompany><IsSynced>0</IsSynced><ModifiedBy>4934</ModifiedBy></SupplierList><SupplierList><HierarchyId>2</HierarchyId><CompanyId>3</CompanyId><IsDefault>1</IsDefault><IsSelectedDefaultSupplier>true</IsSelectedDefaultSupplier><CompanyMnemonic>18160100</CompanyMnemonic><CompanyName>S02HY-CT HOI NHAP PT DONG HUNG-HUNG YEN</CompanyName><ParentCompany>1</ParentCompany><IsSynced>0</IsSynced><ModifiedBy>4934</ModifiedBy></SupplierList></Json>'

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
        DECLARE @UserId bigint;
	   SELECT * INTO #tmpdefaultsupplier
		FROM OPENXML(@intpointer,'Json/SupplierList',2)
			WITH
        (
		[CompanyId] bigint,
		[CompanyMnemonic] nvarchar(500),
		[ChildCompanyId] bigint,
		[ChildCompanyCode] nvarchar(500),
		[LocationCode] nvarchar(500),
		[LocationId] bigint,
		[IsDefault] bit,  
		[ModifiedBy] BIGINT
		)tmp 


			UPDATE dbo.defaultsupplier
			SET dbo.defaultsupplier.IsActive=0,dbo.defaultsupplier.ModifiedBy=#tmpdefaultsupplier.[ModifiedBy],dbo.defaultsupplier.ModifiedDate=GETDATE()
			FROM #tmpdefaultsupplier 
			WHERE dbo.defaultsupplier.CompanyId=#tmpdefaultsupplier.[ChildCompanyId]
			and dbo.defaultsupplier.IsActive=1 
			--and dbo.defaultsupplier.ParentCompanyId=#tmpdefaultsupplier.[CompanyId]

			--UPDATE dbo.defaultsupplier
			--SET dbo.defaultsupplier.IsActive=1,dbo.defaultsupplier.ModifiedBy=#tmpdefaultsupplier.[ModifiedBy],dbo.defaultsupplier.ModifiedDate=GETDATE()
			--FROM #tmpdefaultsupplier 
			--WHERE dbo.defaultsupplier.CompanyId=#tmpdefaultsupplier.[ChildCompanyId]
			----and dbo.defaultsupplier.ParentCompanyId=#tmpdefaultsupplier.[CompanyId]
			--and isnull(#tmpdefaultsupplier.IsDefault,'0')!='0'

			INSERT INTO [dbo].[DefaultSupplier]
           ([ParentCompanyId]
		   ,[ParentCompanyCode]
           ,[CompanyId]
           ,[CompanyCode]
           ,[LocationId]
           ,[LocationCode]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[IsActive])

		select 
		 tmpsp.[CompanyId]
		,tmpsp.[CompanyMnemonic]
		,tmpsp.[ChildCompanyId]
		,tmpsp.[ChildCompanyCode]
		,tmpsp.[LocationId]
		,tmpsp.[LocationCode]
		,tmpsp.[ModifiedBy]
		,GETDATE()
		,isnull(tmpsp.IsDefault,'0')
		FROM #tmpdefaultsupplier tmpsp
		WHERE 

		--NOT EXISTS (SELECT CompanyId from dbo.DefaultSupplier Dsp where Dsp.[CompanyId]=tmpsp.[ChildCompanyId] and Dsp.ParentCompanyId=tmpsp.[CompanyId] and isnull(Dsp.IsActive,'0')='1') and
		isnull(tmpsp.IsDefault,'0')!='0'



			select top 1 @UserId= #tmpdefaultsupplier.ModifiedBy from #tmpdefaultsupplier where isnull(#tmpdefaultsupplier.ModifiedBy,0)!=0

			truncate table #tmpdefaultsupplier;

            SELECT @UserId as UserId FOR XML RAW('Json'),ELEMENTS

            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_UpdateSupplierB2BApp'
