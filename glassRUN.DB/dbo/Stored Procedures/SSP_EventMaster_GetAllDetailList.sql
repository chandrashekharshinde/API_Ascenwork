
Create PROCEDURE [dbo].[SSP_EventMaster_GetAllDetailList] --'<Json><ServicesAction>LoadAllDriverList</ServicesAction></Json>'
(
@xmlDoc XML='<Json><CarrierId>0</CarrierId></Json>'
)
AS

BEGIN
DECLARE @intPointer INT;
declare @CarrierId bigint=0
EXEC sp_xml_preparedocument @intpointer OUTPUT,@xmlDoc;


	
	  


 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)
SELECT CAST((SELECT  'true' AS [@json:Array],EventMasterId,
EventCode	,
EventMasterId as Id,
EventCode as [Name] ,
EventDescription,
IsActive,
CreatedBy,
CreatedDate,
UpdatedBy,
UpdatedDate
  FROM EventMaster where IsActive = 1 
	FOR XML path('EventMasterList'),ELEMENTS,ROOT('Json')) AS XML)
END