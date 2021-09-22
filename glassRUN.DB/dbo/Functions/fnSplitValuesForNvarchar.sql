Create FUNCTION [dbo].[fnSplitValuesForNvarchar]
(
	@IDs nvarchar(max)
)
RETURNS 
@SplitValues TABLE 
(
	ID nvarchar(max)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	
	DECLARE @xml xml
	SET @xml = N'<root><r>' + replace(@IDs,',','</r><r>') + '</r></root>'

	INSERT INTO @SplitValues(ID)
	SELECT r.value('.','nvarchar(max)')
	FROM @xml.nodes('//root/r') as records(r)

	RETURN
END
