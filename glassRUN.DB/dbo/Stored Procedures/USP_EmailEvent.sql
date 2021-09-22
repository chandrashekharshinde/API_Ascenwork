-----------------------------------------------------------------
-- UPDATE BY PRIMARY KEY
-- Date Created: Monday, March 16, 2015
-- Created By:   Nimish
-- Procedure to update entries in the dbo.EmailEvent table
-----------------------------------------------------------------
 
CREATE PROCEDURE [dbo].[USP_EmailEvent] --'<Json><ServicesAction>SaveEmailEvent</ServicesAction><EmailEventList><EmailEventId>1</EmailEventId><EventName>CustomersNotification</EventName><UserName>CNE</UserName><Password>CustomerNotification</Password><CreatedBy>12</CreatedBy><IsActive>true</IsActive></EmailEventList></Json>'

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
            DECLARE @EmailEventId bigint
            UPDATE dbo.EmailEvent SET
			@EmailEventId=tmp.EmailEventId,
        	[SupplierId]=tmp.SupplierId ,
        	[EventName]=tmp.EventName ,
        	[EventCode]=tmp.EventCode ,
        	[Description]=tmp.Description ,
        	[IsActive]=tmp.IsActive ,
        	[UpdatedBy]=tmp.CreatedBy ,
        	[UpdatedDate]=GETDATE()
            FROM OPENXML(@intpointer,'Json/EmailEventList',2)
			WITH
			(
			[EmailEventId] BIGINT,
            [SupplierId] bigint,
            [EventName] nvarchar(500),
            [EventCode] nvarchar(50),
            [Description] nvarchar(250),
            [IsActive] bit,           
            [CreatedBy] bigint,
            [UpdatedDate] datetime
            )tmp WHERE EmailEvent.[EmailEventId]=tmp.[EmailEventId]
                        SELECT @EmailEventId as EmailEventId FOR XML RAW('Json'),ELEMENTS

            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END

PRINT 'Successfully created procedure dbo.USP_EmailEvent'
