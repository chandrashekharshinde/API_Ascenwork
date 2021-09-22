CREATE PROC [dbo].[SSP_GetPagesById]
(
@PageId BIGINT
)
AS
BEGIN
	
	SELECT CAST((
	SELECT * FROM dbo.Pages
	WHERE PageId=@PageId
	FOR XML RAW('PagesList'), ELEMENTS, ROOT('Pages')) AS XML)
    

END
