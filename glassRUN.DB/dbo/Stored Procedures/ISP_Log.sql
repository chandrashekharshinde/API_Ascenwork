CREATE PROCEDURE [dbo].[ISP_Log]--'<Json><UserId>0</UserId><OrderId>0</OrderId><ServicesAction>CreateLog</ServicesAction><LogDescription>Empties Limit</LogDescription><LogDate>17/10/2017 13:41</LogDate></Json>'
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

        INSERT INTO	[Log]
        (
        	[UserId],
        	[ObjectId],
			[ObjectType],
        	[LogDescription],
        	[LogDate],
			[Source],
			[LoggingTypeId],
			[LogGuid],
        	[CreatedDate]
        )
        SELECT
        	tmp.[UserId],
        	tmp.[ObjectId],
			tmp.[ObjectType],
        	tmp.[LogDescription],
			tmp.[LogDate],
			tmp.[Source],
			tmp.[LoggingTypeId],
			tmp.[LogGuid],
        	GETDATE()
            FROM OPENXML(@intpointer,'Json',2)
        WITH
        (
            [UserId] BIGINT,
			[ObjectId] NVARCHAR(200),
			[ObjectType] NVARCHAR(200),
			[LogDescription] NVARCHAR(max),
            [LogDate] DATETIME,
			[Source] NVARCHAR(200),
			[LoggingTypeId] bigint,
			[LogGuid] NVARCHAR(200),
            [CreatedDate] DATETIME
        )tmp
        
        DECLARE @LogId BIGINT
	    SET @LogId = @@IDENTITY
        
        --Add child table insert procedure when required.
    
		SELECT @LogId as LogId FOR XML RAW('Json'),ELEMENTS
  
		EXEC sp_xml_removedocument @intPointer 	
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END