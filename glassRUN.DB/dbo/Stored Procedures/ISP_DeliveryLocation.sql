CREATE PROCEDURE [dbo].[ISP_DeliveryLocation]
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

        INSERT INTO	[DeliveryLocation]
        (
        	[DeliveryLocationName],
        	[DeliveryLocationCode],
        	[CompanyID],
        	[AddressLine1],
        	[AddressLine2],
        	[AddressLine3],
        	[AddressLine4],
        	[City],
        	[State],
        	[Pincode],
        	[Country],
        	[Email],
        	[Parentid],
        	[Capacity],
        	[Safefill],
        	[ProductCode],
        	[Description],
        	[Remarks],
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
        	tmp.[DeliveryLocationName],
        	tmp.[DeliveryLocationCode],
        	tmp.[CompanyID],
        	tmp.[AddressLine1],
        	tmp.[AddressLine2],
        	tmp.[AddressLine3],
        	tmp.[AddressLine4],
        	tmp.[City],
        	tmp.[State],
        	tmp.[Pincode],
        	tmp.[Country],
        	tmp.[Email],
        	tmp.[Parentid],
        	tmp.[Capacity],
        	tmp.[Safefill],
        	tmp.[ProductCode],
        	tmp.[Description],
        	tmp.[Remarks],
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
            FROM OPENXML(@intpointer,'DeliveryLocation',2)
        WITH
        (
            [DeliveryLocationName] nvarchar(200),
            [DeliveryLocationCode] nvarchar(200),
            [CompanyID] bigint,
            [AddressLine1] nvarchar(500),
            [AddressLine2] nvarchar(500),
            [AddressLine3] nvarchar(500),
            [AddressLine4] nvarchar(500),
            [City] nvarchar(50),
            [State] nvarchar(50),
            [Pincode] nvarchar(50),
            [Country] bigint,
            [Email] nvarchar(200),
            [Parentid] bigint,
            [Capacity] decimal(10, 2),
            [Safefill] decimal(10, 2),
            [ProductCode] nvarchar(100),
            [Description] nvarchar,
            [Remarks] nvarchar,
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
        
        DECLARE @DeliveryLocation bigint
	    SET @DeliveryLocation = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @DeliveryLocation
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
