CREATE PROCEDURE [dbo].[SSP_GetPropertiesByObjectName]
@objectName nvarchar(150)
AS
BEGIN
SELECT CAST((
SELECT   * FROM objectproperties op INNER JOIN object o on o.ObjectId=op.ObjectId WHERE o.ObjectName IN (@objectName)
  FOR XML RAW('ObjectPropertiesList'),ELEMENTS,ROOT('ObjectProperties')) AS XML)
  END
