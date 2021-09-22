-----------------------------------------------------------------
-- INSERT STORED PROCEDURE
-- Date Created: Tuesday, September 19, 2017
-- Created By:   Nimish
-- Procedure to insert entries in the dbo.Notifications table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[ISP_Notifications]
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

        INSERT INTO	[Notifications]
        (
        	[NotificationType],
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
        	tmp.[NotificationType],
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
            FROM OPENXML(@intpointer,'Notifications',2)
        WITH
        (
            [NotificationType] nvarchar(200),
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
        
        DECLARE @Notifications bigint
	    SET @Notifications = @@IDENTITY
        
        --Add child table insert procedure when required.
    
    SELECT @Notifications
    exec sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
    SELECT @ErrMsg = ERROR_MESSAGE(); 
    RAISERROR(@ErrMsg, @ErrSeverity, 1); 
    RETURN; 
    END CATCH
END
