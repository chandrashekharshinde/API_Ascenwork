CREATE PROCEDURE [dbo].[DSP_PageWiseConfigurationById] --'<Json><ServicesAction>DeleteUserDimensionById</ServicesAction><UserDimensionMappingId>112</UserDimensionMappingId></Json>'
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

		
		Declare @userId nvarchar(20)
		Declare @pageId nvarchar(20)
		Declare @roleId nvarchar(20)

		SELECT 
			
			@pageId = tmp.[PageId],
			@userId = tmp.[UserId],
			@roleId = tmp.[RoleMasterId]
		FROM OPENXML(@intpointer,'Json',2)
		WITH
		(
			
			[UserId] nvarchar(20),
			[PageId] nvarchar(20),
			[RoleMasterId] nvarchar(20)

        )tmp ;
		
	
		Delete from [PageWiseConfiguration]
		
		WHERE ([PageId] = @pageId OR @pageId = '') and (UserId = @userId OR @userId = '')
  and (RoleId = @roleId OR @roleId = '')

		SELECT @pageId as pageId FOR XML RAW('Json'),ELEMENTS

	END TRY
	BEGIN CATCH
		SELECT @ErrMsg = ERROR_MESSAGE();
		RAISERROR(@ErrMsg, @ErrSeverity, 1);
		RETURN; 
	END CATCH
END
