CREATE PROCEDURE [dbo].[ISP_ShowCase] --'<Json><ServicesAction>SaveShowCase</ServicesAction><ShowCaseList><ShowCaseId>0</ShowCaseId><Type>4101</Type><ProductCode>65205012</ProductCode><ProductName>Heineken 330x24C Ctn Special</ProductName><FromDate>02/08/2019</FromDate><ToDate>02/08/2019</ToDate><SmallImage></SmallImage><BigImage></BigImage><Title>xzczcvxc</Title><Description>xcvxv</Description><RoleId>3</RoleId><UserId>507</UserId></ShowCaseList></Json>'
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
			
                

		 INSERT INTO	ShowCase
        (
		   [Type]
		  ,[ProductCode]
		  ,[ProductName]
		  		
		  ,[FromDate]
		  ,ToDate
		  ,SmallImage
		  ,BigImage
		  ,Description  
		  ,Title		  
		  ,[IsActive]
		  ,CreatedBy
		  ,CreatedDate
		
		  
        )

        SELECT
			tmp.[Type],
        	tmp.[ProductCode],
        	tmp.[ProductName],
        	tmp.[FromDate],   
			 tmp.ToDate,    
			 
			tmp.SmallImage,   
			tmp.BigImage,
			tmp.Description,
			tmp.Title,
        	1,
			tmp.UserId,
			GETDATE()
			 	
        	
            FROM OPENXML(@intpointer,'Json/ShowCaseList',2)
        WITH
        (
            [Type] bigint,
            [ProductCode] nvarchar(50),
			[ProductName] nvarchar(50),
			[FromDate] datetime,
            ToDate datetime,
			SmallImage nvarchar(max),
			BigImage nvarchar(max),
			Description nvarchar(500),
            Title nvarchar(200),			
            [IsActive] bit,
			UserId bigint,
			CreatedDate datetime
                 
            
            
        )tmp

		 DECLARE @ShowCase bigint
	    SET @ShowCase = @@IDENTITY

        --Add child table insert procedure when required.
    SELECT @ShowCase as ShowCase FOR XML RAW('Json'),ELEMENTS
   
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
