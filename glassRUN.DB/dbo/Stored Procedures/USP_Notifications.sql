-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Tuesday, September 19, 2017
-- Created By:   Nimish
-- Procedure to update entries in the dbo.Notifications table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_Notifications]

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
            DECLARE @NotificationsId bigint
            UPDATE dbo.Notifications SET
        	[NotificationType]=tmp.NotificationType ,
        	[Remarks]=tmp.Remarks ,     
        	
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
            FROM OPENXML(@intpointer,'Notifications',2)
			WITH
			(
            [NotificationsId] bigint,
           
            [NotificationType] nvarchar(200),
           
            [Remarks] nvarchar,
           
                  
         
           
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
           
            )tmp WHERE Notifications.[NotificationsId]=tmp.[NotificationsId]
            SELECT  @NotificationsId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_Notifications'
