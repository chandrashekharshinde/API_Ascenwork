
CREATE PROCEDURE [dbo].[ISP_EventMaster]
@xmlDoc xml 
AS 
 BEGIN 
	SET ARITHABORT ON 
	DECLARE @ErrMsg NVARCHAR(2048) 
	DECLARE @ErrSeverity INT; 
	DECLARE @intPointer INT; 
	declare @eventCode nvarchar(max)
	SET @ErrSeverity = 15; 
	 DECLARE @EventMasterId bigint
	BEGIN TRY

		EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc
			
		select @eventCode=tmp.[EventCode]
 
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(

		[EventCode]nvarchar(50)

		)tmp

	if  not exists(select 1 from [EventMaster] where [EventCode] = @eventCode and IsActive=1)
    begin
	 INSERT INTO	[EventMaster]
		(
			[EventCode],
			[EventDescription],
			[IsActive],
			[CreatedBy],
			[CreatedDate]	
		)
		SELECT
			tmp.[EventCode],
			tmp.[EventDescription],
			tmp.[IsActive],
			tmp.[CreatedBy],
			GETDATE()
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[EventCode] nvarchar(50),
			[EventDescription] nvarchar(max),
			[IsActive] bit,
			[CreatedBy] bigint
		)tmp
        
      
		SET @EventMasterId = @@IDENTITY

		SELECT @EventMasterId as EventMasterId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer 		
	end
	else
	begin
	    set	@EventMasterId=-1;	
		SELECT @EventMasterId as EventMasterId FOR XML RAW('Json'),ELEMENTS
		exec sp_xml_removedocument @intPointer
     end
    END TRY
    BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE(); 
		RAISERROR(@ErrMsg, @ErrSeverity, 1); 
		RETURN; 
    END CATCH
END