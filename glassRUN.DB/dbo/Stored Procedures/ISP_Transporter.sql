CREATE PROCEDURE [dbo].[ISP_Transporter]
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

        INSERT INTO	[Transporter]
        (
        	[TransporterName],
        	[TransporterCode],
        	[TypeOfCarrier],
        	[AddressLine1],
        	[AddressLine2],
        	[AddressLine3],
        	[City],
        	[State],
        	[CountryId],
        	[Postcode],
        	[Region],
        	[RouteCode],
        	[BranchPlant],
        	[Email],
        	[SiteURL],
        	[ContactPersonNumber],
        	[ContactPersonName],
        	[logo],
        	[CreatedBy],
        	[CreatedDate],
        
        	[IsActive],
        	[SequenceNo],
        	[Field1],
        	[Field2],
        	[Field3],
        	[Field4],
        	[Field5],
        	[Field6],
        	[Field7],
        	[Field8],
        	[Field9],
        	[Field10]
        )

        SELECT
        	tmp.[TransporterName],
        	tmp.[TransporterCode],
        	tmp.[TypeOfCarrier],
        	tmp.[AddressLine1],
        	tmp.[AddressLine2],
        	tmp.[AddressLine3],
        	tmp.[City],
        	tmp.[State],
        	tmp.[CountryId],
        	tmp.[Postcode],
        	tmp.[Region],
        	tmp.[RouteCode],
        	tmp.[BranchPlant],
        	tmp.[Email],
        	tmp.[SiteURL],
        	tmp.[ContactPersonNumber],
        	tmp.[ContactPersonName],
        	tmp.[logo],
        	tmp.[CreatedBy],
        	tmp.[CreatedDate],
        
        	tmp.[IsActive],
        	tmp.[SequenceNo],
        	tmp.[Field1],
        	tmp.[Field2],
        	tmp.[Field3],
        	tmp.[Field4],
        	tmp.[Field5],
        	tmp.[Field6],
        	tmp.[Field7],
        	tmp.[Field8],
        	tmp.[Field9],
        	tmp.[Field10]
            FROM OPENXML(@intpointer,'Transporter',2)
        WITH
        (
            [TransporterName] nvarchar(500),
            [TransporterCode] nvarchar(200),
            [TypeOfCarrier] nvarchar(50),
            [AddressLine1] nvarchar,
            [AddressLine2] nvarchar,
            [AddressLine3] nvarchar,
            [City] nvarchar(100),
            [State] nvarchar(100),
            [CountryId] bigint,
            [Postcode] nvarchar(20),
            [Region] nvarchar(20),
            [RouteCode] nvarchar(20),
            [BranchPlant] nvarchar(200),
            [Email] nvarchar,
            [SiteURL] nvarchar(200),
            [ContactPersonNumber] nvarchar(20),
            [ContactPersonName] nvarchar(500),
            [logo] nvarchar,
            [CreatedBy] bigint,
            [CreatedDate] datetime,
           
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
        )tmp
        
        DECLARE @Transporter bigint
	    SET @Transporter = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @Transporter
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
