CREATE  PROCEDURE [dbo].[USP_CompanyInsertAndUpdateFromJDE] --''

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

			SELECT * INTO #tmpCompany
			FROM OPENXML(@intpointer,'Json/CompanyList',2)
			 WITH
             (
		
			CompanyName nvarchar(500),			        
			CompanyMnemonic nvarchar(200),
			CompanyType  nvarchar(200),
			TaxId  nvarchar(250),
			Field1 nvarchar(250),
			Field9 nvarchar(250),
			Field8 nvarchar(250),
			ParentCompanyMnemonic nvarchar(250)
			 ) tmp

			 

			 select * from  #tmpCompany

PRINT N'Insert Company'

		INSERT INTO [dbo].[Company]
           ([CompanyName]
           ,[CompanyMnemonic]
		   ,[CompanyType]
		   ,TaxId
		   ,ParentCompany
		   , CountryId
		  -- ,Field1
		   ,IsActive
		   ,CreatedBy
		   ,CreatedDate

		  ,Field9
		  ,Field8
          )
    SELECT
			 #tmpCompany.CompanyName
			 , #tmpCompany.CompanyMnemonic
			 ,#tmpCompany.CompanyType
			  ,#tmpCompany.TaxId
			 ,(select top 1 CompanyId  from Company where CompanyType=23)
			 ,1
			-- ,#tmpCompany.Field1
			 ,1
			 ,1
			 ,GETDATE()

			 ,#tmpCompany.Field9
			 ,#tmpCompany.Field8
     FROM #tmpCompany LEFT JOIN dbo.Company c ON   #tmpCompany.[CompanyMnemonic]=c.CompanyMnemonic
	  	
	  	  WHERE c.CompanyId IS null


PRINT N'Update Company'


UPDATE  dbo.Company

SET CompanyName =#tmpCompany.[CompanyName],
TaxId =#tmpCompany.[TaxId],
CompanyType =#tmpCompany.[CompanyType],
--Field1=#tmpCompany.Field1,
Field9=#tmpCompany.Field9,
Field8=#tmpCompany.Field8,
ParentCompany  = (select top 1 CompanyId  from Company where CompanyType=23)

FROM #tmpCompany  LEFT JOIN dbo.Company c ON  #tmpCompany.[CompanyMnemonic]=c.CompanyMnemonic  WHERE c.CompanyId  IS not  null


		


			
        	
           SELECT 1 as CompanyId FOR XML RAW('Json'),ELEMENTS
           exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_ItemStock'
