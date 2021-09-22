CREATE PROCEDURE [dbo].[ISP_InsertFilePath] --'<Json><ServicesAction>InsertItem</ServicesAction><ItemList><ItemId>0</ItemId><ItemName>testItem</ItemName><ItemCode>test001</ItemCode><Price></Price><PrimaryUnitOfMeasure>11</PrimaryUnitOfMeasure><ProductType>9</ProductType><StockInQuantity>1500</StockInQuantity><CreatedBy>284</CreatedBy></ItemList></Json>'
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

        INSERT INTO	[FilePath]
        (
        	[FilePathName],
        	[FileType],        	        	
        	[IsActive]
        	
        )

        SELECT
        	tmp.[FilePathName],
        	tmp.[FileType],        	     	
        	1
        	
            FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            [FilePathName] nvarchar(500),
            [FileType] nvarchar(200),                
            [IsActive] bit
          
        )tmp
        
        DECLARE @FilePath bigint
	    SET @FilePath = @@IDENTITY



		





        
        --Add child table insert procedure when required.
     SELECT @FilePath as FilePathId FOR XML RAW('Json'),ELEMENTS
   
    
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
