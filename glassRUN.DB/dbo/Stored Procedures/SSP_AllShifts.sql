
CREATE PROCEDURE [dbo].[SSP_AllShifts] --'<Json><ServicesAction>LoadAllDriverList</ServicesAction><CarrierId>664</CarrierId></Json>'
	(@xmlDoc XML = '<Json><ShiftCode>0</ShiftCode></Json>')
AS
BEGIN
	DECLARE @intPointer INT;
	DECLARE @ShiftCode NVARCHAR(50) = '0'

	EXEC sp_xml_preparedocument @intpointer OUTPUT
		,@xmlDoc

	SELECT @ShiftCode = tmp.ShiftCode
	FROM OPENXML(@intpointer, 'Json', 2) WITH ([ShiftCode] NVARCHAR(100)) tmp;

	WITH XMLNAMESPACES ('http://james.newtonking.com/projects/json' AS json) SELECT CAST (
		(
			SELECT 'true' AS [@json:Array]
				,ShiftCode
				,ShiftName
			FROM Shifts l
			WHERE l.IsActive = 1 AND @ShiftCode = 0
			ORDER BY cast(ShiftCode AS INT) ASC
			FOR XML path('ShiftsList')
				,ELEMENTS
				,ROOT('Json')
			) AS XML
		) END
		



