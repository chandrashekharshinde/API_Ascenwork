CREATE PROCEDURE [dbo].[USP_DeliveryLocation]

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
            DECLARE @DeliveryLocationId bigint
            UPDATE dbo.DeliveryLocation SET
        	[DeliveryLocationName]=tmp.DeliveryLocationName ,
        	[DeliveryLocationCode]=tmp.DeliveryLocationCode ,
        	[CompanyID]=tmp.CompanyID ,
        	[AddressLine1]=tmp.AddressLine1 ,
        	[AddressLine2]=tmp.AddressLine2 ,
        	[AddressLine3]=tmp.AddressLine3 ,
        	[AddressLine4]=tmp.AddressLine4 ,
        	[City]=tmp.City ,
        	[State]=tmp.State ,
        	[Pincode]=tmp.Pincode ,
        	[Country]=tmp.Country ,
        	[Email]=tmp.Email ,
        	[Parentid]=tmp.Parentid ,
        	[Capacity]=tmp.Capacity ,
        	[Safefill]=tmp.Safefill ,
        	[ProductCode]=tmp.ProductCode ,
        	[Description]=tmp.Description ,
        	[Remarks]=tmp.Remarks ,        
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
            FROM OPENXML(@intpointer,'DeliveryLocation',2)
			WITH
			(
            [DeliveryLocationId] bigint,
           
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
           
            )tmp WHERE DeliveryLocation.[DeliveryLocationId]=tmp.[DeliveryLocationId]
            SELECT  @DeliveryLocationId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
