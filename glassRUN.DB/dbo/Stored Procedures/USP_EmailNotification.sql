CREATE PROCEDURE [dbo].[USP_EmailNotification]

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
            DECLARE @EmailNotificationId bigint
            UPDATE dbo.EmailNotification SET
        	[SupplierId]=tmp.SupplierId ,
        	[ObjectType]=tmp.ObjectType ,
        	[ObjectId]=tmp.ObjectId ,
        	[EventType]=tmp.EventType ,
        	[IsSent]=tmp.IsSent ,
        	[SenderId]=tmp.SenderId ,
        	[Message]=tmp.Message ,
        	[IsActive]=tmp.IsActive ,
        	[CreatedDate]=tmp.CreatedDate ,
        	[CreatedBy]=tmp.CreatedBy ,
        	[UpdatedDate]=tmp.UpdatedDate ,
        	[UpdatedBy]=tmp.UpdatedBy
            FROM OPENXML(@intpointer,'EmailNotification',2)
			WITH
			(
			[EmailNotificationId] BIGINT,
            [SupplierId] bigint,
            [ObjectType] nvarchar(50),
            [ObjectId] nvarchar(50),
            [EventType] nvarchar(150),
            [IsSent] bit,
            [SenderId] int,
            [Message] nvarchar(max),
            [IsActive] bit,
            [CreatedDate] datetime,
            [CreatedBy] bigint,
            [UpdatedDate] datetime,
            [UpdatedBy] bigint
            )tmp WHERE EmailNotification.[EmailNotificationId]=tmp.[EmailNotificationId]
            SELECT  @EmailNotificationId
            exec sp_xml_removedocument @intPointer
		END TRY
		BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
		END CATCH
END
