CREATE PROCEDURE [dbo].[ISP_JdeBatchGenerator]
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @JdeBatchNumber BIGINT;
	

	INSERT INTO JdeBatchGenerator(BatchValue) VALUES ('')
	SELECT    @@IDENTITY

	
					
	DELETE FROM [dbo].[JdeBatchGenerator]   

END
