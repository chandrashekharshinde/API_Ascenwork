CREATE PROCEDURE [dbo].[SSP_WorkflowActivityConfiguration_List] --'<Json><ServicesAction>LoadGridColumnPagingList</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><RoleId>3</RoleId><PageId>18</PageId><UserId>0</UserId><CultureId>1101</CultureId><ObjectId>2</ObjectId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
select cast ((SELECT  'true' AS [@json:Array] , w.WorkFlowCode,w.WorkFlowName,w.WorkFlowId,

  (select cast ((SELECT 'true' AS [@json:Array]  ,NEWID() rowguid, rm.RoleName,rm.RoleMasterId,w.WorkFlowCode,w.WorkFlowName,w.WorkFlowId,
  (Select count(cuc.WorkflowActivityConfigurationId) from WorkflowActivityConfiguration cuc
Where cuc.RoleId=rm.RoleMasterId and cuc.LoginId=0 and cuc.WorkFlowCode=w.WorkFlowCode) as ColumnCount


  ,(select cast ((SELECT 'true' AS [@json:Array]  ,NEWID() rowguid, gccu.RoleId,l.LoginId,l.name as Username,l.profileid,w.WorkFlowCode,w.WorkFlowName,w.WorkFlowId,
  (Select count(cuc.WorkflowActivityConfigurationId) from WorkflowActivityConfiguration cuc
Where cuc.RoleId=gccu.RoleId and cuc.LoginId=l.LoginId and cuc.WorkFlowCode=w.WorkFlowCode) as ColumnCount

from WorkflowActivityConfiguration gccu join Workflow gcu on gccu.WorkFlowCode=gcu.WorkFlowCode
join [Login] l on l.loginid=gccu.loginid 
--join [Profile] gp on gp.profileid=l.profileid
where   l.RoleMasterId=rm.RoleMasterId 
and gccu.RoleId=rm.RoleMasterId and  gcu.IsActive=1 and gccu.IsActive=1 and l.IsActive=1 
group by gccu.RoleId,l.LoginId,gccu.WorkFlowCode,l.name,l.profileid
 FOR XML path('GridColumnUsersList'),ELEMENTS) AS xml)),'1' as isChecked


  from WorkflowActivityConfiguration gccr join RoleMaster rm on gccr.RoleId=rm.RoleMasterId
join Workflow gcr on gcr.WorkFlowCode=gccr.WorkFlowCode
where   gcr.IsActive=1 and gccr.IsActive=1 and rm.IsActive=1 
group by rm.RoleName,rm.RoleMasterId,gcr.WorkFlowCode
 FOR XML path('GridColumnRoleList'),ELEMENTS) AS xml)),'1' as isChecked

from WorkflowActivityConfiguration wac join Workflow w on wac.WorkFlowCode=w.WorkFlowCode
group by w.WorkFlowCode,w.WorkFlowName,w.WorkFlowId
FOR XML PATH('GridColumnPageList'),ELEMENTS,ROOT('Json')) AS XML)


END