CREATE PROC [dbo].[SSP_AllResources]
AS
BEGIN
	
	SELECT CAST((
	SELECT * FROM Resources
	FOR XML RAW('ResourcesList'), ELEMENTS, ROOT('Resources')) AS XML)
    

END
