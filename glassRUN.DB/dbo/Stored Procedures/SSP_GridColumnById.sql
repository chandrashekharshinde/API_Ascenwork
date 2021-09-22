CREATE PROCEDURE [dbo].[SSP_GridColumnById]

@xmlDoc XML
AS
BEGIN


DECLARE @intPointer INT;
Declare @gridColumnId bigint


EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc


SELECT @gridColumnId = tmp.[GridColumnId]
	   
FROM OPENXML(@intpointer,'Json',2)
			WITH
			(
			[GridColumnId] bigint
			)tmp ;


			
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json) 
SELECT CAST((SELECT  'true' AS [@json:Array] 
								,GridColumnId
								,ObjectId
								,PropertyName
								,PropertyType
								,IsControlField
								,ResourceKey
								,OnScreenDisplay
								,IsDetailsViewAvailable
								,IsSystemMandatory
								,Data1
								,Data2
								,Data3
								,IsActive
								,CreatedBy
								,CreatedDate
								,ModifiedBy
								,ModifiedDate
  FROM [GridColumn] WHERE [GridColumnId]=@gridColumnId
	FOR XML path('GridColumnList'),ELEMENTS,ROOT('GridColumn')) AS XML)
END