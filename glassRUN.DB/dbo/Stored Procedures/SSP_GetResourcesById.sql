CREATE PROC [dbo].[SSP_GetResourcesById]
(
@ResourceId BIGINT
)
AS
BEGIN
	
	SELECT CAST((
	SELECT * FROM Resources
	WHERE ResourceId=@ResourceId
	FOR XML RAW('ResourcesList'), ELEMENTS, ROOT('Resources')) AS XML)
    

END
