
CREATE PROCEDURE [dbo].[SSP_GetControlTowerSnapshotWorkflowStepRoleMappingV2] --3,507,1101
	@RoleId bigint,
	@UserId bigint,
	@CultureId bigint
AS

BEGIN

if(ISNULL((select UserId from ControlTowerSnapshotWorkflowStepRoleMapping where UserId = @userId and WorkFlowCode in (select top 1 WorkFlowCode from Workflow where IsActive = 1 and ProcessType = 4501)),'') = '')
Begin

 WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT 'true' AS [@json:Array] ,
	cfs.*, ISNULL(r.ResourceValue,'') as StatusDisplayName from ControlTowerSnapshotWorkflowStepRoleMapping cfs
	Left Join [Resources] r ON cfs.DisplayNameResourceKey = r.ResourceKey and r.CultureId = @CultureId
	where cfs.WorkFlowCode in (select top 1 WorkFlowCode from Workflow where IsActive = 1 and ProcessType = 4501)
	and cfs.RoleId = @RoleId and cfs.IsActive = 1
	ORDER BY cfs.SequenceNo Asc
  FOR XML PATH('ControlTowerSnapshotWorkflowStepRoleMappingList'),ELEMENTS,ROOT('ControlTowerSnapshotWorkflowStepRoleMapping')) AS XML)

End
else
Begin

	WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  select cast ((SELECT 'true' AS [@json:Array] ,
	cfs.*, ISNULL(r.ResourceValue,'') as StatusDisplayName from ControlTowerSnapshotWorkflowStepRoleMapping cfs
	Left Join [Resources] r ON cfs.DisplayNameResourceKey = r.ResourceKey and r.CultureId = @CultureId
	where cfs.WorkFlowCode in (select top 1 WorkFlowCode from Workflow where IsActive = 1 and ProcessType = 4501)
	and cfs.RoleId = @RoleId and cfs.UserId = @UserId and cfs.IsActive = 1
	ORDER BY cfs.SequenceNo Asc
  FOR XML PATH('ControlTowerSnapshotWorkflowStepRoleMappingList'),ELEMENTS,ROOT('ControlTowerSnapshotWorkflowStepRoleMapping')) AS XML)

End

end