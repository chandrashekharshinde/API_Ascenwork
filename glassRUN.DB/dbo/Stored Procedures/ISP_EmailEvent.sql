-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.EmailEvent table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_EmailEvent]-- '<Json><ServicesAction>SaveEmailEvent</ServicesAction><EmailEventList><EmailEventId>0</EmailEventId><EventName>test1</EventName><EventCode>00036</EventCode><Description>testdesc</Description><CreatedBy>12</CreatedBy><IsActive>true</IsActive></EmailEventList></Json>'
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

        INSERT INTO	[EmailEvent]
        (
        	[SupplierId],
        	[EventName],
        	[EventCode],
        	[Description],
        	[IsActive],
        	[CreatedBy],
        	[CreatedDate]
        
        )

        SELECT
        	tmp.[SupplierId],
        	tmp.[EventName],
        	tmp.[EventCode],
        	tmp.[Description],
        	tmp.[IsActive],
        	tmp.[CreatedBy],
        	GETDATE()
        
            FROM OPENXML(@intpointer,'Json/EmailEventList',2)
        WITH
        (
            [SupplierId] bigint,
            [EventName] nvarchar(500),
            [EventCode] nvarchar(50),
            [Description] nvarchar(250),
            [IsActive] bit,
            [CreatedBy] bigint,
            [CreatedDate] datetime
          
        )tmp
        
        DECLARE @EmailEvent bigint
	    SET @EmailEvent = @@IDENTITY
        
        --Add child table insert procedure when required.
    
  	SELECT @EmailEvent as EmailEvent FOR XML RAW('Json'),ELEMENTS
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
