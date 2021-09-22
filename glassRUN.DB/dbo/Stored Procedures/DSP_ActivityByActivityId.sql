



CREATE PROCEDURE [dbo].[DSP_ActivityByActivityId] --'<Json><ServicesAction>DeleteUserDimensionById</ServicesAction><UserDimensionMappingId>112</UserDimensionMappingId></Json>'
(
	@xmlDoc XML
)
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

		Declare @ActivityId bigint
		Declare @StatusCode nvarchar(100)

		SELECT 
			@ActivityId = tmp.[ActivityId],
			@StatusCode = tmp.[StatusCode]

		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[ActivityId] bigint,
			[StatusCode] nvarchar(100)
        )tmp ;

	
		  Delete [Activity] where ActivityId = @ActivityId
		  Delete ActivityPossibleSteps where CurrentStatusCode = @StatusCode
		  Delete ActivityPreviousSteps where CurrentStatusCode = @StatusCode
		  Delete ActivityPrerequisiteSteps where CurrentStatusCode = @StatusCode
		  Delete ActivityFormMapping where StatusCode = @StatusCode


		SELECT @ActivityId as ActivityId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END