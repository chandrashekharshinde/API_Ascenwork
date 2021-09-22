Create PROCEDURE [dbo].[ISP_PrinterBranchPlantMapping] --'<Json><RequestDate>2017-10-26T00:00:00</RequestDate><EnquiryType>ST</EnquiryType><ShipTo>18</ShipTo><SoldTo>0</SoldTo><TruckSizeId>1</TruckSizeId><branchPlant>7</branchPlant><IsActive>true</IsActive><PreviousState>0</PreviousState><CurrentState>1</CurrentState><CreatedBy>2</CreatedBy><OrderProductList><ItemId>97</ItemId><ItemName>Affligem Blond 300x24B Ctn</ItemName><ProductCode>65801001</ProductCode><PrimaryUnitOfMeasure>0</PrimaryUnitOfMeasure><ProductQuantity>1</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>100</WeightPerUnit><IsActive>true</IsActive></OrderProductList><OrderProductList><ItemId>105</ItemId><ItemName>Desperados 330x12C Ctn</ItemName><ProductCode>65705131</ProductCode><PrimaryUnitOfMeasure>0</PrimaryUnitOfMeasure><ProductQuantity>3</ProductQuantity><ProductType>9</ProductType><WeightPerUnit>100</WeightPerUnit><IsActive>true</IsActive></OrderProductList></Json>'
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
			
                

		 INSERT INTO	[PrinterBranchPlantMapping]
        (
		   BranchPlantCode
		  ,DocumentType
		  ,PrinterName
		  ,PrinterPath		  
		  ,NumberOfCopies
		  ,CreatedBy
		  ,CreatedDate
		  ,[IsActive]
		
		  
        )

        SELECT
			tmp.[BranchPlantCode],
        	tmp.[DocumentType],
        	tmp.[PrinterName],
        	tmp.[PrinterPath],   
			tmp.[NumberOfCopies],
			tmp.[CreatedBy],     
			GETDATE(),	
        	1
			 	
        	
            FROM OPENXML(@intpointer,'Json/PrinterBranchPlantMappingList',2)
        WITH
        (
            [BranchPlantCode] nvarchar(50),
            [DocumentType] nvarchar(200),
            PrinterName nvarchar(200),
            [PrinterPath] nvarchar(max),
			[NumberOfCopies] bigint,
			CreatedBy bigint,
			CreatedDate datetime,
            [IsActive] bit
                 
            
            
        )tmp

		 DECLARE @PrinterBranchPlantMapping bigint
	    SET @PrinterBranchPlantMapping = @@IDENTITY

        --Add child table insert procedure when required.
    SELECT @PrinterBranchPlantMapping as PrinterBranchPlantMapping FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
