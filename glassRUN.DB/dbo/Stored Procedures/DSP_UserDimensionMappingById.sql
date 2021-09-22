



CREATE PROCEDURE [dbo].[DSP_UserDimensionMappingById] --'<Json><ServicesAction>DeleteUserDimensionById</ServicesAction><UserDimensionMappingId>112</UserDimensionMappingId></Json>'
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

		Declare @pageName nvarchar(200)
		Declare @userId bigint
		Declare @controlId bigint
		Declare @roleId bigint

		SELECT 
			@pageName = tmp.[PageName],
			@userId = tmp.[UserId],
			@controlId = tmp.[ControlId],
			@roleId = tmp.[RoleMasterId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			[PageName] nvarchar(200),
			[UserId] bigint,
			[ControlId] bigint,
			[RoleMasterId] bigint

        )tmp ;

	
		Update [UserDimensionMapping]
		SET 
			IsActive=0 
		where [PageName]=@pageName and UserId=@userId and ControlId=@controlId and RoleMasterId=@roleId 

		SELECT @pageName as UserDimensionMappingId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END