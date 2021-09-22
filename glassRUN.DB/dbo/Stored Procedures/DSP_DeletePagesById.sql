CREATE PROC [dbo].[DSP_DeletePagesById]
(
@PageId BIGINT
)
AS
BEGIN
	
	UPDATE dbo.Pages
	SET IsActive=0
	WHERE PageId=@PageId

	SELECT @PageId AS PageId

END
