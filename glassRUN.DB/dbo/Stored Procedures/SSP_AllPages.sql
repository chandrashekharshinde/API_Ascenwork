CREATE PROC [dbo].[SSP_AllPages]
AS
BEGIN
	
	SELECT CAST((
	SELECT * FROM dbo.Pages
	FOR XML RAW('PagesList'), ELEMENTS, ROOT('Pages')) AS XML)
    

END
