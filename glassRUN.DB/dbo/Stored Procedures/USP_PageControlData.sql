Create PROCEDURE [dbo].[USP_PageControlData] --'<Json><ServicesAction>UpdatePickShift</ServicesAction><OrderId>13150</OrderId><PickupShift>3</PickupShift></Json>'
	(@xmlDoc XML)
AS
BEGIN
	DECLARE @intPointer INT;
	DECLARE @PageControlId BIGINT
	DECLARE @IsMandatory Bit
	DECLARE @ValidationExpression NVARCHAR(MAX)
	EXEC sp_xml_preparedocument @intpointer OUTPUT
		,@xmlDoc

	   SELECT @PageControlId = tmp.[PageControlId]
		,@IsMandatory = tmp.[IsMandatory]
		,@ValidationExpression = tmp.[ValidationExpression]

	    FROM OPENXML(@intpointer, 'Json', 2) WITH (
			[PageControlId] BIGINT
			,[IsMandatory] bit
			,[ValidationExpression] NVARCHAR (MAX)
			) tmp

	UPDATE PageControl
	SET IsMandatory = @IsMandatory,
	ValidationExpression=@ValidationExpression
	 WHERE  IsActive=1 and PageControlId = @PageControlId

    print @PageControlId 

	SELECT @PageControlId AS PageControlId
	FOR XML RAW('Json')
		,ELEMENTS
END