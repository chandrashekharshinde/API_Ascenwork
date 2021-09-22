CREATE PROCEDURE [dbo].[ISP_SalesOrderNumberGenerator]
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @SalesOrderNumber BIGINT;
	

	INSERT INTO OrderNumberGenerator(Value) VALUES ('')
	
	
	
set  @SalesOrderNumber=@@IDENTITY

	
	--select right('0000'+Convert(nvarchar(250),@SalesOrderNumber),5)


	 SELECT right('0000'+Convert(nvarchar(250),@SalesOrderNumber),5) as SalesOrderGenerationNo FOR XML RAW('Json'),ELEMENTS
					
	DELETE FROM [dbo].[OrderNumberGenerator]   

END