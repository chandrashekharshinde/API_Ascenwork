

CREATE PROCEDURE [dbo].[SSP_GridColumnConfiguration_List] --'<Json><ServicesAction>LoadGridColumnPagingList</ServicesAction><PageIndex>0</PageIndex><PageSize>50</PageSize><OrderBy></OrderBy><RoleId>3</RoleId><PageId>18</PageId><UserId>0</UserId><CultureId>1101</CultureId><ObjectId>2</ObjectId></Json>'
(
@xmlDoc XML
)
AS

BEGIN
WITH XMLNAMESPACES('http://james.newtonking.com/projects/json' AS json)  
select cast ((SELECT  'true' AS [@json:Array] , p.PageName,p.PageId,

  (select cast ((SELECT 'true' AS [@json:Array]  ,o.DisplayName,o.ControlName as ObjectName,o.PageControlId as ObjectId,p.PageName,
  
  (select cast ((SELECT 'true' AS [@json:Array]  ,NEWID() rowguid, rm.RoleName,rm.RoleMasterId,gcr.ObjectId , gccr.PageId,p.PageName,
  (Select count(GridColumnConfigurationId) from GridColumnConfiguration cuc
Where cuc.RoleId=rm.RoleMasterId and cuc.LoginId=0 and cuc.ObjectId=gcr.ObjectId and cuc.PageId=gccr.PageId) as ColumnCount


  ,(select cast ((SELECT 'true' AS [@json:Array]  ,NEWID() rowguid, gccu.RoleId,l.LoginId,gccu.PageId,gcu.ObjectId,l.name as Username,l.profileid,p.PageName,
    (Select count(GridColumnConfigurationId) from GridColumnConfiguration cuc
Where cuc.RoleId=gccu.RoleId and cuc.LoginId=l.LoginId and cuc.ObjectId=gcu.ObjectId and cuc.PageId=gccu.PageId) as ColumnCount

from GridColumnConfiguration gccu join GridColumn gcu on gccu.GridColumnId=gcu.GridColumnId
join [Login] l on l.loginid=gccu.loginid 
--join [Profile] gp on gp.profileid=l.profileid
where gccu.PageId=p.PageId and gcu.ObjectId=gcr.ObjectId and l.RoleMasterId=rm.RoleMasterId 
and gccu.RoleId=rm.RoleMasterId and  gcu.IsActive=1 and gccu.IsActive=1 and l.IsActive=1 
group by gccu.RoleId,l.LoginId,gccu.PageId,gcu.ObjectId,l.name,l.profileid
 FOR XML path('GridColumnUsersList'),ELEMENTS) AS xml))


  from GridColumnConfiguration gccr join RoleMaster rm on gccr.RoleId=rm.RoleMasterId
join GridColumn gcr on gcr.GridColumnId=gccr.GridColumnId
where gccr.PageId=p.PageId and gcr.ObjectId=o.PageControlId and  gcr.IsActive=1 and gccr.IsActive=1 and rm.IsActive=1 
group by rm.RoleName,rm.RoleMasterId,gcr.ObjectId, gccr.PageId
 FOR XML path('GridColumnRoleList'),ELEMENTS) AS xml)),'1' as isChecked
  
   from 
GridColumnConfiguration gcco join GridColumn gco on gcco.GridColumnId=gco.GridColumnId
join [PageControl] o on o.PageControlId=gco.ObjectId
where gcco.PageId=p.PageId and o.IsActive=1 and gcco.IsActive=1 and gco.IsActive=1 
group by o.DisplayName,o.ControlName,o.PageControlId
 FOR XML path('GridColumnObjectList'),ELEMENTS) AS xml))

from GridColumnConfiguration gccp join Pages p on gccp.PageId=p.PageId where gccp.IsActive=1 and p.IsActive=1
group by p.PageName,p.PageId
FOR XML PATH('GridColumnPageList'),ELEMENTS,ROOT('Json')) AS XML)

END