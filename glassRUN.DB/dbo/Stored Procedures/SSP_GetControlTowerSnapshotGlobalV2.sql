
CREATE PROCEDURE [dbo].[SSP_GetControlTowerSnapshotGlobalV2]

AS

BEGIN


 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT 'true' AS [@json:Array] ,
	* from ControlTowerSnapshotGlobal
	where WorkFlowCode in (select top 1 WorkFlowCode from Workflow where IsActive = 1 and ProcessType = 4501)
	ORDER BY SequenceNo Asc
  FOR XML PATH('ControlTowerSnapshotGlobalList'),ELEMENTS,ROOT('ControlTowerSnapshotGlobal')) AS XML)
  

 end