CREATE PROCEDURE [dbo].[USP_Company]

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
            DECLARE @CompanyId bigint
            UPDATE dbo.Company SET
        	[CompanyName]=tmp.CompanyName ,
        	[CompanyMnemonic]=tmp.CompanyMnemonic ,
			[CompanyType]=tmp.CompanyType,
			        	[AddressLine1]=tmp.AddressLine1 ,
        	[AddressLine2]=tmp.AddressLine2 ,
        	[AddressLine3]=tmp.AddressLine3 ,
        	[City]=tmp.City ,
        	[State]=tmp.State ,
        	[CountryId]=tmp.CountryId ,
        	[Postcode]=tmp.Postcode ,
        	[Region]=tmp.Region ,
        	[RouteCode]=tmp.RouteCode ,
        	[ZoneCode]=tmp.ZoneCode ,
        	[CategoryCode]=tmp.CategoryCode ,
        	[BranchPlant]=tmp.BranchPlant ,
        	[Email]=tmp.Email ,
        	[TaxId]=tmp.TaxId ,
        	[SoldTo]=tmp.SoldTo ,
        	[ShipTo]=tmp.ShipTo ,
        	[BillTo]=tmp.BillTo ,
        	[SiteURL]=tmp.SiteURL ,
        	[ContactPersonNumber]=tmp.ContactPersonNumber ,
        	[ContactPersonName]=tmp.ContactPersonName ,
        	[logo]=tmp.logo ,
        	[header]=tmp.header ,
        	[footer]=tmp.footer ,        	
        	[ModifiedBy]=tmp.ModifiedBy ,
        	[ModifiedDate]=tmp.ModifiedDate ,
        	[IsActive]=tmp.IsActive ,
        	[SequenceNo]=tmp.SequenceNo ,
        	[Field1]=tmp.Field1 ,
        	[Field2]=tmp.Field2 ,
        	[Field3]=tmp.Field3 ,
        	[Field4]=tmp.Field4 ,
        	[Field5]=tmp.Field5 ,
        	[Field6]=tmp.Field6 ,
        	[Field7]=tmp.Field7 ,
        	[Field8]=tmp.Field8 ,
        	[Field9]=tmp.Field9 ,
        	[Field10]=tmp.Field10
            FROM OPENXML(@intpointer,'Company',2)
			WITH
			(
            [CompanyId] bigint,
           
            [CompanyName] nvarchar(500),
           
            [CompanyMnemonic] nvarchar(200),

			[CompanyType] nvarchar(50),
           
            [AddressLine1] nvarchar,
           
            [AddressLine2] nvarchar,
           
            [AddressLine3] nvarchar,
           
            [City] nvarchar(100),
           
            [State] nvarchar(100),
           
            [CountryId] bigint,
           
            [Postcode] nvarchar(20),
           
            [Region] nvarchar(20),
           
            [RouteCode] nvarchar(20),
           
            [ZoneCode] nvarchar(20),
           
            [CategoryCode] nvarchar(20),
           
            [BranchPlant] nvarchar(200),
           
            [Email] nvarchar,
           
            [TaxId] nvarchar(200),
           
            [SoldTo] nvarchar(200),
           
            [ShipTo] nvarchar(200),
           
            [BillTo] nvarchar(200),
           
            [SiteURL] nvarchar(200),
           
            [ContactPersonNumber] nvarchar(20),
           
            [ContactPersonName] nvarchar(500),
           
            [logo] nvarchar,
           
            [header] nvarchar,
           
            [footer] nvarchar,
           
          
           
            [ModifiedBy] bigint,
           
            [ModifiedDate] datetime,
           
            [IsActive] bit,
           
            [SequenceNo] bigint,
           
            [Field1] nvarchar(500),
           
            [Field2] nvarchar(500),
           
            [Field3] nvarchar(500),
           
            [Field4] nvarchar(500),
           
            [Field5] nvarchar(500),
           
            [Field6] nvarchar(500),
           
            [Field7] nvarchar(500),
           
            [Field8] nvarchar(500),
           
            [Field9] nvarchar(500),
           
            [Field10] nvarchar(500)
           
            )tmp WHERE Company.[CompanyId]=tmp.[CompanyId]
            SELECT  @CompanyId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_Company'
